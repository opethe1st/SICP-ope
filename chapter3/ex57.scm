
(define fibs
    (cons-stream 0
        (cons-stream 1
            (add-streams
                (stream-cdr fibs)
                fibs
            )
        )
    )
)

; to count the number of additions, I should use a modified version of add-streams that uses a modified addition, that counts the number of additions and performs like add, the compare the memoized version against the non-meoized one
