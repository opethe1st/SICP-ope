
(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)
    )
)

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001)
)

(define (improve guess x)
    (display guess)
    (newline)
    (average guess (/ x guess))
)

(define (average x y)
    (/ (+ x y) 2)
)


(define (square x) (* x x))
(define (sqrt x) (sqrt-iter 1.0 x))

;(sqrt 10000000000000)
; the above doesn't work because the number has a limited precision and the approximation doesn't keep tending to zero.

;; below is a new good enough that uses relative magnitude of error instead of absolute

(define (relative-good-enough? guess x)
    (< (abs (- (square guess) x)) (* 0.000001 x))
)
(define (relative-sqrt-iter guess x)

    (if (relative-good-enough? guess x)
        guess
        (relative-sqrt-iter (improve guess x) x)
    )
)
(define (relative-sqrt x) (relative-sqrt-iter 1.0 x))

(display
    (square (relative-sqrt 0.9))
)
