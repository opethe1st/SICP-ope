(define (make-interval a b)
    (cons a b)
)

(define (lower-bound interval)
    (car interval)
)

(define (upper-bound interval)
    (cdr interval)
)

(define (mul-interval x y)
    (let    ((p1 (* (lower-bound x) (lower-bound y)))
            (p2 (* (lower-bound x) (upper-bound y)))
            (p3 (* (upper-bound x) (lower-bound y)))
            (p4 (* (upper-bound x) (upper-bound y)))
            )
            (make-interval
                (min p1 p2 p3 p4)
                (max p1 p2 p3 p4)
            )
    )
)

(define (div-interval x y)
    (if (or (= (lower-bound y) 0)
            (= (upeer-bound y) 0)
        )
        (error "Undefined to have the bounds of the interval set to Zero")
    )
    (mul-interval
        x
        (make-interval
            (/ 1.0 (upper-bound y))
            (/ 1.0 (lower-bound y))
        )
    )
)

(display (div-interval
            (make-interval 2 4)
            (make-interval 0 9)
        )
)
