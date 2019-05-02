(define f
    (let ((state #t))
        (lambda (x)
            (cond
                ((and state (= x 0)) (begin (set! state #f) 1))
                ((and state (= x 1)) (begin (set! state #f) 1))
                ((and (not state) (= x 0)) 0)
                ((and (not state) (= x 1)) -1)
            )
        )
    )
)


(+ (f 0) (f 1))
