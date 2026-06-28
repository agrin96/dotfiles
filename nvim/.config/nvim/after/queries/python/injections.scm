; extends

((string
  (string_content) @injection.content)
  (#set! injection.language "sql")
  (#match? @injection.content "^[ \t\r\n]*--\\s*sql"))

; This is for a keyword match - but it gets too noisy.
; ((string
;   (string_content) @injection.content)
;   (#set! injection.language "sql")
;   (#match? @injection.content "^[ \t\r\n]*(SELECT|INSERT|UPDATE|DELETE|WITH|CREATE|ALTER|DROP)>"))
