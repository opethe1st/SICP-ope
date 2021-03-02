(load "ch4-mceval.scm")

(define (and? exp)
    (tagged-list? exp 'and)
)


(define (eval-and exp env)
    (define (eval-with-env args)
        (and (eval (car args) env) (eval-with-env (cdr args)))
    )
    (eval-with-env (operands exp))
)

(define (eval-and exp env)
    (define (eval-with-env exp)
        (eval exp env)
    )
    (and . (map eval-with-env (operands exp)))
)


(define (or? exp)
    (tagged-list? exp 'or)
)


(define (eval-or exp env)
    (define (eval-with-env args)
        (or (eval (car args) env) (eval-with-env (cdr args)))
    )
    (eval-with-env (operands exp))
)

(define (eval-or exp env)
    (define (eval-with-env exp)
        (eval exp env)
    )
    (or . (map eval-with-env (operands exp)))
)
