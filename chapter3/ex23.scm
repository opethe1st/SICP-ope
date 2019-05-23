;; Node object
(define (make-node item front-ptr rear-ptr)
    (cons item (cons front-ptr rear-ptr))
)

(define (get-data node)
    (car node)
)
(define (pointers node)
    (cdr node)
)

(define (front-ptr-for-node node)
    (car (pointers node))
)

(define (rear-ptr-for-node node)
    (cdr (pointers node))
)

(define (set-rear-ptr-for-node! node ptr)
    (set-cdr! (pointers node) ptr)
)


; Deque object
(define (make-deque)
    (cons '() '())
)

(define (front-ptr deque)
    (car deque)
)

(define (rear-ptr deque)
    (cdr deque)
)

(define (set-front-ptr! deque node)
    (set-car! deque node)
)

(define (set-rear-ptr! deque node)
    (set-cdr! deque node)
)

(define (empty-deque? deque)
    (null? (front-ptr deque))
)

; selectors
(define (front-deque deque)
    (if (empty-deque? deque)
        (error "FRONT called with an empty queue" deque)
        (car (front-ptr deque))
    )
)

(define (rear-deque deque)
    (if (empty-deque? deque)
        (error "REAR called with an empty queue" deque)
        (car (rear-ptr deque))
    )
)

; mutators
(define (front-insert-deque! deque item)
    (if (empty-deque? deque)
        (let ((node (make-node item '() '())))
            (set-front-ptr! deque node)
            (set-rear-ptr! deque node)
        )
        (let ()
            (define front-node (front-ptr deque))
            (define new-front-node (make-node item front-node '()))
            (set-front-ptr! deque new-front-node)
            (set-rear-ptr-for-node! front-node new-front-node)
            (newline)
        )
    )
)


(define (print-deque deque)
    (define (iter-print dq)
        (if (null? dq)
            (display ")")
            (begin
                (display (get-data dq))
                (display " ")
                (iter-print (front-ptr-for-node dq))
            )
        )
    )
    (newline)
    (display "(")
    (if (empty-deque? deque)
        (begin
            (display ")")
        )
        (iter-print (front-ptr deque))
    )
)


(define dq (make-deque))
(front-insert-deque! dq 123)
(front-insert-deque! dq 345)
(print-deque dq)
