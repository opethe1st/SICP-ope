(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op
            (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)


(display
    (accumulate + 0 (list 1 2 3 4 5))
)
(newline)

(define (map proc sequence)
    (accumulate
        (lambda (x y)
            (cons (proc x) y)
        )
        '()
        sequence
    )
)


; tests
(display
    (map (lambda (x) (* x x)) (list 1 2 3))
)
(newline)
