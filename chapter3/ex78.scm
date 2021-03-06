(define (solve-2nd dy0 y0 dt)
    (define y (integral (delay dy) y0 dt))
    (define dy (integral (delay ddy) dy0 dt))
    (define ddy
        (add-stream
            (scale-stream dy a)
            (scale-stream y b)
        )
    )
    y
)
