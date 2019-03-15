(define (power x n)
    (define (iter x n res)
        (if (= n 0)
            res
            (iter x (- n 1) (* res x))
        )
    )
    (iter x n 1)
)

(define tolerance 0.00000001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance)
    )
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next)
            )
        )
    )
    (try first-guess)
)

(define (compose f g)
    (lambda (x) (f (g x)))
)

(define (repeated f n)
    (lambda (x)
        (if (= n 1)
            (f x)
            ((compose f (repeated f (- n 1))) x)
        )
    )
)

(define (average-damp f)
    (define (average a b)
        (/ (+ a b) 2.0)
    )
    (lambda (x) (average x (f x)))
)


(define (nth-root x n number-of-damps)
    (fixed-point
        (
            (repeated average-damp number-of-damps)
            (lambda
                (y)
                (/
                    x
                    (power y (- n 1))
                )
            )
        )
        1.0
    )
)

; experiments
(display (nth-root 2 1 1))
(newline)
(display (nth-root 9 2 1))
(newline)
(display (nth-root 8 3 1))
(newline)
(display (nth-root 81 4 2))
(newline)
(display (nth-root 32 5 2))
(newline)
(display (nth-root 64 6 2))
(newline)
(display (nth-root 128 7 2))
(newline)
(display (nth-root 256 8 3))
(newline)
(display (nth-root 512 9 3))
(newline)
(display (nth-root 1024 10 3))
(newline)
(display (nth-root 2048 11 3))
(newline)
(display (nth-root 4096 12 3))
(newline)
(display (nth-root 8192 13 3))
(newline)
(display (nth-root 16384 14 3))
(newline)
(display (nth-root 32768 15 3))
(newline)
(display (nth-root 65536 16 4))

; based on these experiments. looks like the damping needs to be
; math.ceil(log(n)/log(2))

(define (find-number-of-damps n)
    (define (iter x ans)
        (if (< x 1)
            ans
            (iter (/ x 2) (+ 1 ans))
        )
    )
    (iter n 0)
)
; tests
;; (display (find-number-of-damps 1))
;; (newline)
;; (display (find-number-of-damps 2))

(define (nth-root x n)
    (fixed-point
        (
            (repeated average-damp (find-number-of-damps n))
            (lambda
                (y)
                (/
                    x
                    (power y (- n 1))
                )
            )
        )
        1.0
    )
)

(newline)
(display (nth-root 32 5))
(newline)
