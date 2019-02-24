
; recursive process

(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner
            (accumulate combiner null-value term (next a) next b)
            (term a)
        )
    )
)

(define (next a) (+ a 1))
(define (identity a) a)
(display
    (accumulate + 0 identity 0 next 5)
)
(newline)
(display
    (accumulate * 1 identity 1 next 5)
)
(newline)
(newline)

; iterative process

(define (accumulate combiner null-value term a next b)
    (define (accumulate-iter a b res)
        (if (> a b)
            res
            (accumulate-iter (next a) b (combiner res (term a)))
        )
    )
    (accumulate-iter a b null-value)
)

(display
    (accumulate + 0 identity 0 next 5)
)
(newline)
(display
    (accumulate * 1 identity 1 next 5)
)
(newline)

