((function_call
  name: (identifier) @_cdef_identifier
  arguments: (arguments (string) @c (#offset! @c 0 2 0 -2)))
  (#eq? @_cdef_identifier "cdef"))

((function_call
  name: (dot_index_expression _ (identifier) @_cdef_identifier)
  arguments: (arguments (string) @c (#offset! @c 0 2 0 -2)))
  (#eq? @_cdef_identifier "cdef"))

((function_call
  name: (method_index_expression _ (identifier) @_cdef_identifier)
  arguments: (arguments (string) @c (#offset! @c 0 2 0 -2)))
  (#eq? @_cdef_identifier "cdef"))

(comment) @comment
