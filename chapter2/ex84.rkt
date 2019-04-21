(require "chapter2/number_packages.rkt")

(define (higher? type1 type2)
    (define tower '(scheme-number rational real complex))
    (define (order type)
        (define (iter position type tower)
            (cond
                ((null? tower) (error "Couldnt find this type" type))
                ((eq? (car tower) type) position)
                (else (iter (+ position 1) type (cdr tower)))
            )
        )
        (iter 0 type tower)
    )
    (> (order type1) (order type2))
)


(higher? 'real 'complex)
(higher? 'rational 'scheme-number)
(higher? 'real 'rational)
(higher? 'complex 'real)
(higher? 'complex 'complex)

(define (successive-raise x y)
    (cond
        ((eq? (type-tag x) (type-tag y)) x)
        ((higher? (type-tag y) (type-tag x)) (successive-raise (raise x) y))
        (else (error "Can't raise x to y since the type of y is not higher or equal"))
    )
)

(successive-raise (make-scheme-number 4) (make-complex-from-real-imag 4 1))

(define (my-apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (if (= (length args) 2)
                    (let (
                            (t1 (type-tag (car args)))
                            (t2 (type-tag (cadr args)))
                            (a1 (car args))
                            (a2 (cadr args))
                        )
                        (cond
                            ((higher? t2 t1) (apply-generic op (successive-raise a1 a2) a2))
                            ((higher? t1 t2) (apply-generic op a1 (successive-raise a2 a1)))
                            (else (error "Cant tell which type is higher" (list type-tags)))
                        )
                    )
                    (error "No method for these types" (list op type-tags))
                )
            )
        )
    )
)

(define (add x y)
    (my-apply-generic 'add x y)
)

(add (make-real 3) (make-rational 3 2))
(add (make-complex-from-real-imag 3 4) (make-rational 3 2))
