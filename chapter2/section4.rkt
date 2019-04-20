#lang racket

(provide attach-tag)
(provide type-tag)
(provide contents)
(provide get)
(provide put)
(provide power)
(provide apply-generic)


(define (power m e)
    (cond
        ((= m 0) 0)
        ((= e 0) 1)
        (else (* (power m (- e 1)) m))
    )
)


(define (attach-tag type-tag contents)
    (cons type-tag contents)
)

(define (type-tag datum)
    (cond
        ((pair? datum) (car datum))
        ((number? datum) 'scheme-number)
        (else (error "Bad tagged datum: TYPE-TAG" datum))
    )
)

(define (contents datum)
    (cond
        ((pair? datum) (cdr datum))
        ((number? datum) datum)
        (else (error "Bad tagged datum: CONTENTS" datum))
    )
)


(define *the-table* (make-hash));make THE table
(define (put key1 key2 value) (hash-set! *the-table* (list key1 key2) value));put
(define (get key1 key2) (hash-ref *the-table* (list key1 key2) #f));get

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (error "No method for these types: APPLY-GENERIC"
                    (list op type-tags))
            )
        )
    )
)
