; write one that generates a iterative process
(define (cont-frac n d k)
    (define (cont-frac-iter i result)
        (if (= i 0)
            result
            (cont-frac-iter
                (- i 1)
                (/  (n i)
                    (+ (d i) result)
                )
            )
        )
    )
    (cont-frac-iter k 0)
)

(define (n-func-gen x)
    (define (n-func i)
        (if (= i 1)
            x
            (- (* x x))
        )
    )
    n-func
)

(define (d-func i)
    (- (* 2 i) 1)
)


(define (tan-cf x k)
    (cont-frac
            (n-func-gen x)
            d-func
            k
        )
)

(display (tan-cf 1 2))
