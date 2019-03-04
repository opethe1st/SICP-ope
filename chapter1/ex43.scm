
(define (inc x) (+ x 1))
(define (square x) (* x x))
(define (compose f g)
    (lambda (x) (f (g x)))
)


(define (repeated f n)
    (lambda (x)
        (if (= n 1)
            (f x)
            ((compose f (repeated f (- n 1))) x)
        )
    )
)

(display
    ((repeated square 2) 5)
)
(newline)
