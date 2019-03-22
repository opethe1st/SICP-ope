
(define (same-parity . items)
    (define (same-parity-with-num num items2)
        (cond   ((null? items2) items2)
                ((= (remainder
                        (- num (car items2))
                        2
                    )
                    0
                 )
                    (cons
                        (car items2)
                        (same-parity-with-num num (cdr items2))
                    )
                )
                (else (same-parity-with-num num (cdr items2)))
        )
    )
    (same-parity-with-num (car items) items)
)


; test

(display
    (same-parity 1 2 3 4 5 6 7)
)
(newline)
(display
    (same-parity 2 3 4 5 6 7)
)
