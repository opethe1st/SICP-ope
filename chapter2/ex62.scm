(define (union-set s1 s2)
    (cond
        ((null? s1) s2)
        ((null? s2) s1)
        ((= (car s1) (car s2))
            (cons (car s1) (union-set (cdr s1) (cdr s2)))
        )
        ((< (car s1) (car s2))
            (cons (car s1) (union-set (cdr s1) s2))
        )
        ((> (car s1) (car s2))
            (cons (car s2) (union-set s1 (cdr s2)))
        )
    )
)


(define (make-set . a)
    a
)

(union-set (make-set 1 20 30) (make-set 1 14 50))
