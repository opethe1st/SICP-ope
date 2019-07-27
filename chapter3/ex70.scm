(define (merge-weighted s1 s2 less-than)
    (define (merge s1 s2)
        (cond
            ((stream-null? s1) s2)
            ((stream-null? s2) s1)
            (else
                (let
                    (
                        (s1car (stream-car s1))
                        (s2car (stream-car s2))
                    )
                    (if ((eq? s1car s2car)) ; compare the two tuples
                        (cons-stream
                            s1car
                            (merge (stream-cdr s1) (stream-cdr s2))
                        )
                        (cond
                            ((less-than s1car s2car)
                                (cons-stream s1car (merge (stream-cdr s1) s2))
                            )
                            (else
                                (cons-stream s1car (merge s1 (stream-cdr s2)))
                            )
                        )
                    )
                )
            )
        )
    )
    (merge s1 s2)
)

; a)
(define (ordered-pairs s t weighing-func)
    (cons-stream
        (list (stream-car s) (stream-car t))
        (merge-weighted
            (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
            (ordered-pairs (stream-cdr s) (stream-cdr t))
            (lambda
                (x y)
                (<
                    (weighing-func x)
                    (weighing-func y)
                )
            )
        )
    )
)
(ordered-pairs integers integers (lambda (x) (+ (car x) (cadr x))))

; b)
(define integers-with-multiples-of-2-3-5
    (stream-filter
        (lambda (x)
            (not
                (or
                    (remainder x 2)
                    (remainder x 3)
                    (remainder x 5)
                )
            )
        )
        integers
    )
)
(ordered-pairs
    integers-with-multiples-of-2-3-5
    integers-with-multiples-of-2-3-5
    (lambda (x)
        (+
            (* 2 (car x))
            (* 3 (cadr x))
            (* 5 (* (car x) (cadr x)))
        )
    )
)
