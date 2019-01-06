#lang racket


(define (make-segment a b)
    (cons a b)
)

(define (start-segment segment)
    (car segment)
)

(define (end-segment segment)
    (cdr segment)
)

(define (make-point a b)
    (cons a b)
)

(define (x-point point)
    (car point)
)

(define (y-point point)
    (cdr point)
)

(define (average a b)
    (/ (+ a b) 2)
)
(define (midpoint-segment segment)
    (make-point
        (average (x-point (start-segment segment)) (x-point (end-segment segment)))
        (average (y-point (start-segment segment)) (y-point (end-segment segment)))
    )
)


(display (midpoint-segment (make-segment (make-point 0 0) (make-point 4 4))))
