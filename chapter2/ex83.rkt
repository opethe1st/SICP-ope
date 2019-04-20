(require "chapter2/number_packages.rkt")


(define (install-coercion-package)
    (define (scheme-number->rational x)
        (make-rational x 1)
    )
    (define (rational->real x)
        (make-real (/ (numer x) (denom x)))
    )
    (define (real->complex x)
        (make-complex-from-real-imag x 0)
    )

    (put 'raise '(scheme-number) scheme-number->rational)
    (put 'raise '(rational) rational->real)
    (put 'raise '(real) real->complex)
)

(install-coercion-package)

(define (raise x)
    (apply-generic 'raise x)
)


(raise (make-real 12))
(raise (make-rational 12 1))
(raise (make-scheme-number 12))
