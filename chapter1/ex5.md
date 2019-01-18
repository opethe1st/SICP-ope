
(define (p) (p))
(define (test x y)
    (if (= x 0) 0 y)
)
In applicative order, both operands need to be evaluated - (p) gets evaluated forever
