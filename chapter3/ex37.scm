

(define (c+ x y)
    (let ((z (make-connector))
        (adder x y z)
        z
    )
)

(define (c* x y)
    (let ((z (make-connector))
        (multipier x y z)
        z
    )
)

(define (c- x y)
    (let ((z (make-connector))
        (adder y z x)
        z
    )
)
(define (c/ x y)
    (let ((z (make-connector))
        (multiper y z x)
        z
    )
)

(define (cv x)
    (let ((z (make-connector))
        (constant x z)
        z
    )
)
