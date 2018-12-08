#lang racket

;; iterative
(define (f n)
    (if (< n 3)
        n
        (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))
    )
)

(define (g n)
    (define (g-iter a b c n)
        (cond   ((< n 1) 0)
                ((= n 1) c)
                ((= n 2) b)
                ((= n 3) a)
                (else (g-iter (+ a (* 2 b) (* 3 c)) a b (- n 1)))
        )
    )
    (g-iter 4 2 1 n)
)

(display "\n")
(display (= (g 1) (f 1)))
(display "\n")
(display (= (g 2) (f 2)))
(display "\n")
(display (= (g 3) (f 3)))
(display "\n")
(display (= (g 4) (f 4)))
(display "\n")
