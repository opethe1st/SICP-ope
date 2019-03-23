
(define x (list 1 2 3))
(define y (list 4 5 6))

; I expect append to be
; (1 2 3 4 5 6)
(display
    (append x y)
)
(newline)
; I expect this to evaluate to ((1 2 3) 4 5 6)
(display
    (cons x y)
)
(newline)
; I expect this to evaluate to ((1 2 3) (4 5 6))
(display
    (list x y)
)
(newline)
