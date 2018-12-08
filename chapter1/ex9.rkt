(define (+ a b)
    (if (= a 0)
        b
        (inc (+ (dec a ) b))
    )
)
; this is a recursive process
; the next state is
; (inc (inc (+ dec (dec a 1) b)))
; the process is expanding


(define (+ a b)
    (if (= a 0)
        b
        (+ (dec a) (inc b))
    )
)

; this is an iterative process too
; the state of the computation is completely deescribed by the input arguments
; for (+ 4 5) we have
; (+ 3 6) then
; (+ 2 7) then
; (+ 1 8) then
; (+ 0 9) then
; 9
