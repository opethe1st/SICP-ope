
(define (A x y)
    (cond   ((= y 0) 0)
            ((= x 0) (* 2 y))
            ((= y 1) 2)
            (else (A (- x 1) (A x (- y 1))))
    )
)


(A 1 10)
(newline)
(A 2 4)
(newline)
(A 3 3)

(define (f n)
    (A 0 n)
)
; this is f(n) = 2n
(define (g n)
    (A 1 n)
)
; this is g(n) = 2**n

(define (h n)
    (A 2 n)
)
; this is h(n) = 2**h(n-1)

(define (k n)
    (* 5 n n)
)
; k(n) = 5*n**2
