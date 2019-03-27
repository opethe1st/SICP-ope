(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op
            (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)

(define (flatmap proc seq)
    (accumulate append '() (map proc seq))
)

(define (enumerate-interval a b)
    (if (> a b)
        '()
        (cons a (enumerate-interval (+ a 1) b))
    )
)
; test enumerate
;; (display (enumerate-interval 1 6))
;; (newline)

(define (unique-pairs n)
    (flatmap
        (lambda
            (i)
            (map
                (lambda (j) (list i j))
                (enumerate-interval 1 (- i 1))
            )
        )
        (enumerate-interval 1 n)
    )
)

(display
    (unique-pairs 8)
)
(newline)
