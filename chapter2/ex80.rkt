(define *the-table*
    (make-hash)
) ;make THE table

(define (put key1 key2 value)
    (hash-set! *the-table* (list key1 key2) value)
) ;put

(define (get key1 key2)
    (hash-ref *the-table* (list key1 key2) #f)
) ;get

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

(define (install-scheme-number-package)
    (define (tag x) (attach-tag 'scheme-number x))

    (put 'zero? '(scheme-number)
        (lambda (x) (= x 0))
    )

    (put 'add '(scheme-number scheme-number)
        (lambda (x y) (tag (+ x y)))
    )
    (put 'sub '(scheme-number scheme-number)
        (lambda (x y) (tag (- x y)))
    )
    (put 'mul '(scheme-number scheme-number)
        (lambda (x y) (tag (* x y)))
    )
    (put 'div '(scheme-number scheme-number)
        (lambda (x y) (tag (/ x y)))
    )
    (put 'make 'scheme-number
        (lambda (x) (tag x))
    )
    'done
)

(install-scheme-number-package)

(define (make-scheme-number x)
    ((get 'make 'scheme-number) x)
)

(define (zero? x)
    (apply-generic 'zero? x)
)

(zero? (make-scheme-number 1))
(zero? (make-scheme-number 0))
