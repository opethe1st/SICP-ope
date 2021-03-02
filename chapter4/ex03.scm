
(define (eval exp env)
  ((get 'eval (type exp)) exp env)
)



(define (type exp)
    (cond
        ((self-evaluating? exp) 'self-evaluating)
        ((variable? exp) 'variable)
        ((application? exp) 'application)
        ((pair? exp) (car exp))
        (else (error "Unknown expression type -- EVAL" exp))
    )
)
(define (install-eval-functions)
;; could also be in different install-* procedures
    (put 'eval 'self-evaluating (lambda (exp env) exp))
    (put 'eval 'variable lookup-variable-value)
    (put 'eval 'application
        (lambda (exp env)
            (apply (eval (operator exp) env) (list-of-values (operands exp) env))
        )
    )
    (put 'eval 'quoted
        (lambda (exp env)
            (text-of-quotation exp)
        )
    )
    (put 'eval 'set-value! eval-assignment)
    (put 'eval 'define eval-definition)
    (put 'eval 'if eval-if)
    (put 'eval 'lambda (lambda (exp env) (make-procedure (lambda-parameters exp) (lambda-body exp) env)))
    (put 'eval 'begin (lambda (exp env) (eval-sequence (begin-actions exp) env))
    (put 'eval 'cond (lambda (exp env) (eval (cond->if exp) env))
    (put 'eval 'application (lambda (exp env) (apply (eval (operator exp) env) (list-of-values (operands exp) env)))


)
