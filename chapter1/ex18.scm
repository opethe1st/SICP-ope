
(define (even? b)
    (if (= (remainder b 2) 0)
        #t
        #f
    )
)

(define (halve a)
    (/ a 2)
)

(define (double x)
    (+ x x)
)


(define (binary-exp-iter b n ans)
    (cond   ((= n 0) ans)
            ((even? n) (binary-exp-iter (double b) (halve n) ans))
            (else (binary-exp-iter b (- n 1) (+ b ans)))
    )
)


(define (fast-exp b n)
    (binary-exp-iter b n 0)
)


(display (= (fast-exp 2 2) 4))
(newline)
(display (= (fast-exp 2 3) 6))
(newline)
(display (= (fast-exp 2 4) 8))
(newline)
(display (= (fast-exp 2 5) 10))
(newline)
(display (= (fast-exp 2 6) 12))
(newline)
(display (= (fast-exp 2 7) 14))
(newline)
