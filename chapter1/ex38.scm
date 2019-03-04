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

(newline)
(define (d i)
    (if (= (remainder (- i 2) 3) 0)
        (* 2 (+ (/ (- i 2) 3) 1))
        1
    )
)

(define (compute-e)
    (+ 2
        (cont-frac
            (lambda (i) 1.0)
            d
            100
        )
    )
)
(display (compute-e))
