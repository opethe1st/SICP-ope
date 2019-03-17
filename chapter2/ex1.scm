
(define (make-rat n d)
    (if (or
            (and (> n 0) (> d 0))
            (and (< n 0) (< d 0))
        )
        (cons (abs n) (abs d))
        (cons (- (abs n)) (abs d))
    )
)

(define (numer rat)
    (car rat)
)
(define (denom rat)
    (cdr rat)
)


(define (print-rat x)
    (display (numer x))
    (display "/")
    (display (denom x))
    (newline)
)

(print-rat
    (make-rat 2 5)
)
(print-rat
    (make-rat 2 -5)
)
(print-rat
    (make-rat -2 5)
)
(print-rat
    (make-rat -2 -5)
)
