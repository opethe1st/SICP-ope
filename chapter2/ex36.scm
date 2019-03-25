(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op
            (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)

(define (accumulate-n op init seqs)
    (define (car-elements s)
        (if (null? s)
            s
            (cons
                (car (car s))
                (car-elements (cdr s))
            )
        )
    )
    (define (cdr-elements s)
        (if (null? s)
            s
            (cons
                (cdr (car s))
                (cdr-elements (cdr s))
            )
        )
    )
    (if (null? (car seqs))
        (car seqs)
        (cons
            (accumulate op init (car-elements seqs))
            (accumulate-n op init (cdr-elements seqs))
        )
    )
)

(define s (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
(display
    (accumulate-n
        +
        0
        s
    )
)
(newline)
