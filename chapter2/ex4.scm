(define (cons x y)
    (lambda (m) (m x y))
)

(define (car z)
    (z (lambda (p q) p))
)

; this is the corresponding definition
(define (cdr z)
    (z (lambda (p q) q))
)


(define x (cons 3 4))


(display (car x))
(newline)
(display (cdr x))
