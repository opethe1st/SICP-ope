#lang racket

(define (even? b)
    (if (= (remainder b 2) 0)
        #t
        #f
    )
)


(define (square x)
    (* x x)
)


(define (fast-exp-iter b n a)
    ; (display a)
    ; (newline)
    (cond   ((= n 0) a)
            ((even? n) (square (fast-exp-iter b (/ n 2) a)))
            (else (* b (fast-exp-iter b (- n 1) a)))
    )
)


(define (fast-exp b n)
    (fast-exp-iter b n 1)
)


(display (= (fast-exp 2 2) 4))
(newline)
(display (= (fast-exp 2 3) 8))
(newline)
(display (= (fast-exp 2 4) 16))
(newline)
(display (= (fast-exp 2 5) 32))
(newline)
(display (= (fast-exp 2 6) 64))
(newline)
(display (= (fast-exp 2 7) 128))
(newline)
