
(define (make-from-mag-ang mag ang)
    (lambda (op)
        (cond
            ((eq? op 'real-part) (* mag (cos ang)))
            ((eq? op 'imag-part) (* mag (sin ang)))
            ((eq? op 'magnitude) mag)
            ((eq? op 'angle) ang)
            (else (error "Unknown op - make-from-mag-and" op))
        )
    )
)


(define num (make-from-mag-ang 3 4))
(num 'real-part)
(num 'imag-part)
(num 'magnitude)
(num 'angle)
