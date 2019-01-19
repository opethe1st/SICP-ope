
(define (p) (p))
(define (test x y)
    (if (= x 0) 0 y)
)
what happens when this
(test 0 (p))
is evaluated in an interpreter that uses normal order evaluation and one that uses applicative order

With applicative order, both operands need to be evaluated - (p) gets evaluated forever
With normal order, the expression is expanded to
(if (= 0 0) 0 (p))
since the condition is true - 0 is evaluated and then function terminates
