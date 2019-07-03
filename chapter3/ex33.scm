(define (averager a b avg)
    (let
        (
            (sum-of-a-b (make-connector))
            (two (make-connector))
        )
    )
    (adder a b sum-of-a-b)
    (constant 2 two)
    (multipler two avg sum-of-a-b)
)
