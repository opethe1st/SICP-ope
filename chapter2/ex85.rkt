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


; for apply-generic, the only thing is to surround the proc with a call to drop if the type is a number
; if we assume this applies to just numbers then
(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (drop (apply proc (map contents args))) ; this is the only line I changed
                (if (= (length args) 2)
                    (let ((type1 (car type-tags))
                            (type2 (cadr type-tags))
                            (a1 (car args))
                            (a2 (cadr args)))
                        (let ((t1->t2 (get-coercion type1 type2))
                            (t2->t1 (get-coercion type2 type1)))
                            (cond (t1->t2
                                    (apply-generic op (t1->t2 a1) a2))
                                    (t2->t1
                                    (apply-generic op a1 (t2->t1 a2)))
                                    (else
                                    (error "No method for these types"
                                            (list op type-tags))))))
                    (error "No method for these types"
                            (list op type-tags))
                )
            )
        )
    )
)
