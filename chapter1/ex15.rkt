#lang racket


(define (cube x)
    (* x x x)
)
(define a 0)
(define (p x)
    (set! a (+ a 1))
    (- (* 3 x) (* 4 (cube x)))
)
(define (sine angle)
    (if (not (> (abs angle) 0.1))
        angle
        (p (sine (/ angle 3.0)))
    )
)


(sine 12.15)
(display a)
; the answer is 5
; order of growth is ln(n)
