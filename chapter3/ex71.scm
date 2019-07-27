
(define (cube x)
    (* x x x)
)
(define
    x
    (ordered-pairs
        integers
        integers
        (lambda (x)
            (+
                (cube (car x))
                (cube (cadr x))
            )
        )
    )
)

(define ramanujan-numbers
    (stream-filter
        (lambda (x)
            (not (= x 0))
        )
        (stream-map
            (lambda (x y)
                (if (= x y)
                    x
                    0
                )
            )
            ramanujan-numbers
            (stream-cdr ramanujan-numbers)
        )
    )
)
