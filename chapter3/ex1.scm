

(define (make-accumulator initial-value)
    (lambda
        (x)
        (begin (set! initial-value (+ initial-value x)) initial-value)
    )
)

(define a1 (make-accumulator 0))
(a1 5)
(define a2 (make-accumulator 100))
(a2 5)
(a2 37)
(a2 91)
(a1 2)
(define A (make-accumulator 5))
(A 10)
(A 10)
