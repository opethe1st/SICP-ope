
(define (fib n)
    (fib-iter 1 0 0 1 n)
)
(define (square x)
    (* x x)
)
(define (compute-p p q)
    (+ (square p) (square q))
)
(define (compute-q p q)
    (+ (* 2 p q) (square q))
)
(define (fib-iter a b p q count)
    (cond   ((= count 0) b)
            ((even? count) (fib-iter a b (compute-p p q) (compute-q p q) (/ count 2)))
            (else (fib-iter (+ (* b q) (* a q) (* a p)) (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))



(display (= (fib 1) 1))
(display (= (fib 2) 1))
(display (= (fib 3) 2))
(display (= (fib 4) 3))
(display (= (fib 5) 5))
(display (= (fib 6) 8))
(display (= (fib 7) 13))
