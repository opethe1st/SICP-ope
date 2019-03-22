
(define (last-pair items)
    (if (null? (cdr items))
        (car items)
        (last-pair (cdr items))
    )
)

(display (last-pair (list 1 2 3 4 13243232)))
