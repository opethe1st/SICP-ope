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

(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs))
)


(define tree
    (generate-huffman-tree
        '(
            (A 2)
            (BOOM 1)
            (GET 2)
            (JOB 2)
            (NA 16)
            (SHA 3)
            (YIP 9)
            (WAH 1)
        )
    )
)

(define bits
    (encode
        '(Get a job
        Sha na na na na na na na na
        Get a job
        Sha na na na na na na na na
        Wah yip yip yip yip yip yip yip yip yip
        Sha boom
        )
        tree
    )
)

(length bits)
; 84 bits required
; if we used a fixed length code for the 8 symbol alphabet - we would need three bits for each symbol.
; the song has - 36 words so that would have been 36*3 bits
