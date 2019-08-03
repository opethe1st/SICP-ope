(define (create-solver vc0 il0 L C)
    (define (solve vc0 il0)
        (define vc (integral (delay dv0) vc0 dt))
        (define il (integral (delay dil) il0 dt))
        (define dil
            (add-stream
                (scale-stream (/ 1 L) vc)
                (scale-stream (/ (- R) L) il)
            )
        )
        (define dvc
            (scale-stream (/ -1 c) il)
        )
        (define res (stream-map (lambda (x y)(cons x y))) vc il)
        res
    )
    (lambda (vc0 il0)
        (solve vc0 il0)
    )
)
