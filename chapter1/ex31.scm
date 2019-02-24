
(define (product term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* result (term a)))
        )
    )
    (iter a 1.0)
)

;; Factorial in terms of product
(define (factorial n)
    (define (identity x) x)
    (define (next x) (+ 1 x))
    (product identity 1 next n)
)

;; test factorial
(display (factorial 1))
(newline)
(display (factorial 3))
(newline)
(display (factorial 5))
(newline)

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
