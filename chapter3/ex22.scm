(define (make-queue)
    (let (
            (queue (cons '() '()))
        )
        (define (front-ptr) (car queue))
        (define (rear-ptr) (cdr queue))
        (define (set-front-ptr! item)
            (set-car! queue item))
        (define (set-rear-ptr! item)
            (set-cdr! queue item))
        (define (empty-queue?) (null? (front-ptr)))
        (define (front-queue)
            (if (empty-queue?)
                (error "FRONT called with an empty queue" queue)
                (car (front-ptr))
            )
        )
        (define (delete-queue!)
            (cond
                ((empty-queue?)
                    (error "DELETE! called with an empty queue" queue)
                )
                (else
                    (set-front-ptr! (cdr (front-ptr)))
                    queue
                )
            )
        )
        (define (insert-queue! item)
            (let ((new-pair (cons item '())))
                (cond
                    ((empty-queue?)
                        (set-front-ptr! new-pair)
                        (set-rear-ptr! new-pair)
                        queue
                    )
                    (else
                        (set-cdr! (rear-ptr) new-pair)
                        (set-rear-ptr! new-pair)
                        queue
                    )
                )
            )
        )
        (define (dispatch m)
            (cond
                ((eq? m 'insert-queue!) insert-queue!)
                ((eq? m 'delete-queue!) delete-queue!)
                ((eq? m 'empty-queue?) empty-queue?)
                ((eq? m 'front-queue?) front-queue)
                ((eq? m 'front-ptr) front-ptr)
                ((eq? m 'rear-ptr) rear-ptr)
            )
        )
        dispatch
    )
)


(define x (make-queue))
((x 'insert-queue!) 12)
((x 'insert-queue!) 1)
((x 'insert-queue!) 2)
((x 'insert-queue!) 3)
((x 'delete-queue!))
((x 'delete-queue!))
((x 'insert-queue!) 3)