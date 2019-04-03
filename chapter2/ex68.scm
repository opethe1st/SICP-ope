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


(define sample-tree
    (make-code-tree
        (make-leaf 'A 4)
        (make-code-tree
            (make-leaf 'B 2)
            (make-code-tree
                (make-leaf 'D 1)
                (make-leaf 'C 1)
            )
        )
    )
)


(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(decode sample-message sample-tree)
; evaluated this - it returns - (a d a b b c a)


(define (encode-symbol symbol tree)
    (define (in-list x s)
        (cond
            ((null? s) #f)
            ((eq? (car s) x) #t)
            (else
                (in-list x (cdr s))
            )
        )
    )
    (define (encode-symbol-iter t path-so-far)
        (cond
            ((not (in-list symbol (symbols tree)))
                (error "This symbol can't be found")
            )
            ((leaf? t) path-so-far)
            (
                (in-list
                    symbol
                    (symbols (left-branch t))
                )
                (encode-symbol-iter
                    (left-branch t)
                    (append path-so-far (list '0))
                )
            )
            (else
                (encode-symbol-iter
                    (right-branch t)
                    (append path-so-far (list '1))
                )
            )
        )
    )
    (encode-symbol-iter tree '())
)

(define (encode message tree)
    (if (null? message)
        '()
        (append
            (encode-symbol (car message) tree)
            (encode (cdr message) tree)
        )
    )
)

(equal?
    (encode '(A D A B B C A) sample-tree)
    '(0 1 1 0 0 1 0 1 0 1 1 1 0)
)
