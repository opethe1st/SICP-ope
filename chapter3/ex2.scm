(define (make-monitored f)
    (define count 0)
    (define (dispatch method)
        (cond ((eq? 'how-many-calls? method) count)
            (else
                (begin
                    (set! count (+ count 1))
                    (f method)
                )
            )
        )
    )
    dispatch
)


; this is a lil weird I think
(define s (make-monitored sqrt))
(s 100)
; this should evaluate to 10
(s 'how-many-calls?)
; this should evaluate to 1
