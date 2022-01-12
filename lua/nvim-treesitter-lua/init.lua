local project_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h:h")

local M = {
  _initialized = false,
}

local query_content_by_name = {}

local function read_file(filename)
  local file, err = io.open(filename, "r")
  if not file then
    error(err)
  end
  local content = file:read("*a")
  io.close(file)
  return content
end

---@param name string query name
---@return string
function M.get_query(name)
  return query_content_by_name[name] or ""
end

---@overload fun(filepath: string, mode?: "'append'"|"'prepend'"|"'replace'")
---@overload fun(name: string, content: string, mode?: "'append'"|"'prepend'"|"'replace'")
---@param name string query name or absolute filepath
---@param content string query content
---@param mode? "'append'"|"'prepend'"|"'replace'"
---@return string
function M.set_query(name, content, mode)
  if string.sub(name, 0, 1) == "/" then
    mode = content
    content = read_file(name)
    name = vim.fn.fnamemodify(name, ":t:r")
  end

  mode = mode or "append"

  if mode == "prepend" then
    query_content_by_name[name] = content .. "\n" .. M.get_query(name)
  elseif mode == "replace" then
    query_content_by_name[name] = content
  else
    query_content_by_name[name] = M.get_query(name) .. "\n" .. content
  end

  vim.treesitter.set_query("lua", name, M.get_query(name))

  return M.get_query(name)
end

function M.setup()
  if M._initialized then
    return
  end

  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

  parser_config.lua = {
    install_info = {
      url = "https://github.com/MunifTanjim/tree-sitter-lua",
      files = { "src/parser.c", "src/scanner.c" },
      location = "tree-sitter-lua/lua",
      revision = "a5fc8b29c5c74fe016f4da71badb9476277b5146",
    },
    maintainers = { "@MunifTanjim" },
  }

  local query_files = vim.fn.globpath(project_path, "queries/lua/**", nil, true)

  for _, query_file in ipairs(query_files) do
    M.set_query(query_file)
  end

  M._initialized = true
end

return M
