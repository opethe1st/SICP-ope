(define (solve-2nd dy0 y0 dt f)
    (define y (integral (delay dy) y0 dt))
    (define dy (integral (delay ddy) dy0 dt))
    (define ddy
        (stream-map
            f
            dy
            y
        )
    )
    y
)
