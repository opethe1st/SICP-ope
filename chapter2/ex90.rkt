(require "chapter2/number_packages.rkt")


(define (install-polynomial-package)
    ;; internal procedures
    ;; representation of poly
    (define (make-poly variable term-list) ; need to introduce creating with dense and sparse
        (cons variable term-list))
    (define (variable p) (car p)) ; does this need to be in both packages?
    (define (term-list p) (cdr p))
    (define (variable? x) (symbol? x))

    (define (same-variable? v1 v2)
        (and (variable? v1) (variable? v2) (eq? v1 v2))
    )

    ;; representation of terms and term lists
    (define (the-empty-termlist) '())
    (define (rest-terms term-list) (cdr term-list))
    (define (empty-termlist? term-list) (null? term-list))

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
        (lambda (var terms) (tag (make-poly var terms))) ; need to adjust this to have two tags
    )
    'done
)

(install-polynomial-package)

(define (install-dense-term-list-package)
    (define (adjoin-term term term-list)
        (if (<= (order term) (highest-order term-list))
            (raise "cant adjoin a term whose order is already on the list")
            '()
        )
        (if (= (order term) (+ 1 (highest-order term-list)))
            (cons (coeff term) term-list)
            (cons
                (coeff term)
                (adjoin-term
                    (make-term
                        (- (order term) 1)
                        0
                    )
                    term-list
                )
            )
        )
    )
    (define (first-term term-list)
        (make-term (- (length term-list) 1) (car term-list))
    )
    (define (op-terms op L1 L2)
        (define (reversed-add rev-L1 rev-L2)
            (cond
                ((and (null? rev-L1) (null? rev-L2)) '())
                ((null? rev-L1) rev-L2) ; this should probably be empty-term-list? instead of null?
                ((null? rev-L2) rev-L1)
                (else
                    (cons
                        (op (car rev-L1) (car rev-L2))
                        (reversed-op
                            op
                            (cdr rev-L1)
                            (cdr rev-L2)
                        )
                    )
                )
            )
        )
        (let (
                (reversed-L1 (reverse L1))
                (reversed-L2 (reverse L2))
            )
            (reverse (reversed-op add reversed-L1 reversed-L2))
        )
    )
    (define (add-terms L1 L2)
        (op-terms add L1 L2)
    )
    (define (sub-terms L1 L2)
        (op-terms sub L1 L2)
    )

    (put 'add-terms '(dense dense) add-terms)
    (put 'sub-terms '(dense dense) sub-terms)
    (put 'first-term '(dense) first-term)
    (put 'adjoin-term '(term dense) adjoin-term) ; hm, need to add a term type?
)

(install-dense-term-list-package)


(define (install-sparse-term-list-package)
    (define (adjoin-term term term-list)
        (if (=zero? (coeff term)) ; where will coeff come from? need a term package?
            term-list
            (cons term term-list)
        )
    )
    (define (first-term term-list) (car term-list))
    (define (op-terms op L1 L2)
        (cond (
            (empty-termlist? L1) L2)
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
    (define (sub-terms L1 L2)
        (op-terms sub L1 L2)
    )

    (put 'add-terms '(sparse sparse) add-terms)
    (put 'sub-terms '(sparse sparse) sub-terms)
    (put 'first-term '(sparse) first-term)
    (put 'adjoin-term '(term spare) adjoin-term) ; hm, need to add a term type? or package
)
(install-sparse-term-list-package)

(define (install-term-package)
    (define (make-term order coeff)
        (tag (list order coeff)))
    )
    (define (order term)
        (car term)
    )
    (define (coeff term)
        (cadr term)
    )
    (define (tag x)
        (attach-tag 'term p)
    )
    (put 'make 'term make-term)
    (put 'order '(term) order)
    (put 'coeff '(term) coeff)
)
(define (make-term order coeff)
    ((get 'make 'term) order coeff)
)
(define (order term)
    (apply-generic 'order term)
)
(define (coeff term)
    (apply-generic 'coeff term)
)
(install-term-package)
; so much code without any tests!!! :(
