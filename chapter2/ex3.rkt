#lang racket

(define (make-rect corner-point1 corner-point2)
    (cons diag1 diag2)
)

(define (get-length rect)
    ()
)

(define (get-width rect)
    ()
)

(define (area rect)
    (* (get-lenth rect) (get-width rect))
)

(define (perimeter rect)
    (* 2 (+ (get-length rect) (get-width rect)))
)
