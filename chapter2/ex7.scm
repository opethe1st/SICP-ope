; this is the data abstraction layer
(define (make-interval a b)
    (cons a b)
)

(define (lower-bound interval)
    (car interval)
)

(define (upper-bound interval)
    (cdr interval)
)

;sanity tests
(display
    (lower-bound
        (make-interval 1.2 2.2)
    )
)
(newline)
(display
    (upper-bound
        (make-interval 5.0 7.2)
    )
)
(newline)
