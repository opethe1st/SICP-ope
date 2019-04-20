(require "chapter2/section4.rkt")

(define (install-scheme-number-package)
    (define (tag x) (attach-tag 'scheme-number x))

    (put 'equ? '(scheme-number scheme-number)
        (lambda (x y) (= x y))
    )

    (put 'add '(scheme-number scheme-number)
        (lambda (x y) (tag (+ x y)))
    )
    (put 'sub '(scheme-number scheme-number)
        (lambda (x y) (tag (- x y)))
    )
    (put 'mul '(scheme-number scheme-number)
        (lambda (x y) (tag (* x y)))
    )
    (put 'div '(scheme-number scheme-number)
        (lambda (x y) (tag (/ x y)))
    )
    (put 'make 'scheme-number
        (lambda (x) (tag x))
    )
    'done
)

(install-scheme-number-package)

(define (make-scheme-number x)
    ((get 'make 'scheme-number) x)
)

(define (equ? x y)
    (apply-generic 'equ? x y)
)

(equ? (make-scheme-number 1) (make-scheme-number 1))
(equ? (make-scheme-number 1) (make-scheme-number 2))
(equ? 1 1)
(equ? 1 2)
