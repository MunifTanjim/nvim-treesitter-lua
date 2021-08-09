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

(comment) @comment
