#Exercise 1.6

(define (new-if predicate then else)
    (cond   (predicate then)
            (else else-clause)
    )
)

Goes into an infinite loop, because it keeps trying to evaluate the if and else clauses - this never stops the function is recursive
