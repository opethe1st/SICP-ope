; before going into generalizing via mutexes or test-and-set operations. This is how i would have generalized
(define (make-semaphore size)
    (let (cells (make-n-cells size))
        (define (the-semaphore m)
            (cond
                ((eq? m 'acquire)
                    (if (loop-test-and-set! cells)
                        (the-semaphore 'acquire)
                    )
                )
                ((eq? m 'acquire)
                    (clear-a-cell cells)
                )
            )
        )
    )
)
(define (loop-test-and-set! cells)
    (define (iter cells)
        (cond
            ((null? cells)
                true ; all the cells have been set to true already
            )
            ((car cells) (iter (cdr cells)))
            (else (begin (set-car! cells true)) false) ; if (car cells) is false
        )
    )
    (without-interrupts
        (iter cells)
    )
)
; I like this version - it is very close in spirit to the original mutex implementation

; a) with mutexes
(define (make-semphore size)
    (let (mutexes (make-mutexes size))
        (define (the-semaphore m)
            (cond
                ((eq? m 'acquire')
                    (if (acquire-a-mutex! mutexes)
                        (the-semaphore 'acquire) ; try again
                    )
                )
                ((eq? m 'release)
                    (release-a-mutex! mutexes)
                )
            )
        )
    )
)


; b) in terms of atomic test-and-set operations. not sure how to do this so I will skip
(define (make-semaphore size)
    ()
)
