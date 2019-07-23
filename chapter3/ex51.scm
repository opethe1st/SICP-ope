(define (show x)
    (display-line x)
    x
)

(define x (stream-map show (stream-enumerate-intervals 0 10)))
; this displays 0
(stream-ref x 5)
; this displays 1, 2, 3, 4, 5
(stream-ref x 7)
; this displays 6, 7

; the reason it doesn't display the earlier stuff is that, the return value is memoized so the (display-line x) is not executed twice
