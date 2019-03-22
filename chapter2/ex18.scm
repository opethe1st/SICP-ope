
(define (append list1 list2)
    (if (null? list1)
        list2
        (cons
            (car list1)
            (append (cdr list1) list2)
        )
    )
)

(define (reverse items)
    (if  (null? (cdr items))
            items
            (append (reverse (cdr items)) (list (car items)))
    )
)

(display (reverse (list 123 1)))
(newline)
(display (reverse (list 124 53 5 -1 0 12 5)))
(newline)
