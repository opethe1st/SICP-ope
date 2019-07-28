(define (zero-crossings)
    (stream-map
        sign-change-detector
        sense-data
        (stream-cdr sense-data) ; so I checked Eli's solution and he had a good point about how this sould be (cons-stream 0 sense-data)
    )
)
