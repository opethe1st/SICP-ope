
(define (for-each proc args)
    (define (apply-and-continue arg remaining-args)
        (proc arg)
        (for-each proc remaining-args)
    )
    (if (null? args)
        '()
        (apply-and-continue (car args) (cdr args))
    )
)


(for-each
    (lambda (x) (newline) (display x))
    (list 57 321 88)
)
