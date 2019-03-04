(define tolerance 0.00001)
(define dx 0.00001)
(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance)
    )
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next)
            )
        )
    )
    (try first-guess)
)
(define (newton-transform g)
    (define (deriv g)
        (lambda (x)
            (/
                (-
                    (g (+ x dx))
                    (g x)
                )
                dx
            )

        )
    )
    (lambda (x)
        (-
            x
            (/
                (g x)
                ((deriv g) x)
            )
        )
    )
)


(define (cubic a b c)
    (define (cube x) (* x x x))
    (define (square x) (* x x))
    (lambda (x)
        (+ (cube x) (* a (square x)) (* b x) c)
    )
)

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess)
)

(display (newtons-method (cubic 3 3 1) 1))
(newline)
(display (newtons-method (cubic 3 3 1) 12))
