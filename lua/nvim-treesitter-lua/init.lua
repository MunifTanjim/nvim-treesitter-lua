local M = {
  _initialized = false,
}

function M.setup(options)
  if M._initialized then
    return
  end

  options = options or {}

  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

  parser_config.lua = {
    install_info = {
      url = "https://github.com/MunifTanjim/tree-sitter-lua",
      files = { "src/parser.c", "src/scanner.c" },
      location = "tree-sitter-lua/lua",
      revision = "dd556e7ee04ce64cd4bb39cebf8edfdb818e5674",
    },
    maintainers = { "@MunifTanjim" },
  }

  local query_file_ignore_patterns = vim.tbl_map(function(name)
    return string.format("/%s/", string.gsub(name, "%-", "%%%-"))
  end, options.ignore_plugins or {
    "nvim-treesitter",
    "nvim-treesitter-textobjects",
    "refactoring.nvim",
  })

  vim.treesitter.config({
    query_file_ignore = function(patterns)
      for _, pattern in ipairs(query_file_ignore_patterns) do
        if not vim.tbl_contains(patterns, pattern) then
          table.insert(patterns, pattern)
        end
      end
      return patterns
    end,
  }, "lua")
end

return M
