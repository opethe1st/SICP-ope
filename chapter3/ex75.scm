(define (make-zero-crossing input-stream last-value last-avpt)
    (let ((avpt (/ (+ (stream-car input-stream) last-value))))
        (cons-stream
            (sign-change-detector avpt last-avpt)
            (make-zero-crossing (stream-cdr input-stream) (stream-car input-stream) avpt)
        )
    )
)
