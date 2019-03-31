; not doing a, because I didnt do the wave creation exercise

(define (corner-split painter n)
    (if (= n 0)
        painter
        (let    ((up (up-split painter (- n 1)))
                (right (right-split painter (- n 1)))
                )
                (beside (below painter up) (below right (corner-split painter (- n 1))))
        )
    )
)


; c
(define (square-limit painter n)
    (let (combine4 (square-of-four identity flip-horiz flip-vert rotate180))
        (combine4 (corner-split painter n))
    )
)

; not done yet and not sure I am going to bother :)
