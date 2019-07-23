

(define (partial-sums s)
    (cons-stream
        (stream-car s)
        (add-stream (stream-cdr s) partial-sums)
    )
)

