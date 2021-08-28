((function_call
  name: (identifier) @_cdef_identifier
  arguments: (arguments (string content: _ @c)))
  (#eq? @_cdef_identifier "cdef"))

((function_call
  name: (dot_index_expression _ (identifier) @_cdef_identifier)
  arguments: (arguments (string content: _ @c)))
  (#eq? @_cdef_identifier "cdef"))

((function_call
  name: (method_index_expression _ (identifier) @_cdef_identifier)
  arguments: (arguments (string content: _ @c)))
  (#eq? @_cdef_identifier "cdef"))

((function_call
  name: (dot_index_expression) @_vim_cmd
  arguments: (arguments (string content: _ @vim)))
  (#eq? @_vim_cmd "vim.cmd"))

((function_call
  name: (dot_index_expression) @_vim_api_nvim_exec
  arguments: (arguments (string content: _ @vim)))
  (#eq? @_vim_api_nvim_exec "vim.api.nvim_exec"))

(comment) @comment
