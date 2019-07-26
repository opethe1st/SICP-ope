; for the first part, I tried and I failed to come up with a suitable solution so I looked it up

; pythagorean triples

(define pythagorean-tripes-stream
    (stream-filter
        (lambda (triple)
            (=
                (+ (square (car triple)) (square (cadr triple)))
                (square (caddr triple))
            )
        )
        (triples integers integers integers)
    )
)
