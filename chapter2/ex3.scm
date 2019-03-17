(define (make-point a b)
    (cons a b)
)

(define (x-point point)
    (car point)
)

(define (y-point point)
    (cdr point)
)

(define (make-rect corner-point1 corner-point2)
    (cons corner-point1 corner-point2)
)

(define (get-length rect)
    (abs
        (-
            (x-point (car rect))  ; car not ideal tbh
            (x-point (cdr rect))
        )
    )
)

(define (get-width rect)
    (abs
        (-
            (y-point (car rect))
            (y-point (cdr rect))
        )
    )
)

(define (area rect)
    (* (get-length rect) (get-width rect))
)

(define (perimeter rect)
    (* 2 (+ (get-length rect) (get-width rect)))
)

(display
    (area
        (make-rect
            (make-point 0 0)
            (make-point 3 7)
        )
    )
)
(newline)
(display
    (perimeter
        (make-rect
            (make-point 0 0)
            (make-point 3 7)
        )
    )
)
