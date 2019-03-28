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

(define (make-position x y)
    (cons x y)
)

(define (position-x a)
    (car a)
)

(define (position-y a)
    (cdr a)
)

(define (safe? positions)
    (define (attack? position1 position2)
        (or
            (=
                (abs (- (position-x position1) (position-x position2)))
                (abs (- (position-y position1) (position-y position2)))
            )
            (= (- (position-x position1) (position-x position2)) 0)
            (= (- (position-y position1) (position-y position2)) 0)
        )
    )
    (accumulate
        (lambda (x y) (and x y))
        #t
        (map
            (lambda
                (pos)
                (not (attack? pos (car positions)))
            )
            (cdr positions)
        )
    )
)

;; (display (safe? (list (make-position 1 1) (make-position 2 3))))
;; (newline)
;; (newline)

(define (adjoin-position row k rest-of-queens)
    (cons (make-position row k) rest-of-queens)
)

(define (enumerate-interval a b)
    (if (> a b)
        '()
        (cons a (enumerate-interval (+ a 1) b))
    )
)

(define empty-board '())

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (positions) (safe? positions))
                (flatmap
                    (lambda (rest-of-queens)
                        (map
                            (lambda (new-row)
                                (adjoin-position new-row k rest-of-queens)
                            )
                            (enumerate-interval 1 board-size)
                        )
                    )
                    (queen-cols (- k 1))
                )
            )
        )
    )
    (queen-cols board-size)
)

(define (len l)
    (accumulate + 0 (map (lambda (x) 1) l))
)

(display
    (len (queens 1))
)
(newline)
(display
    (len (queens 2))
)
(newline)
(display
    (len (queens 3))
)
(newline)
(display
    (len (queens 4))
)
(newline)
(display
    (len (queens 5))
)
(newline)
(display
    (len (queens 6))
)
(newline)
(display
    (len (queens 7))
)
(newline)
(display
    (len (queens 8))
)
(newline)

; Looks correct based on this https://oeis.org/A000170
