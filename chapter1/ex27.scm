;; The given Carmichael numbers
;; 561, 1105, 1729, 2465, 2821, and 6601

(define (is-carmichael num)
    (is-carmichael-iter num (- num 1) #t)
)

(define (is-carmichael-iter a n ans)
    (cond   ((= n 1) ans)
            (else
                (is-carmichael-iter
                    a
                    (- n 1)
                    (and (fermat-test n a) ans)
                )
            )
    )
)

(define (fermat-test a n)
    (define (expmod base exp m)
        (cond   ((= exp 0) 1)
                ((even? exp)
                    (remainder
                        (square (expmod base (/ exp 2) m))
                        m
                    )
                )
                (else
                    (remainder
                        (* base (expmod base (- exp 1) m))
                        m
                    )
                )
        )
    )
    (= (expmod a n n) (remainder a n))
)

;; test that this fails for a real prime
(display (is-carmichael 57))
(newline)

;; test that this is true for carmichael numbers
(display (is-carmichael 561))
(newline)
(display (is-carmichael 1105))
(newline)
(display (is-carmichael 1729))
(newline)
(display (is-carmichael 2465))
(newline)
(display (is-carmichael 2821))
(newline)
(display (is-carmichael 6601))
(newline)
