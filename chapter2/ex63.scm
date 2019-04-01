(define (tree->list-1 tree)
    (if (null? tree)
        '()
        (append
            (tree->list-1 (left-branch tree))
            (cons (entry tree) (tree->list-1 (right-branch tree)))
        )
    )
)



(define (tree->list-2 tree)
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

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
    (list entry left right)
)

(define x
    (make-tree 7
        (make-tree 3
            (make-tree 1 '() '()) (make-tree 5 '() '())
        )
        (make-tree 9 '() (make-tree 11 '() '()))
    )
)

(tree->list-1 x)
(tree->list-2 x)


(define y
    (make-tree
        3
        (make-tree 1 '() '())
        (make-tree
            7
            (make-tree 5 '() '())
            (make-tree
                9
                '()
                (make-tree 11 '() '())
            )
        )
    )
)
(tree->list-1 y)
(tree->list-2 y)

(define z
    (make-tree
        5
        (make-tree 3 (make-tree 1 '() '()) '())
        (make-tree
            9
            (make-tree 7 '() '())
            (make-tree 11 '() '())
        )
    )
)
(tree->list-1 z)
(tree->list-2 z)


;a the same
; same order of growth afaik because the algorithms are both linear? so went online to check and convinced the argument that it is
; nlogn for tree->list-1 because of the append being O(n) 
