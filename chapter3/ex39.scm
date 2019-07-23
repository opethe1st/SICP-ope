
(define x 10)

(define s (make-serializer))

(parallel-execute
    (lambda () (set! x ((s (lambda () (* x x))))))
    (s (lambda () (set! x (+ x 1))))
)

; the possible values are 100, 121 and 101
