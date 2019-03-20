(define (make-interval lower upper)
    (cons (min lower upper) (max lower upper))
)

(define (lower-bound interval)
    (car interval)
)

(define (upper-bound interval)
    (cdr interval)
)

(define (make-center-width center width)
    (make-interval (- center width) (+ center width))
)

(define (center i)
    (/ (+   (lower-bound i)
            (upper-bound i)
        )
        2.0
    )
)

(define (width i)
    (/ (-   (upper-bound i)
            (lower-bound i)
        )
        2.0
    )
)


(define (make-center-percent center percentage-tolerance)
    (define width (* (/ percentage-tolerance 100) center))
    (make-center-width center width)
)

(define (percent i)
    (* 100 (/ (width i) (center i)))
)


; tests
(display
    (make-center-percent 10 17)
)
(newline)
(display
    (percent (make-center-percent 10 17))
)
(newline)
