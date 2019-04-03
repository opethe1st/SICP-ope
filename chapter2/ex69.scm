(define (make-code-tree left right)
    (list
        left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))
    )
)


(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
    (if (leaf? tree)
        (list (symbol-leaf tree))
        (caddr tree)
    )
)

(define (weight tree)
    (if (leaf? tree)
        (weight-leaf tree)
        (cadddr tree)
    )
)

(define (decode bits tree)
    (define (decode-1 bits current-branch)
        (if (null? bits) '()
            (let (
                (next-branch (choose-branch (car bits) current-branch))
                )
                (if (leaf? next-branch)
                    (cons
                        (symbol-leaf next-branch)
                        (decode-1 (cdr bits) tree)
                    )
                    (decode-1 (cdr bits) next-branch)
                )
            )
        )
    )
    (decode-1 bits tree)
)

(define (choose-branch bit branch)
    (cond
        ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: CHOOSE-BRANCH" bit))
    )
)


(define (adjoin-set x set)
    (cond
        ((null? set) (list x))
        ((< (weight x) (weight (car set)))
            (cons x set)
        )
        (else (cons (car set)
            (adjoin-set x (cdr set)))
        )
    )
)

(define (make-leaf-set pairs)
    (if (null? pairs)
        '()
        (let (
            (pair (car pairs))
            )
            (adjoin-set
                (make-leaf
                    (car pair)
                    (cadr pair)
                )
                (make-leaf-set (cdr pairs))
            )
        )
    )
)

(define (make-leaf symbol weight)
    (list 'leaf symbol weight)
)

(define (leaf? object)
    (eq? (car object) 'leaf)
)
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (length l)
    (if (null? l)
        0
        (+ (length (cdr l)) 1)
    )
)
(define (successive-merge leaf-set)
    (cond
        ((null? leaf-set) leaf-set)
        ((= (length leaf-set) 1) (car leaf-set))
        (else
            (successive-merge
                (adjoin-set
                    (make-code-tree (car leaf-set) (cadr leaf-set))
                    (cddr leaf-set)
                )
            )
        )
    )
)


(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs))
)

(generate-huffman-tree '((A 4) (B 2) (D 1) (C 1)))
