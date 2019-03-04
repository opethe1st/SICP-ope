
(define (cont-frac n d k)
    (define (cont-frac-iter n d k counter)
        (define i (- k counter))
        (if (= i k)
            (/ (n i) (d i))
            (/ (n i) (+ (d i) (cont-frac-iter n d k (- counter 1))))
        )
    )
    (cont-frac-iter n d k k)
)


(display    (cont-frac
                (lambda (i) 1.0)
                (lambda (i) 1.0)
                100
            )
)


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
(display    (cont-frac
                (lambda (i) 1.0)
                (lambda (i) (1.0))
                100
            )
)
