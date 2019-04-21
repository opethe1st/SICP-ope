(require "chapter2/number_packages.rkt")

(define (install-coercion-package)
    (define (project-complex x)
        (make-real (real-part x))
    )
    (define (project-real x)
        (make-rational (round x) 1)
    )
    (define (project-rational x)
        (make-scheme-number (numer x))
    )
    (define (project-scheme-number x)
        '()
    )
    (put 'project '(complex) project-complex)
    (put 'project '(real) project-real)
    (put 'project '(rational) project-rational)
    (put 'project '(scheme-number) project-scheme-number)
    'done
)

(install-coercion-package)

(define (project object)
    (apply-generic 'project object)
)


(define (drop object)
    (define (droppable? x)
        (and
            (not (null? x))
            (not (eq? (type-tag x) 'scheme-number))
            (equ? (raise (project x)) x)
        )
    )
    (define (iter obj)
        (if (droppable? obj)
            (iter (project obj))
            obj
        )
    )
    (iter object)
)

(define x (make-real 3.6))
(drop x)
(drop (make-complex-from-real-imag 3 0))
