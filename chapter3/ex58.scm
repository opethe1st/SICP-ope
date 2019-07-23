(define (expand num den radix)
    (cons-stream
        (quotient (* num radix) den)
        (expand (remainder (* num radix)) den radix)
    )
)

; this computes the digits in the expansion of num/den base radix

