;;; ALL procedures in 2.5.3 except make-polynomial
;;; should be inserted in install-polynomial-package, as indicated
(require "chapter2/number_packages.rkt")


;; *incomplete* skeleton of package
(define (install-polynomial-package)
    ;; internal procedures
    ;; representation of poly
    (define (make-poly variable term-list)
        (cons variable term-list))
    (define (variable p) (car p))
    (define (term-list p) (cdr p))
    ;;[procedures same-variable? and variable? from section 2.3.2]
    (define (variable? x) (symbol? x))

    (define (same-variable? v1 v2)
        (and (variable? v1) (variable? v2) (eq? v1 v2))
    )

    ;; representation of terms and term lists
    (define (the-empty-termlist) '())
    (define (first-term term-list) (car term-list))
    (define (rest-terms term-list) (cdr term-list))
    (define (empty-termlist? term-list) (null? term-list))

    (define (make-term order coeff) (list order coeff))
    (define (order term) (car term))
    (define (coeff term) (cadr term))
    ;;[procedures adjoin-term ... coeff from text below]
    (define (adjoin-term term term-list)
        (if (=zero? (coeff term))
            term-list
            (cons term term-list)
        )
    )

    ;;(define (add-poly p1 p2) ... )
    (define (op-poly op p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            (make-poly
                (variable p1)
                (op-terms
                    op
                    (term-list p1)
                    (term-list p2)
                )
            )
            (error "Polys not in same var -- ADD-POLY" (list p1 p2))
        )
    )
    (define (add-poly p1 p2)
        (op-poly add p1 p2)
    )
    ;;[procedures used by add-poly]
    ; could abstract this so it can be used for both add and sub
    (define (op-terms op L1 L2)
        (cond ((empty-termlist? L1) L2)
                ((empty-termlist? L2) L1)
                (else
                    (let ((t1 (first-term L1)) (t2 (first-term L2)))
                        (cond   ((> (order t1) (order t2))
                                    (adjoin-term
                                        t1
                                        (op-terms op (rest-terms L1) L2)
                                    )
                                )
                                ((< (order t1) (order t2))
                                    (adjoin-term
                                        t2
                                        (op-terms op L1 (rest-terms L2))
                                    )
                                )
                                (else
                                    (adjoin-term
                                        (make-term
                                            (order t1)
                                            (op (coeff t1) (coeff t2))
                                        )
                                        (op-terms
                                            op
                                            (rest-terms L1)
                                            (rest-terms L2)
                                        )
                                    )
                                )
                        )
                    )
                )
        )
    )
    (define (add-terms L1 L2)
        (op-terms add L1 L2)
    )
    (define (sub-poly L1 L2)
        (op-poly sub L1 L2)
    )

    ;;(define (mul-poly p1 p2) ... )
    (define (mul-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            (make-poly
                (variable p1)
                (mul-terms (term-list p1) (term-list p2))
            )
            (error "Polys not in same var -- MUL-POLY" (list p1 p2))
        )
    )
    ;;[procedures used by mul-poly]
    (define (mul-terms L1 L2)
        (if (empty-termlist? L1)
            (the-empty-termlist)
            (add-terms
                (mul-term-by-all-terms (first-term L1) L2)
                (mul-terms (rest-terms L1) L2)
            )
        )
    )

    (define (mul-term-by-all-terms t1 L)
        (if (empty-termlist? L)
            (the-empty-termlist)
            (let ((t2 (first-term L)))
                (adjoin-term
                    (make-term
                        (+ (order t1) (order t2))
                        (mul (coeff t1) (coeff t2))
                    )
                    (mul-term-by-all-terms t1 (rest-terms L))
                )
            )
        )
    )

    (define (=zero-polynomial? x)
        ; I could have used accumulate for this
        (define (all-zero y)
            (if (null? y)
                #t
                (and (=zero? (car y)) (all-zero (cdr y)))
            )
        )
        (or
            (empty-termlist? (term-list x))
            (all-zero (map coeff (term-list x)))
        )
    )
    (define (neg-poly x)
        (make-polynomial
            (variable x)
            (neg-terms (term-list x))
        )
    )
    ;; interface to rest of the system
    (define (tag p) (attach-tag 'polynomial p))

    (put 'sub '(polynomial polynomial) sub-poly)
    (put 'neg '(polynomial) neg-poly)
    (put '=zero? '(polynomial) =zero-polynomial?)
    (put 'add '(polynomial polynomial)
        (lambda (p1 p2) (tag (add-poly p1 p2))))
    (put 'mul '(polynomial polynomial)
        (lambda (p1 p2) (tag (mul-poly p1 p2))))

    (put 'make 'polynomial
        (lambda (var terms) (tag (make-poly var terms)))
    )
    'done
)

(install-polynomial-package)

;; Constructor
(define (make-polynomial var terms)
    ((get 'make 'polynomial) var terms)
)


(define x
    (make-polynomial
        'x
        (list
            (list 1 1)
            (list 0 5)
        )
    )
)
(define y
    (make-polynomial
        'x
        (list
            (list 1 1)
            (list 0 2)
        )
    )
)
(sub x y)
