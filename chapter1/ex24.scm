
; this checks for the primality of consecutive odd integers in a specified range
(define (search-for-primes a b)
    (define (odd? a)
        (= (remainder a b) 1)
    )

    (define (search-for-primes-in-odd-numbers a b)
        (define (test-prime-continue a b)
            (timed-prime-test a)
            (search-for-primes-in-odd-numbers (+ a 2) b)
        )
        (if (< a b) (test-prime-continue a b)
            "DONE a > b"
        )
    )
    (if (< a b)
        (if (odd? a) (search-for-primes-in-odd-numbers a b)
            (search-for-primes-in-odd-numbers (+ a 1) b)
        )
        "SEARCH COMPLETE"
    )
)


(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime))
)

(define (start-prime-test n start-time)
    (if (fast-prime? n 12)
        (report-prime (- (runtime) start-time))
        "NOT PRIME"
    )
)

(define (fast-prime? n times)
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
        (define (try-it a)
            (= (expmod a n n) a)
        )
        (try-it (+ 1 (random (- n 1))))
    )
    (cond   ((= times 0) #t)
            ((fermat-test n) (fast-prime? n (- times 1)))
            (else #t)
    )
)
(define (prime? n)
    (define (square n) (* n n))

    (define (divides? a b)
        (= (remainder b a) 0)
    )

    (define (find-divisor n test-divisor)
        (cond   ((> (square test-divisor) n) n)
                ((divides? test-divisor n) test-divisor)
                (else (find-divisor n (+ test-divisor 1)))
        )
    )
    (define (smallest-divisor n)
        (find-divisor n 2)
    )
    (cond   ((= n 1) #f)
            (else (= n (smallest-divisor n)))

    )
)

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  "TIME REPORTED"
)


(timed-prime-test 1000000033)
(timed-prime-test 10000000019)
(timed-prime-test 10000000033)

;; these were the times for finding the primes in ex22
;; 1000000033 *** .04999999999999999
;; 10000000019 *** .13999999999999996
;; 10000000033 *** .14


;; in this exercise
;; 1000000033 *** 0.
;; 10000000019 *** 0.
;; 10000000033 *** 0.%
;; it appears computers are really fast these days, can't draw any conclusions given these numbers
