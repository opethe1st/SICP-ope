#lang racket
; compute terms of the pascal triangle
(define (combination n r)
    (if (or (= n r) (= r 0))
        1
        (+ (combination (- n 1) (- r 1)) (combination (- n 1) r))
    )
)
; test
(display (= (combination 0 0) 1))
(newline)
(display (= (combination 1 1) 1))
(newline)
(display (= (combination 2 2) 1))
(newline)
(display (= (combination 5 1) 5))
(newline)
(display (= (combination 5 2) 10))
(newline)
(display (= (combination 5 3) 10))
(newline)
