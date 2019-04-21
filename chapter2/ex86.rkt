; the only thing that needs to happen is to change from the primitive +, - etc to use the generic add, mul etc.

; generic to use generic versions of the following functions
; add, sub, equ?, mul, div, sqrt, square, cos, sin, atan
; too lazy to implement them all here but you get the gist!
(require "chapter2/section4.rkt")

(define (add x y)
    (apply-generic 'add x y)
)

(define (install-rectangular-package)
    ;; internal procedures
    (define (real-part z) (car z))
    (define (imag-part z) (cdr z))
    (define (make-from-real-imag x y) (cons x y))
    (define (magnitude z)
        (sqrt (add (square (real-part z))
                (square (imag-part z)))))
    (define (angle z)
        (atan (imag-part z) (real-part z)))
    (define (make-from-mag-ang r a)
        (cons (mul r (cos a)) (mul r (sin a))))

    ;; interface to the rest of the system
    (define (tag x) (attach-tag 'rectangular x))
    (put 'real-part '(rectangular) real-part)
    (put 'imag-part '(rectangular) imag-part)
    (put 'magnitude '(rectangular) magnitude)
    (put 'angle '(rectangular) angle)
    (put 'make-from-real-imag 'rectangular
        (lambda (x y) (tag (make-from-real-imag x y)))
    )
    (put 'make-from-mag-ang 'rectangular
        (lambda (r a) (tag (make-from-mag-ang r a)))
    )
    'done
)
(install-rectangular-package)



(define (install-polar-package)
    ;; internal procedures
    (define (magnitude z) (car z))
    (define (angle z) (cdr z))
    (define (make-from-mag-ang r a) (cons r a))
    (define (real-part z)
        (mul (magnitude z) (cos (angle z))))
    (define (imag-part z)
        (mul (magnitude z) (sin (angle z))))
    (define (make-from-real-imag x y)
        (cons (sqrt (add (square x) (square y))) ; need generic sqrt, need generic square, generic cos, generic sin
            (atan y x))
    )

    ;; interface to the rest of the system
    (define (tag x) (attach-tag 'polar x))
    (put 'real-part '(polar) real-part)
    (put 'imag-part '(polar) imag-part)
    (put 'magnitude '(polar) magnitude)
    (put 'angle '(polar) angle)
    (put 'make-from-real-imag 'polar
        (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'polar
        (lambda (r a) (tag (make-from-mag-ang r a))))
    'done
)
(install-polar-package)



(define (install-complex-package)
    ;; imported procedures from rectangular and polar packages
    (define (make-from-real-imag x y)
        ((get 'make-from-real-imag 'rectangular) x y))
    (define (make-from-mag-ang r a)
        ((get 'make-from-mag-ang 'polar) r a))
    ;; internal procedures
    (define (add-complex z1 z2)
        (make-from-real-imag
            (add (real-part z1) (real-part z2))
            (add (imag-part z1) (imag-part z2))
        )
    )
    (define (sub-complex z1 z2)
        (make-from-real-imag
            (sub (real-part z1) (real-part z2))
            (sub (imag-part z1) (imag-part z2))
        )
    )
    (define (mul-complex z1 z2)
        (make-from-mag-ang
            (mul (magnitude z1) (magnitude z2))
            (add (angle z1) (angle z2))
        )
    )
    (define (div-complex z1 z2)
        (make-from-mag-ang
            (div (magnitude z1) (magnitude z2))
            (sub (angle z1) (angle z2))
        )
    )

    ;; interface to rest of the system
    (define (tag z) (attach-tag 'complex z))
    (put 'add '(complex complex)
        (lambda (z1 z2) (tag (add-complex z1 z2)))
    )
    (put 'sub '(complex complex)
        (lambda (z1 z2) (tag (sub-complex z1 z2)))
    )
    (put 'mul '(complex complex)
        (lambda (z1 z2) (tag (mul-complex z1 z2)))
    )
    (put 'div '(complex complex)
        (lambda (z1 z2) (tag (div-complex z1 z2)))
    )
    (put 'make-from-real-imag 'complex
        (lambda (x y) (tag (make-from-real-imag x y)))
    )
    (put 'make-from-mag-ang 'complex
        (lambda (r a) (tag (make-from-mag-ang r a)))
    )
    (put 'real-part '(complex) real-part)
    (put 'imag-part '(complex) imag-part)
    (put 'magnitude '(complex) magnitude)
    (put 'angle '(complex) angle)
    (put 'equ? '(complex complex)
        (lambda (a b)
            (and
                (equ? (real-part a) (real-part a))
                (equ? (imag-part a) (imag-part a))
            )
        )
    )
    'done
)
