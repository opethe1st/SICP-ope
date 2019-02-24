
(define (sum term a next b)
    (if (> a b)
        0
        (+
            (term a)
            (sum term (next a) next b)
        )
    )
)


(define (simpson-rule func a b n)
    (define h (/ (- b a) n))
    (define (next x) (+ x 1))
    (define (new-func k)
        (define y (+ a (* k h)))
        (cond   ((= k 0)
                    (func y)
                )
                ((= k n)
                    (func y)
                )
                ((= (remainder k 2) 1)
                    (* 4 (func y))
                )
                ((= (remainder k 2) 0)
                    (* 2 (func y))
                )
        )
    )

    (/
        (*
            h
            (sum new-func 0 next n)
        )
        3
    )
)

(define (cube x)
    (* x x x)
)

(display
    (simpson-rule cube 0 1 100)
)
(newline)
(display
    (simpson-rule cube 0 1 1000)
)
