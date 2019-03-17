
(define (power a n)
    (define (iter product i)
        (if (= i 0)
            product
            (iter (* a product) (- i 1))
        )
    )
    (iter 1 n)
)


(define (cons a b)
    (*  (power 2 a)
        (power 3 b)
    )
)

(define (car pair)
    (define (iter pair power-of-two)
        (if (= (remainder pair 2) 0)
            (iter (/ pair 2) (+ power-of-two 1))
            power-of-two
        )
    )
    (iter pair 0)
)

(define (cdr pair)
    (define (iter pair power-of-two)
        (if (= (remainder pair 3) 0)
            (iter (/ pair 3) (+ power-of-two 1))
            power-of-two
        )
    )
    (iter pair 0)
)

; tests

(display (= (car (cons 2 3)) 2))
(newline)
(display (= (cdr (cons 2 3)) 3))
(newline)
(display (= (car (cons 0 3)) 0))
(newline)
(display (= (cdr (cons 3 0)) 0))
(newline)
(display (= (cdr (cons 3 6)) 6))
(newline)
