(require "chapter2/section4.rkt")

; a
(define (install-scheme-number-package)
    ; .. other stuff

    (define (tag x)
        (cons 'scheme-number x)
    )

    (put 'exponent '(scheme-number scheme-number)
        (lambda (x y) (tag (expt x y)))
    )
)
(define (exponent x y)
    (apply-generic 'exponent x y)
)

(exponent '(rational 2 1) 3)
; what happens if we exp with two complex numbers as arguments
; there is no 'exp '(complex complex) in the table so we get an error

;b
; Is Louis correct that something had to be done about coercion with arguments of the same type, or does apply-generic work correctly as is?
; Yes, Louis is correct.


; c
(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (if (= (length args) 2)
                    (let (
                        (type1 (car type-tags))
                        (type2 (cadr type-tags))
                        (a1 (car args))
                        (a2 (cadr args))
                        )
                        (let ((t1->t2 (get-coercion type1 type2)) (t2->t1 (get-coercion type2 type1)))
                            (cond
                                (t1->t2 (apply-generic op (t1->t2 a1) a2))
                                (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                                (else (error "No method for these types" (list op type-tags)))
                            )
                        )
                    )
                    (error "No method for these types" (list op type-tags))
                )
            )
        )
    )
)
(define (get-coercion type1 type2)
    (if (eq? type1 type2)
        (lambda (x) x)
        (get 'get-coercion type1 type2)
    )
)

; technically it still coercises to itself but I think it's cleaner than putting the coercing logic in apply-generic
