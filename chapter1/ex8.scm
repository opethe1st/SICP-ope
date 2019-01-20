(define (cube-root x)

    (define (cube x)
        (* x x x)
    )

    (define (improve-guess x y)
        (/ (+ (/ x (* y y)) (* 2 y)) 3)
    )

    (define (close-enough value expected)
        (<
            (abs
                (- expected value)
            )
            (* 00000000000.1 expected)
        )
    )
    (define (cube-root-iter x guess)
        (if (close-enough (cube guess) x)
            guess
            (cube-root-iter x (improve-guess x guess))
        )
    )
    (cube-root-iter x 1.0)
)

;; Test
(display (cube-root 8))
