
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

(define (has-cycle? l)
    (define items-so-far '())
    (define (iter items)
        (cond
            ((null? items) false)
            ((element-of-set? (car items) items-so-far) true)
            (else
                (begin
                    (set! items-so-far (adjoin-set (car items) items-so-far))
                    (iter (cdr items))
                )
            )
        )
    )
    (iter l)
)


(define (make-cycle x)
    (define (last-pair y)
        (if (null? (cdr y))
            x
            (last-pair (cdr y))
        )
    )
    (set-cdr! (last-pair x) x)

)


(has-cycle? (list 1 2 3))
(define x (list 1 2 3))

(make-cycle x)
(has-cycle? x)
