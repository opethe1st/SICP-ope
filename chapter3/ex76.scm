(define (smoothed input-stream start)
    (cons-stream
        (average start (stream-car input-stream))
        (smoothed (stream-cdr input-stream) (stream-car input-stream))
    )
)
(define (zero-crossing sense-data)
    (define smoothed (smooth sense-data 0))
    (stream-map
        sign-change-detector
        smoothed
        (stream-cdr smoothed)
    )
)
