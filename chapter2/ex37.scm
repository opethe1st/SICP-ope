
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op
            (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)

(define (accumulate-n op init seqs)
    (define (car-elements s)
        (if (null? s)
            s
            (cons
                (car (car s))
                (car-elements (cdr s))
            )
        )
    )
    (define (cdr-elements s)
        (if (null? s)
            s
            (cons
                (cdr (car s))
                (cdr-elements (cdr s))
            )
        )
    )
    (if (null? (car seqs))
        (car seqs)
        (cons
            (accumulate op init (car-elements seqs))
            (accumulate-n op init (cdr-elements seqs))
        )
    )
)

(define (dot-product v w)
    (accumulate + 0 (map * v w))
)
; small test
(display
    (dot-product (list 1 2) (list 3 4))
)
(newline)


(define (matrix-*-vector m v)
    (map (lambda (x) (dot-product x v)) m)
)
; test
(display
    (matrix-*-vector (list (list 1 2) (list 3 4)) (list 1 1))
)
(newline)


(define (transpose mat)
    (accumulate-n cons '() mat)
)
; test
(display
    (transpose (list (list 1 2) (list 3 4)))
)
(newline)


(define (matrix-*-matrix m n)
    (let ((cols (transpose n)))
        (map (lambda (x) (matrix-*-vector cols x)) m)
    )
)
; test
(display
    (matrix-*-matrix
        (list
            (list 1 0)
            (list 0 1)
        )
        (list
            (list 3 4)
            (list 11 7)
        )
    )
)
(newline)
