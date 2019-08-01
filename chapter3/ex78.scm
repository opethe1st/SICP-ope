
(define (solve-2nd dy0 y0 dt)
    (define ddy
        (add-stream
            (scale-stream dy a)
            (scale-stream y b)
        )
    )
    (define y (integral (delay dy) y0 dt))
    (define dy (integral (delay ddy) dy0 dt))
    y
)

; this needs a scale-stream that accepts delayed arguments

; looks like my solution is wrong by what I checked online :D. I will investigate further
