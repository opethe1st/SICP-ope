(define (cc amount coin-values)
    (cond   ((= amount 0) 1)
            ((or (< amount 0) (no-more? coin-values)) 0)
            (else
                (+
                    (cc
                        amount
                        (except-first-denomination coin-values)
                    )
                    (cc
                        (- amount (first-denomination coin-values))
                        coin-values
                    )
                )
            )
    )
)

(define (first-denomination denominations)
    (car denominations)
)

(define (except-first-denomination denominations)
    (cdr denominations)
)

(define (no-more? denominations)
    (null? denominations)
)


(display (cc 100 (list 50 25 10 5 1)))
