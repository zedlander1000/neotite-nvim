;; inherits: elixir
;; extends
[
  (atom)
  (quoted_atom)
  (string)
  (keyword)
  (map)
] @spell
(dot) @nospell
(list (identifier) @spell)
(tuple (identifier) @spell)
(call
  target: (identifier) (#eq? "def")
  (arguments
    (call
      target: (identifier) @spell
      (arguments) @spell )
        ))
(call
  target: (identifier) (#eq? "def")
  (arguments (identifier) @spell)
  (do_block))
(call
  target: (identifier) @nospell (#eq? "defmodule")
  (arguments (alias) @spell))
(binary_operator
  left: (identifier) @spell)
(anonymous_function
  (stab_clause
    left: (arguments) @spell))
(unary_operator
  operand: (call
    target: (identifier)
    (arguments
      (binary_operator
        left: (call
          target: (identifier) @spell
          ))
    )))
