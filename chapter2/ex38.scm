(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op
            (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)

(define fold-right accumulate)

(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest)) (cdr rest))
        )
    )
    (iter initial sequence)
)


(display
    (fold-right / 1 (list 1 2 3))
) ; this should be 3/2
(newline)
(display
    (fold-left / 1 (list 1 2 3))
) ; this should be 1/6
(newline)
(display
    (fold-right list '() (list 1 2 3))
) ; this should be ( 1 (2 (3 '()))
(newline)
(display
    (fold-left list '() (list 1 2 3))
) ; this should be (((() 1) 2) 3)
(newline)
