(define (rand-stream requests previous)
    (let ((first-request (stream-car requests)))
        (if (eq? first-request 'generate)
            (cons-stream
                (rand-update previous)
                (rand-stream (stream-cdr requests) previous)
            )
            (cons-stream
                first-request
                (rand-stream (stream-cdr requests) (stream-car requests))
            )
        )
    )
)

;; I want to eliminate the previous argument but not sure how

(define (rand-stream requests)
    (define (inner requests previous)
        (let (
            (request (stream-car requests))
            )
            (cond
                ((eq? request 'generate)
                    (cons-stream
                        (rand-update previous)
                        (inner (stream-cdr requests) (rand-update previous))
                    )
                )
                ((number? request)
                    (cons-stream
                        (rand-update request)
                        (inner (stream-cdr requests) ((rand-update request))
                    )
                )
                (else (error "Unknown request: " r))
            )
        )
        (inner requests 0)
    )
)
