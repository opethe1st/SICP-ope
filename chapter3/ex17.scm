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


(define (count-pairs x)
    (define set-of-pairs '())
    (define (count-pairs-recursive x)
        (if (or (not (pair? x)) (element-of-set? x set-of-pairs))
            0
            (begin
                (set! set-of-pairs (adjoin-set x set-of-pairs))
                (+ (count-pairs-recursive (car x))
                    (count-pairs-recursive (cdr x))
                    1
                )
            )
        )
    )
    (count-pairs-recursive x)
)


(count-pairs (cons (cons 'a '()) (cons 'b '())))

(define x (cons 'x '()))
(define y
    (cons x x)
)
(define z (cons y y))
(count-pairs z)

(define
    y
    (cons
        x
        '()
    )
)
(define z (cons y x))
(count-pairs z)
