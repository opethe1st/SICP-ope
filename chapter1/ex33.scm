
(define (next x)
    (+ x 1)
)
(define (identity x) x)

(define (filtered-accumulate combiner null-value term a next b predicate)
    (define (term-or-null x)
        (if (predicate x)
            (term x)
            null-value
        )
    )
    (define (filtered-accumulate-iter a b res)
        (if (> a b)
            res
            (filtered-accumulate-iter
                (next a)
                b
                (combiner res (term-or-null a))
            )
        )
    )
    (filtered-accumulate-iter a b null-value)
)

(define (even? x)
    (= (remainder x 2) 0)
)
(display
    (filtered-accumulate + 0 identity 0 next 10 even?)
)
(newline)


; sum of primes in a given range
(filter-accumulate + 0 identity 0 next 10 prime?)

;; product of all positive integers less than n that's relatively prime to n
(define (product-of-relatively-prime n)
    (define (relatively-prime? x)
        (= (gcd x n) 1)
    )
    (filter-accumulate + 0 identity 0 next (- n 1) relatively-prime?)
)
