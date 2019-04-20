(require "chapter2/section4.rkt")

(define (apply-generic op . args)
    (define (apply-generic-with-args op args)
        (let ((type-tags (map type-tag args)))
            (let ((proc (get op type-tags)))
                (if proc
                    (apply proc (map contents args))
                    (apply-generic-with-args op (get-coercion-args args))
                )
            )
        )
    )
    (apply-generic-with-args op args)
)

; coerce every argument to the type of the first argument
(define (get-coercion-args args)
    (define (coerce item)
        ((get-coercion (type-tag item) (type-tag (car args)))
            item
        )
    )
    (map coerce args)
)
