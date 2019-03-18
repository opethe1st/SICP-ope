
(define (make-interval a b)
    (cons a b)
)

(define (lower-bound interval)
    (car interval)
)

(define (upper-bound interval)
    (cdr interval)
)


(define (sub-interval a b)
    (make-interval
        (- (lower-bound a) (upper-bound b))
        (- (upper-bound a) (lower-bound b))
    )
)


(display
    (sub-interval
        (make-interval 5.8 6.2)
        (make-interval 0.8 1.2)
    )
)
