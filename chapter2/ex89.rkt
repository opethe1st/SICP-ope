(require "chapter2/number_packages.rkt")


(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))
(define (highest-order term-list)
    (- (length term-list) 1)
)
(define (empty-termlist? term-list) (null? term-list))
(define (the-empty-termlist) '())

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

(adjoin-term (make-term 2 3) (list 4 1))
(adjoin-term (make-term 4 1) (list 2 1))


(define (first-term term-list)
    (make-term (- (length term-list) 1) (car term-list))
)
(first-term (adjoin-term (make-term 2 3) (list 4 1)))

(define (rest-terms term-list)
    (cdr term-list)
)
(rest-terms (list 3 2 1))

(define (add-terms L1 L2)
    (define (reversed-add rev-L1 rev-L2)
        (cond
            ((and (null? rev-L1) (null? rev-L2)) '())
            ((null? rev-L1) rev-L2)
            ((null? rev-L2) rev-L1)
            (else
                (cons
                    (add (car rev-L1) (car rev-L2))
                    (reversed-add
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
        (reverse (reversed-add reversed-L1 reversed-L2))
    )
)

(display "test add-terms")
(newline)
(add-terms (list 1 2) (list 3 0))
(add-terms (list 1 2) '())
(add-terms '() (list 1 54))
(add-terms (list 1 2 3) (list 2))

; magic! this just worked!!!! w/o any changes :)
(define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t2 (first-term L)))
            (adjoin-term
                (make-term
                    (+ (order t1) (order t2))
                    (mul (coeff t1) (coeff t2)))
                (mul-term-by-all-terms t1 (rest-terms L))
            )
        )
    )
)

(define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        (the-empty-termlist)
        (add-terms
            (mul-term-by-all-terms (first-term L1) L2)
            (mul-terms (rest-terms L1) L2)
        )
    )
)
(display "test mul-terms")
(mul-terms (list 2 1) (list 2 1))
(mul-terms (list 1 -1 1) (list 1 1))
