

(define (make-vect x y)
    (cons x y)
)

(define (x-cor-vect vec)
    (car vec)
)

(define (y-cor-vect vec)
    (cdr vec)
)

(define (add-vect v1 v2)
    (make-vect
        (+ (x-cor-vect v1) (x-cor-vect v2))
        (+ (y-cor-vect v1) (y-cor-vect v2))
    )
)

(define (sub-vect v1 v2)
    (make-vect
        (- (x-cor-vect v1) (x-cor-vect v2))
        (- (y-cor-vect v1) (y-cor-vect v2))
    )
)

(define (scale-vect s v)
    (make-vect
        (* s (x-cor-vect v))
        (* s (y-cor-vect v))
    )
)
