;; extends

((tag
  (start_tag
      (tag_name) @tag_name (#eq? @tag_name "script"))
  (text)
  (end_tag)
) @injection.content
 (#offset! @injection.content 1 0 0 -9)
 (#set! injection.language "javascript")
 (#set! injection.include-children)
 (#set! injection.combined)
)

((tag
  (start_tag
      (tag_name) @tag_name (#eq? @tag_name "style"))
  (text)
  (end_tag)
) @injection.content
 (#offset! @injection.content 1 0 0 -9)
 (#set! injection.language "css")
 (#set! injection.include-children)
 (#set! injection.combined)
)
