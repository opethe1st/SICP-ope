#lang racket

(define (even? b)
    (if (= (remainder b 2) 0)
        #t
        #f
    )
)

(define (double a)
    (+ a a)
)
(define (fast-multiplication-iter a b)
    (cond   ((= b 0) 0)
            ((even? b) (double (fast-multiplication-iter a (/ b 2))))
            (else (+ a (fast-multiplication-iter a (- b 1))))
    )
)

(define (fast-multiplication a b)
    (fast-multiplication-iter a b)
)

(display (= (fast-multiplication 0 0) 0))
(display (= (fast-multiplication 0 1) 0))
(display (= (fast-multiplication 1 0) 0))
(display (= (fast-multiplication 1 1) 1))
(display (= (fast-multiplication 3 4) 12))
