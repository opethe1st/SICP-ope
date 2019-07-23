
(define (mul-series s1 s2)
    (cons-stream
        (* (stream-car s1) (stream-car s2))
        (add-streams
            (mul-series (stream-cdr s1) s2)
            (mul-series s1 (stream-cdr s2)) ; does this result in repetition?
        )
    )
)
