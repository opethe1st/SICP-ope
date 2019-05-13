
(define (element-of-set? x set-of-stuff)
    (cond ((null? set-of-stuff) #f)
            ((eq? x (car set-of-stuff)) #t)
            (else (element-of-set? x (cdr set-of-stuff)))
    )
)

(define (adjoin-set x set-of-stuff)
    (if (element-of-set? x set-of-stuff)
        set-of-stuff
        (cons x set-of-stuff)
    )
)

(define (make-cycle x)
    (define (last-pair y)
        (if (null? (cdr y))
            y
            (last-pair (cdr y))
        )
    )
    (set-cdr! (last-pair x) x)

)


(define (has-cycle? l)
    (define (cddr-or-nil ls)
        (if (pair? (cdr ls))
            (cddr ls)
            '()
        )
    )
    (define (iter slow fast)
        (cond
            ((null? fast) false)
            ((eq? (car slow) (car fast)) true)
            (else (iter (cdr slow) (cddr-or-nil fast)))
        )
    )
    (iter l (cddr-or-nil l))
)

(has-cycle? (list 1 2 3))
(define x (list 1 2 3))
(make-cycle x)
(has-cycle? x)
