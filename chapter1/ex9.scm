(define (+ a b)
    (if (= a 0)
        b
        (inc (+ (dec a) b))
    )
)
; (+ 4 5)
; (inc (+ 3 5))
; (inc (inc (+ 2 5)))
; (inc (inc (inc (+ 1 5))))
; (inc (inc (inc (inc (+ 0 5)))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9
; recursive process because it expands


(define (+ a b)
    (if (= a 0)
        b
        (+ (dec a) (inc b))
    )
)

; this is an iterative process
; the state of the computation is completely deescribed by the input arguments
; for (+ 4 5) we have
; (+ 3 6) then
; (+ 2 7) then
; (+ 1 8) then
; (+ 0 9) then
; 9
