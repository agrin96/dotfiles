; This doesn't work because python docstrings are indented markdown which
; doesn't get rendered corrently by the markdown engine
; ((string_content) @injection.content
;  (#set! injection.language "markdown"))


; Render python multiline string arguments as SQL. Helps with inline queries
((expression_statement
   (call
    arguments: 
        (argument_list
            (string
              (string_start)
              ((string_content) @injection.content
                (#set! injection.language "sql")))))))
