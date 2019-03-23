
(define (fringe items)
    (cond
        ((null? items) items)
        ((pair? items)
            (append
                (fringe (car items))
                (fringe (cdr items))
            )
        )
        (else (list items))
    )
)


; test
(define
    x
    (list (list 1 2) (list 3 4))
)

(display (fringe x))
(newline)
(display (fringe (list x x)))
(newline)
