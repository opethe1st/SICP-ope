
; a)
(define (integrate-series s)
    (mul-streams
        (inverse-stream integers)
        s
    )
)

(define (inverse s)
    (cons-stream (/ 1 (stream-car s)) (inverse (stream-cdr s)))
)


; b)

(define cosine-series
    (cons-stream 1 (deriv-series sine-series))
)

(define sine-series
    (cons-stream 0 (deriv-series cosine-series))
)

; need to define (deriv-series)

(define (deriv-series s)
    (cons-stream 0 (mul-stream integers (stream-cdr s)))
)

