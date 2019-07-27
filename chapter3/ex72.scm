
(define (square x)
    (* x x x)
)
(define
    x
    (ordered-pairs
        integers
        integers
        (lambda (x)
            (+
                (square (car x))
                (square (cadr x))
            )
        )
    )
)

(define nums-equal-sum-of-square-in-three-different-ways
    (stream-filter
        (lambda (x)
            (not (= x 0))
        )
        (stream-map
            (lambda (x y z)
                (if (and (= x y) (= x z))
                    x
                    0
                )
            )
            nums-equal-sum-of-square-in-three-different-ways
            (stream-cdr nums-equal-sum-of-square-in-three-different-ways)
            (stream-cdr (stream-cdr nums-equal-sum-of-square-in-three-different-ways))
        )
    )
)
