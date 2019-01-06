#lang racket


(define (product term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* result (term a)))
        )
    )
    (iter a 1.0)
)

(define (term x)
    (define (double x)
        (* x 2)
    )
    (define (square x)
        (* x x)
    )
    (/ (* (double x) (double (+ x 1))) (square (+ (double x) 1)))
)

(define (next x)
    (+ x 1)
)
(define (compute-pi precision)
    (* 4 (product term 1 next precision))
)
(compute-pi 1000)
