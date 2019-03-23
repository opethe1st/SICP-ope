
(define (make-mobile left right)
    (cons left right)
)

(define (left-branch mobile)
    (car mobile)
)

(define (right-branch mobile)
    (cdr mobile)
)


(define (make-branch len structure)
    (cons len structure)
)

(define (branch-length branch)
    (car branch)
)

(define (branch-structure branch)
    (cdr branch)
)


(define (total-weight mobile)
    (define (total-weight-branch branch)
        (if (not (pair? (branch-structure branch)))
            (branch-structure branch)
            (total-weight (branch-structure branch))
        )
    )
    (if (not (pair? mobile))
        mobile
        (+
            (total-weight-branch (left-branch mobile))
            (total-weight-branch (right-branch mobile))
        )
    )
)

(define x
    (make-mobile
        (make-branch 3
            (make-mobile
                (make-branch 3 6)
                (make-branch 1 18)
            )
        )
        (make-branch 3 24)
    )
)
(define y
    (make-mobile
        (make-branch 3 3)
        (make-branch 3 3)
    )
)
; simple tests

(display (total-weight 23))
(newline)
(display (total-weight x))
(newline)


(define (balanced-mobile? mobile)
    (define (torque branch)
        (*
            (branch-length branch)
            (total-weight (branch-structure branch))
        )
    )
    (if (not (pair? mobile))
        #t
        (and
            (=
                (torque (left-branch mobile))
                (torque (right-branch mobile))
            )
            (balanced-mobile? (branch-structure (left-branch mobile)))
            (balanced-mobile? (branch-structure (right-branch mobile)))
        )
    )
)

; simple test
(display (balanced-mobile? x))
(newline)



; to answer d, it would require changing just the selectors!
