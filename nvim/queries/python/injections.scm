; (block
;     (expression_statement
;         (string
;             (string_start)
;             (string_content) 
;             (string_end)
;             @injection.content 
;             (#set! injection.language "markdown")
;         )
;     )
; )

((string_content) @injection.content
 (#set! injection.language "markdown"))
