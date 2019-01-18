; Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

(define (largest_number a b c)
    (cond   ((and (> a b) (> a c)) a)
            ((and (> b a) (> b c)) b)
            (else c)
    )
)
(define (second_largest_number a b c)
    (cond   ((and (> a b) (> b c)) b)
            ((and (> b a) (> a c)) a)
            (else c)
    )
)
(define (square x) (* x x))

(define (sum_of_squares_top_two a b c)
    (+ (square (largest_number a b c)) (square (second_largest_number a b c)))
)
;; testing
(sum_of_squares_top_two 5 12 1)
