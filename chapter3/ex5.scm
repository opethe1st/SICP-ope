
(define (random-in-range low high)
    (let (
        (range (- high low))
        )
        (+ low (random range))
    )
)
(define (square x)
    (* x x)
)

(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond
            ((= trials-remaining 0)
                (/ trials-passed trials)
            )
            ((experiment)
                (iter (- trials-remaining 1) (+ trials-passed 1))
            )
            (else
                (iter (- trials-remaining 1) trials-passed)
            )
        )
    )
    (iter trials 0)
)

(define (estimate-integral p x1 x2 y1 y2 number-of-trials)
    (define (experiment)
        (p
            (random-in-range x1 x2)
            (random-in-range y1 y2)
        )
    )
    (monte-carlo number-of-trials experiment)
)

(*
    (estimate-integral
        (lambda (x y)
            (<= (+ (square (- x 1)) (square (- y 1))) 1)
        )
        0.0
        2.0
        0.0
        2.0
        100000.0
    )
    4
) ; this should give pi
