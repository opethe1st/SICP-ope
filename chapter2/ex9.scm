; Show that the width of the sum or difference of two intervals is function only of the widths of the interval being added or substracted.
(define (make-interval a b)
    (cons a b)
)

(define (lower-bound interval)
    (car interval)
)

(define (upper-bound interval)
    (cdr interval)
)

(define (add-interval x y)
    (make-interval  (+ (lower-bound x) (lower-bound y))
                    (+ (upper-bound x) (upper-bound y))
    )
)
(define (sub-interval x y)
    (add-interval
        x
        (make-interval
            (- (upper-bound y))
            (- (lower-bound y))
        )
    )
)

(define (width x)
    (/ (- (upper-bound x) (lower-bound x))
        2.0
    )
)

; prove that the width of a sum is a function of the width of its constituents

;; (define (width (add-interval a b))
;;     (/  (-
;;             (upper-bound (add-interval a b))
;;             (lower-bound (add-interval a b))
;;         )
;;         2.0
;;     )
;; )
;; (define (width (add-interval a b))
;;     (/  (-
;;             (+ (upper-bound a) (upper-bound b))
;;             (+ (lower-bound a) (lower-bound b))
;;         )
;;         2.0
;;     )
;; )
;; (define (width (add-interval a b))
;;     (/  (+
;;             (- (upper-bound a) (lower-bound a))
;;             (- (upper-bound b) (lower-bound b))
;;         )
;;         2.0
;;     )
;; )
;; (define (width (add-interval a b))
;;     (/  (+
;;             (* (width a) 2)
;;             (* (width b) 2)
;;         )
;;         2.0
;;     )
;; )
; simplifying, this is thus proved - width of an addition of two intervals is a function of the width of the added intervals
;; (define (width (add-interval a b))
;;     (+
;;         (width a)
;;         (width b)
;;     )
;; )
; for sub this is simply - refer to the definiton of sub-interval to see why
;; (define (width (sub-interval a b))
;;     (+
;;         (width a)
;;         (width -b)
;;     )
;; )
; where -b is simply
;    (make-interval
;        (- (upper-bound b))
;        (- (lower-bound b))
;    )
; turns out the width of -b is the width of b so we are back to
;; (define (width (sub-interval a b))
;;     (+
;;         (width a)
;;         (width b)
;;     )
;; )

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

(define (div-interval x y)
    (mul-interval
        x
        (make-interval
            (/ 1.0 (upper-bound y))
            (/ 1.0 (lower-bound y))
        )
    )
)
; Counterexample to prove that the width of the product of two intervals is not a function of width of the intervals

(display
    (width
        (add-interval
            (make-interval 2 4)
            (make-interval 5 9)
        )
    )
)
(newline)
(display
    (width
        (add-interval
            (make-interval 6 8)
            (make-interval 15 19)
        )
    )
)
(newline)
(display
    (width
        (sub-interval
            (make-interval 2 4)
            (make-interval 5 9)
        )
    )
)
(newline)
(display
    (width
        (sub-interval
            (make-interval 6 8)
            (make-interval 15 19)
        )
    )
)
(newline)
(display "these two are clearly not the same even though the same widths are involved")
(newline)
(newline)
(display
    (width
        (mul-interval
            (make-interval 2 4)
            (make-interval 5 9)
        )
    )
)
(newline)
(display
    (width
        (mul-interval
            (make-interval 6 8)
            (make-interval 15 19)
        )
    )
)
(newline)
(newline)
(display
    (width
        (div-interval
            (make-interval 2 4)
            (make-interval 5 9)
        )
    )
)
(newline)
(display
    (width
        (div-interval
            (make-interval 6 8)
            (make-interval 15 19)
        )
    )
)
