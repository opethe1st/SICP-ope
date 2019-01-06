#lang racket


(define (cont-frac n d k)
    (define (cont-frac-iter n d k counter)
        (define i (- k counter))
        (if (= i k)
            (/ (n i) (d i))
            (/ (n i) (+ (d i) (cont-frac-iter n d k (- counter 1))))
        )
    )
    (cont-frac-iter n d k k)
)


(display    (cont-frac
                (lambda (i) 1.0)
                (lambda (i) 1.0)
                100
            )
)
