
(define (sum term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (+ result (term a)))
        )
    )
    (iter a 0)
)

(define (term x)
    x
)

(define (next x)
    (+ x 1)
)
(display (sum term 1 next 5))
