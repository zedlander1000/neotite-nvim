;; inherits: elixir
;; extends
(call
  target: (identifier) @id (#eq? @id "execute")
  (arguments
    (string
      (quoted_content) @injection.content
      (#set! injection.language "sql")
    )
  )
)
