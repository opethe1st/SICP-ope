; write a version of list-of value that evaluates operands from left to right regardless of the order of evaluation in the underlying Lips
; also write a version that evaluates operands from right to left

(define (list-of-values-left-to-right exps env)
    (define first (eval (first-operand exps) env))
    (define right (list-of-values (rest-operands exps) env))
    (if (no-operands? exps)
        '()
        (cons
            first
            rest
        )
    )
)

(define (list-of-values-right-to-left exps env)
    (define right (list-of-values (rest-operands exps) env))
    (define first (eval (first-operand exps) env))
    (if (no-operands? exps)
        '()
        (cons
            first
            rest
        )
    )
)
