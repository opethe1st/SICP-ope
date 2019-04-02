(define (list->tree elements)
    (car (partial-tree elements (length elements)))
)


(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
    (list entry left right)
)


(define (partial-tree elts n)
    (if (= n 0)
        (cons '() elts)
        (let (
                (left-size (quotient (- n 1) 2))
            )
            (let    (
                        (left-result (partial-tree elts left-size))
                    )
                    (let (
                            (left-tree (car left-result))
                            (non-left-elts (cdr left-result))
                            (right-size (- n (+ left-size 1)))
                        )
                        (let (
                                (this-entry
                                    (car non-left-elts))
                                    (right-result
                                        (partial-tree
                                            (cdr non-left-elts)
                                            right-size
                                        )
                                    )
                            )
                            (let (
                                    (right-tree (car right-result))
                                    (remaining-elts
                                        (cdr right-result)
                                    )
                                )
                                (cons
                                    (make-tree
                                        this-entry
                                        left-tree
                                        right-tree
                                    )
                                    remaining-elts
                                )
                            )
                        )
                    )
            )
        )
    )
)

(define (tree->list tree)
    (define (copy-to-list tree result-list)
        (if (null? tree)
            result-list
            (copy-to-list
                (left-branch tree)
                (cons
                    (entry tree)
                    (copy-to-list (right-branch tree) result-list)
                )
            )
        )
    )
    (copy-to-list tree '())
)

(define (union-set-ordered-list s1 s2)
    (cond
        ((null? s1) s2)
        ((null? s2) s1)
        ((= (car s1) (car s2))
            (cons (car s1) (union-set-ordered-list (cdr s1) (cdr s2)))
        )
        ((< (car s1) (car s2))
            (cons (car s1) (union-set-ordered-list (cdr s1) s2))
        )
        ((> (car s1) (car s2))
            (cons (car s2) (union-set-ordered-list s1 (cdr s2)))
        )
    )
)
(define (intersection-set-ordered-list s1 s2)
    (cond
        ((null? s1) '())
        ((null? s2) '())
        ((= (car s1) (car s2))
            (cons (car s1) (intersection-set-ordered-list (cdr s1) (cdr s2)))
        )
        ((< (car s1) (car s2))
            (intersection-set-ordered-list (cdr s1) s2)
        )
        ((> (car s1) (car s2))
            (intersection-set-ordered-list s1 (cdr s2))
        )
    )
)

(define (union-set s1 s2)
    (list->tree (union-set-ordered-list (tree->list s1) (tree->list s2)))
)

(define (intersection-set s1 s2)
    (list->tree (intersection-set-ordered-list (tree->list s1) (tree->list s2)))
)


(union-set
    (list->tree (list 1 2 4))
    (list->tree (list 3 5 6))
)
(intersection-set
    (list->tree (list 1 2 4))
    (list->tree (list 1 3 5 6))
)
