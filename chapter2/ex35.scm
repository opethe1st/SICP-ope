

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op
            (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)


(define (count-leaves tree)
    (cond
        ((null? tree) tree)
        ((not (pair? tree)) 1)
        (else
            (accumulate
                +
                0
                (map
                    count-leaves
                    tree
                )
            )
        )
    )
)


(define x (list 1 (list 2 3 4) (list 5 6)))

(display
    (count-leaves x)
)
(newline)
