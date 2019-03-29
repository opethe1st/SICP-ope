

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
    (make-vector
        (+ (x-cor-vectv1) (x-cor-vectv2))
        (+ (y-cor-vectv1) (y-cor-vectv2))
    )
)

(define (sub-vect v1 v2)
    (make-vect
        (- (x-cor-vectv1) (x-cor-vectv2))
        (- (y-cor-vectv1) (y-cor-vectv2))
    )
)

(define (scale-vect s v)
    (make-vect
        (* s (x-cor-vectv))
        (* s (y-cor-vectv))
    )
)


(define (make-segment v1 v2)
    (cons v1 v2)
)

(define (start-segment segment)
    (car segment)
)

(define (end-segment)
    (cdr segment)
)
