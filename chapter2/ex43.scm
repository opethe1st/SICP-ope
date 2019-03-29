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
                    (lambda (new-row)
                        (map
                            (lambda (rest-of-queens)
                                (adjoin-position new-row k rest-of-queens)
                            )
                            (queen-cols (- k 1))
                        )
                    )
                    (enumerate-interval 1 board-size)
                )
            )
        )
    )
    (queen-cols board-size)
)


(display
    (queens 7)
)
(newline)

; takes a while for 7. This is because (queen-cols (- k 1)) is called for every row. while in the old version it is called just once
; how long would it take for this version compared to the old one?
; the recursive timing relationship is T(n) = T(n-1)*N -> which is T(n) = N!
; for the version in ex42. it is T(n) = T(n-1) which is constant time?
; TBH not sure what the answer is. :)
; So went online and somewhat convinced by this answer - http://community.schemewiki.org/?sicp-ex-2.43
