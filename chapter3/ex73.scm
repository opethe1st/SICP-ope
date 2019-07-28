
(define (RC r c dt)
    (lambda (i v0)
        (add-streams
            (scale-stream r i)
            (integral
                (scale-stream (/ 1 c) i)
                v0
                dt
            )
        )
    )
)
