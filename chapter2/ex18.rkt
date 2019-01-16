#lang racket


(define (reverse items)
    (cond   ((null? items) null)
            ((null? (cdr items)) (car items))
            (cons (reverse (cdr items)) (car items)) ; should be apppend actually but I dont know this doesn't work
    )
)

(display (reverse (list 123 1)))

(newline)

(display (car (list 124 53 5)))
