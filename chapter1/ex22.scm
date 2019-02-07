
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
    (if (prime? n)
        (report-prime (- (runtime) start-time))
        "NOT PRIME"
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


(search-for-primes 1 100)

(search-for-primes 100000000 100000050)
(search-for-primes 1000000000 1000000050)
(search-for-primes 10000000000 10000000050)
(search-for-primes 100000000000 100000000050)

; yes the time data shows that the time is multiplied by sqrt(10) whenever the range is increased by 10
