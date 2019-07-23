

(define (div-series num denom)
    (let ((denom-const (stream-car denom)))
        (mul-series
            (invert-unit-series
                (scale-stream denom denom-const)
            )
            num
        )
    )
)
