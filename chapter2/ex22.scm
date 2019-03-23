(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things) (cons (square (car things)) answer))
        )
    )
    (iter items '())
)

; try it
(display
    (square-list (list 1 3 5 11))
)
(newline)
; the results are in a reverse order. Why?
; Let's look at the sequence for
; (square-list (list 1 2)) is
;; (iter (list 1 2) '())
;; (iter (list 2) (list 1))
;; (iter '() (list 4 1))

; attempted fix that doesn't work
(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter
                (cdr things)
                (cons
                    answer
                    (square (car things))
                )
            )
        )
    )
    (iter items '())
)

; try it
(display
    (square-list (list 1 3 5 11))
)
; oops -- not what we want either.
; Let's look at the sequence for
; (square-list (list 1 2)) is
;; (iter (list 1 2) '())
;; (iter (list 2) (list '() 1))
;; (iter '() (list (list '() 1) 4))
