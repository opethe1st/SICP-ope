;; EXERCISE 3.40

(define x 10)
(parallel-execute
    (lambda () (set! x (* x x)))
    (lambda () (set! x (* x x x)))
)

; this can be 10**2 or 10**3 or 10**6

(define x 10)

(define s (make-serializer))

(parallel-execute
    (s (lambda () (set! x (* x x))))
    (s (lambda () (set! x (* x x x))))
)
; this can be 10**6
