
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

(define (compute-pi precision)
    (* 4 (product term 1 next precision))
)
(display (compute-pi 1000))
(newline)
(newline)


; b
; write with a recursive process
(define (product-recursive term a next b)
    (if (> a b)
        1.0
        (* (term a) (product-recursive term (next a) next b))
    )
)
(define (compute-pi precision)
    (* 4 (product-recursive term 1 next precision))
)
(display (compute-pi 1000))
(newline)
