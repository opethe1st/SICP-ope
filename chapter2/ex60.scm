
(define (element-of-set? x s)
    (cond
        ((null? s) false)
        ((equal? x (car s)) true)
        (else (element-of-set? x (cdr s)))
    )
)

(define (adjoin-set x s)
    (cons x s)
)

(define (union-set s1 s2)
    (append s1 s2)
)

(define (intersection-set set1 set2)
    (cond
        ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
            (cons (car set1) (intersection-set (cdr set1) set2))
        )
        (else (intersection-set (cdr set1) set2))
    )
)

(define (make-set . a)
    a
)

(define x (make-set 1 2 3 12324 1 3))

(element-of-set 4 x)

(element-of-set 3 x)

(adjoin-set 10 x)

(union-set x (make-set 12 13))

(intersection-set x (make-set 1 123))


; maybe applications where adjoin-set is used more and union-set
