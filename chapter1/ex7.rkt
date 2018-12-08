#lang racket


(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)
    )
)

(define (improve guess x) (average guess (/ x guess)))

(define (average x y) (/ (+ x y) 2))

(define (good-enough? guess x)
(< (abs (- (square guess) x)) 0.001))

(define (square x) (* x x))
(define (sqrt x) (sqrt-iter 1.0 x))

;; This fails spectacularly because the correctness required is too large compared to the answer
; (display (square (sqrt 0.000000000009)))

;;(display (square (sqrt 10000000000000))) ;; seems at 10^13 it starts to take forever? Cos of the number overflows? Nothing so far that mentions
;; the precision of numbers in lisp

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
