(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (my-make-vect x y)
    (cons x y)
)

(define (x-cor-vect vec)
    (car vec)
)

(define (y-cor-vect vec)
    (cdr vec)
)
(define (sub-vect v1 v2)
    (make-vect
        (- (x-cor-vect v1) (x-cor-vect v2))
        (- (y-cor-vect v1) (y-cor-vect v2))
    )
)

(define (my-transform-painter painter origin corner1 corner2)
    (lambda (frame)
        (let ((m (frame-coord-map frame)))
            (let ((new-origin (m origin)))
                (painter
                    (make-frame
                        new-origin
                        (sub-vect (m corner1) new-origin)
                        (sub-vect (m corner2) new-origin)
                    )
                )
            )
        )
    )
)

(define (my-flip-horiz painter)
    (my-transform-painter
        painter
        (make-vect 1 0)
        (make-vect 0 0)
        (make-vect 1 1)
    )
)
(paint einstein)
(paint (my-flip-horiz einstein))

(define (rotate-180 painter)
   (my-transform-painter
        painter
        (make-vect 1 1)
        (make-vect 0 1)
        (make-vect 1 0)
    )
)
(paint (rotate-180 einstein))

(define (rotate-270 painter)
  (my-transform-painter
        painter
        (make-vect 0 1)
        (make-vect 0 0)
        (make-vect 1 1)
    )
)
(paint (rotate-270 einstein))
