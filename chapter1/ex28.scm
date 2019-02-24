(define (square n)
    (* n n)
)

(define (square-or-zero-if-non-trivial-root-of-zero num m)
    (define square-of-num (remainder (square num) m))
    (if (and
            (= square-of-num 1)
            (not (= num 1))
            (not (= num -1))
        )
        0
        square-of-num
    )
)
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
(define (fermat-test n)
    (define (try-it a n)
        (define res (expmod a (- n 1) n))
        (cond   ((= res 0) #f)
                ((= res 1) #t)
                (else #f)
        )
    )
    (try-it (+ 1 (random (- n 1))) n)
)

(define (fast-prime? n times)
    (cond   ((= times 0) #t)
            ((fermat-test n) (fast-prime? n (- times 1)))
            (else #f)
    )
)


(define (prime? n)
    (fast-prime? n 50)
)

;; known primes
(display (prime? 7))
(newline)
(display (prime? 97))
(newline)

;; known composites
(display (prime? 15))
(newline)
(display (prime? 21))
(newline)

;;carmichael numbers
(display (prime? 561))
(newline)
(display (prime? 1105))
(newline)
(display (prime? 1729))
(newline)
