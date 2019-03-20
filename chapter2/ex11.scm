(define (make-interval a b)
    (cons
        (min a b)
        (max a b)
    )
)

(define (lower-bound interval)
    (car interval)
)

(define (upper-bound interval)
    (cdr interval)
)

(define (eq-interval? x y)
    (and
        (= (lower-bound x) (lower-bound y))
        (= (upper-bound x) (upper-bound y))
    )
)

(define (mul-interval x y)
    (let    ((p1 (* (lower-bound x) (lower-bound y)))
            (p2 (* (lower-bound x) (upper-bound y)))
            (p3 (* (upper-bound x) (lower-bound y)))
            (p4 (* (upper-bound x) (upper-bound y)))
            )
            (make-interval
                (min p1 p2 p3 p4)
                (max p1 p2 p3 p4)
            )
    )
)

(define (mul-interval-new x y)

    (define (both-negative? a)
        (and
            (< (lower-bound a) 0)
            (< (upper-bound a) 0)
        )
    )
    (define (both-positive? a)
        (and
            (> (lower-bound a) 0)
            (> (upper-bound a) 0)
        )
    )
    (define (negative-positive? a)
        (and
            (< (lower-bound a) 0)
            (> (upper-bound a) 0)
        )
    )
    (cond
            ((and   (both-negative? x)
                    (both-negative? y)
            )
            (make-interval
                (* (upper-bound x) (upper-bound y))
                (* (lower-bound x) (lower-bound y))
            ))
            ((and   (both-positive? x)
                    (both-positive? y)
            )
            (make-interval
                (* (lower-bound x) (lower-bound y))
                (* (upper-bound x) (upper-bound y))
            ))
            ((and    (both-negative? x)
                    (both-positive? y)
            )
            (make-interval
                (* (lower-bound x) (upper-bound y))
                (* (upper-bound x) (lower-bound y))
            ))
            ((and    (both-positive? y)
                    (both-negative? x)
            )
            (make-interval
                (* (lower-bound x) (upper-bound y))
                (* (upper-bound x) (lower-bound y))
            ))
            ((and    (negative-positive? x)
                    (both-positive? y)
            )
            (make-interval
                (* (lower-bound x) (upper-bound y))
                (* (upper-bound x) (upper-bound y))
            ))
            ((and    (negative-positive? x)
                    (both-negative? y)
            )
            (make-interval
                (* (lower-bound x) (lower-bound y))
                (* (upper-bound x) (lower-bound y))
            ))
            ((and    (negative-positive? y)
                    (both-positive? x)
            )
            (make-interval
                (* (lower-bound x) (upper-bound y))
                (* (upper-bound x) (upper-bound y))
            ))
            ((and    (negative-positive? y)
                    (both-negative? x)
            )
            (make-interval
                (* (lower-bound y) (lower-bound x))
                (* (upper-bound y) (lower-bound x))
            ))
            ((and    (negative-positive? x)
                    (negative-positive? y)
            )
            (make-interval
                (min    (* (upper-bound x) (lower-bound y))
                        (* (lower-bound x) (upper-bound y))
                )
                (max    (* (upper-bound x) (upper-bound y))
                        (* (lower-bound x) (lower-bound y))
                )
            ))

    )
)


; tests
(define x (make-interval -3 -1))
(define y (make-interval -1 -3))
;; (display
;;     (mul-interval x y)
;; )
;; (newline)
;; (display
;;     (mul-interval-new x y)
;; )
(newline)
(display
    (eq-interval?
        (mul-interval x y)
        (mul-interval-new x y)
    )
)
(newline)
