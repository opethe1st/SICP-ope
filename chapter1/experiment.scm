(define (get-plus-operator)
    (display "operator")
    (+)
)

(define (get-operand value)
    (display value)
    value
)


(get-plus-operator) (get-operand 3) (get-operand 4))