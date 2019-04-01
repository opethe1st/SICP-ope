

(define (adjoin-set x s)
    (if (< x (car s))
        (cons x s)
        (cons (car s) (adjoin-set x (cdr s)))
    )
)


(adjoin-set 4 (list 1 2 3 4 5))
