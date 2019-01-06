#lang racket

(define (smallest-divisor n)
    (find-divisor n 2)
)

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
    (else (find-divisor n (+ test-divisor 1))))
)
(define (square n) (* n n))
(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
    (= n (smallest-divisor n))
)

(define (runtime) (current-milliseconds))

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime))
)

(define (start-prime-test n start-time)
    (when (prime? n)
        (report-prime (- (runtime) start-time))
    )
)

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
)

(define (even? num)
    (if (= (remainder num 2) 0)
        #t
        #f
    )
)

(define (odd? num)
    (not (even? num))
)

(define (search-for-primes start end)
    (cond   ((and (odd? start) (<= start end))
                (timed-prime-test start)
                (search-for-primes (+ start 2) end)
            )
            ((and (even? start) (<= start end))
                (timed-prime-test start)
                (search-for-primes (+ start 1) end)
            )
    )
)

; (define (find-n-smallest-primes-more-than-m m n)
;     (when (> n 0)
;         ()
;         ((find-n-smallest-primes-more-than-m m (- n 1)))
;     )
; )
