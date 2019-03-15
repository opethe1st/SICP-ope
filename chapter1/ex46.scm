

(define (iterative-improve good-enough? improve-guess)
    (define (f x)
        (if (good-enough? x)
            x
            (f (improve-guess x))
        )
    )
    f
)

(define (square-root x)

    (
        (iterative-improve
            (lambda (guess) (< (- (* guess guess) x) 0.00001))
            (lambda (guess) (/ (+ guess (/ x guess)) 2))
        )
        x
    )
)

(display (square-root 2.0))
(newline)
(display (square-root 4.0))
(newline)
(display (square-root 81.0))
(newline)
