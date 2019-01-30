
(define (smallest-divisor n)
    (define (find-divisor n test-divisor)
        (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1))))
    )
    (define (square n) (* n n))
    (define (divides? a b) (= (remainder b a) 0))

    (find-divisor n 2)
)




(display (smallest-divisor 199))
(newline)
(display (smallest-divisor 1999))
(newline)
(display (smallest-divisor 19999))
