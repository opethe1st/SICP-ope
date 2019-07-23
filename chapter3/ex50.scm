(require "chapter3/ch3.rkt")

(define the-empty-stream '())

(define (stream-null? l)
    (null? l)
)

(define (stream-map proc . argstream)
    (if (stream-null? (car argstream))
        the-empty-stream
        (cons-stream
            (apply proc (map stream-car argstreams))
            (apply stream-map (cons proc (map stream-cdr argstreams)))
        )
    )
)
