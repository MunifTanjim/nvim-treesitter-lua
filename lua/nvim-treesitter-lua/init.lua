local M = {
  _initialized = false,
}

local project_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h:h")

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
    local query_name = vim.fn.fnamemodify(query_file, ":t:r")
    local query_content = table.concat(vim.fn.readfile(query_file), "\n")
    vim.treesitter.set_query("lua", query_name, query_content)
  end

  M._initialized = true
end

return M
