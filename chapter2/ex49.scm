(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))


;a
(define (draw-outline frame)
    (
        (segments->painter
            (list
                (make-segment (make-vect 0 0) (make-vect 1 0))
                (make-segment (make-vect 1 0) (make-vect 1 1))
                (make-segment (make-vect 1 1) (make-vect 0 1))
                (make-segment (make-vect 0 1) (make-vect 0 0))
            )
        )
        frame
    )
)


(paint draw-outline)
; b
(define (draw-x frame)
    (
        (segments->painter
            (list
                (make-segment (make-vect 0 0) (make-vect 1 1))
                (make-segment (make-vect 1 0) (make-vect 0 1))
            )
        )
        frame
    )
)

; c
(define (draw-diamond frame)
    (
        (segments->painter
            (list
                (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
                (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
                (make-segment (make-vect 1 0.5) (make-vect 0.5 0))
                (make-segment (make-vect 0.5 0) (make-vect 0 0.5))
            )
        )
        frame
    )
)


(paint draw-diamond)

;d the wave painter?? LOL. Not me :) 
