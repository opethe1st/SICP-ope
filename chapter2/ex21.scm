
(define (square x) (* x x))

(define (square-list items)
    (if (null? items)
        items
        (cons
            (square (car items))
            (square-list (cdr items))
        )
    )
)


(display (square-list (list 1 2 3 4 5 6 7 12)))
(newline)

(define (map proc items)
    (if (null? items)
        items
        (cons
            (proc (car items))
            (map proc (cdr items))
        )
    )
)

(define (square-list items)
    (map (lambda (x) (* x x)) items)
)
(display (square-list (list 1 2 3 4 5 6 7 12)))
(newline)
