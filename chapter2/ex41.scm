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
(define (sum x)
    (accumulate + 0 x)
)
(define (order-tuples-less-than n) ; could make tuples and doubles a variable
    (define (ordered-doubles-less-than-m m)
        (flatmap
            (lambda
                (i)
                (map
                    (lambda (j) (list i j))
                    (enumerate-interval 1 n)
                )
            )
            (enumerate-interval 1 n)
        )
    )
    (filter
        (lambda (x) (< (sum x) n))
        (flatmap
            (lambda (k)
                (map
                    (lambda (j) (cons k j))
                    (ordered-doubles-less-than-m n)
                )
            )
            (enumerate-interval 1 n)
        )
    )
)

(display
    (order-tuples-less-than 7)
)
