(define sum 0)

(define (accum x)
    (set! sum (+ x sum) sum)
)

(define seq
    (stream-map accum (stream-enumerate-interval 1 20))
)
; seq is 0, 0, 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66, 78, 91, 105, 120, 136, 153, 171, 190, 210
; sum = 1 here since the car of the stream is evaluated

(define y (stream-filter even? seq))
; sum here is 6 since we since we evalute the original expression till we reach an even value
(define
    z
    (stream-filter (lambda (x) (= (remainder x 5) 0)) seq)
)
; sum here is 10 since we evaluate seq till we reach an multiple of 5

(stream-ref y 7)
; y is evens in seq which is - 6, 10, 28, 36, 66, 78, 120, 136
; sum here is 136 - evaluates till it gets to 136
(display-stream z)
; this displays -  10, 15, 45, 55, 105, 120

; at this point, sum is 210
