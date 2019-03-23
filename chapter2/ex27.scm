
(define (my-reverse items)
    (if (pair? items)
        (reverse items)
        items
    )
)

(define (deep-reverse items)
    (if  (null? items)
            items
            (append
                (deep-reverse (cdr items))
                (list (my-reverse (car items)))
            )
    )
)


(define x (list (list 1 2) (list 3 4)))


(display x)
(newline)
(display (reverse x))
(newline)
(display
    (deep-reverse x)
)
(newline)
