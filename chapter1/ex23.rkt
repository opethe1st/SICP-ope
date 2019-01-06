(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime))
)

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (runtime) start-time))
    )
)

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
)


(define (search-for-primes start end)
; not done yetw
)
