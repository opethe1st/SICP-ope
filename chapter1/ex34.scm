#lang racket

(define (f g)
    (g 2)
)

(f f)

; f expects its argument to tbe a function - so it will try to evaluate 2 as a function and fail

