(define (make-interval lower upper)
    (cons (min lower upper) (max lower upper))
)

(define (lower-bound interval)
    (car interval)
)

(define (upper-bound interval)
    (cdr interval)
)

(define (add-interval x y)
    (make-interval  (+ (lower-bound x) (lower-bound y))
                    (+ (upper-bound x) (upper-bound y))
    )
)

(define (mul-interval x y)
    (let    ((p1 (* (lower-bound x) (lower-bound y)))
            (p2 (* (lower-bound x) (upper-bound y)))
            (p3 (* (upper-bound x) (lower-bound y)))
            (p4 (* (upper-bound x) (upper-bound y)))
            )
            (make-interval
                (min p1 p2 p3 p4)
                (max p1 p2 p3 p4)
            )
    )
)

(define (div-interval x y)
    (if (or (= (lower-bound y) 0)
            (= (upper-bound y) 0)
        )
        (error "Undefined to have the bounds of the interval set to Zero")
    )
    (mul-interval
        x
        (make-interval
            (/ 1.0 (upper-bound y))
            (/ 1.0 (lower-bound y))
        )
    )
)

(define (parallel-1 r1 r2)
    (div-interval
        (mul-interval r1 r2)
        (add-interval r1 r2)
    )
)


(define (parallel-2 r1 r2)
    (let (
            (one (make-interval 1 1))
        )
        (div-interval
            one
            (add-interval
                (div-interval one r1)
                (div-interval one r2)
            )
        )
    )
)

; demonstrate that even though these two are mathematically the same way to compute parallel resistance that with interval arithmetic they give
; different results

(define x (make-interval 2 4))
(define y (make-interval 1 5))

(display
    (parallel-1 x y)
)
(newline)
(display
    (parallel-2 x y)
)
; woah.. very different
; I know what's going on, not sure it's that useful to keep investigating with various expression
; problem is that we are compute the same intervals twice and there is more uncertainty because
; it appears that two values could be different when they should be the same.
; e.g if you do A/A - it should always give you 1 regardless of the upper or lower bound. but it always returns
; some uncertainty.
