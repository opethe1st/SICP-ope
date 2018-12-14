#lang racket

(define (even? b)
    (if (= (remainder b 2) 0)
        #t
        #f
    )
)

(define (halve a)
    (/ a 2)
)

(define (square x)
    (* x x)
)


(define (binary-exp-iter b n ans)
    (cond   ((= n 0) ans)
            ((even? n) (binary-exp-iter (square b) (halve n) ans))
            (else (binary-exp-iter b (- n 1) (* b ans)))
    )
)


(define (fast-exp b n)
    (binary-exp-iter b n 1)
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
