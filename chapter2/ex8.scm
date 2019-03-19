
(define (make-interval a b)
    (cons a b)
)

(define (lower-bound interval)
    (car interval)
)

(define (upper-bound interval)
    (cdr interval)
)

(define (add-interval x y)
    (make-interval  (+ (lower-bound x) (lower-bound y))
                    (+ (upper-bound x) (upper-bound y))
    )
)
(define (sub-interval x y)
    (add-interval
        x
        (make-interval
            (- (upper-bound y))
            (- (lower-bound y))
        )
    )
)


(display
    (sub-interval
        (make-interval 5.8 6.2)
        (make-interval 0.8 1.2)
    )
)
