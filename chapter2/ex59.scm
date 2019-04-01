(define (union-set s1 s2)
    (cond
        ((null? s2) s1)
        ((element-of-set (car s2) s1)
            (union-set s1 (cdr s2))
        )
        (else (cons (car s2) (union-set s1 (cdr s2))))
    )
)

(define (element-of-set x s)
    (cond
        ((null? s) #f)
        ((equal? (car s) x) #t)
        (else (element-of-set x (cdr s)))
    )
)

; another version using accumulate - though this isn't that efficient since it doesn't terminate early
; or does it?
(define (element-of-set x s)
    (accumulate
        (lambda (a b) (or (equal? a x) b))
        #f
        s
    )
)
