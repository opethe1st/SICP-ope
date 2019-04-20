(require "chapter2/section4.rkt")

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2))
)
(define (=number? exp num)
    (and (number? exp) (= exp num))
)

(define (deriv exp var)
    (define (operator exp) (car exp))
    (define (operands exp) (cdr exp))
    (cond
        ((number? exp) 0)
        ((variable? exp)
            (if (same-variable? exp var) 1 0)
        )
        (else
            ((get 'deriv (operator exp))
                (operands exp)
                var
            )
        )
    )
)


; a. We can't assimilate number? and variable? because they dont share the same structure of a list with operator and operands

; b.

(define (install-deriv-package)

    (define (sum? x) (and (pair? x) (eq? (car x) '+)))

    (define (addend s) (car s))

    (define (augend s) (cadr s))

    (define (multiplier p) (car p))

    (define (multiplicand p) (cadr p))

    (define (base p) (car p))
    (define (exponent p) (cadr p))

    (define (make-sum a1 a2)
        (cond ((=number? a1 0) a2) ((=number? a2 0) a1)
            ((and (number? a1) (number? a2)) (+ a1 a2))
            (else (list '+ a1 a2))
        )
    )
    (define (make-product m1 m2)
        (cond
            ((or (=number? m1 0) (=number? m2 0)) 0)
            ((=number? m1 1) m2)
            ((=number? m2 1) m1)
            ((and (number? m1) (number? m2)) (* m1 m2))
            (else (list '* m1 m2))
        )
    )
    (define (make-exponent m e)
        (cond
            ((or (=number? m 0) (=number? e 0)) 0)
            ((=number? m 0) 0)
            ((=number? e 0) 1)
            ((and (number? m) (number? e)) (power m e))
            (else (list '** m e))
        )
    )
    (define (deriv-sum exp var)
        (make-sum
            (deriv (addend exp) var)
            (deriv (augend exp) var)
        )
    )
    (define (deriv-product exp var)
        (make-sum
            (make-product
                (multiplier exp)
                (deriv (multiplicand exp) var)
            )
            (make-product
                (deriv (multiplier exp) var)
                (multiplicand exp)
            )
        )
    )
    (define (deriv-exponent exp var)
        (make-product
            (exponent exp)
            (make-exponent
                (base exp)
                (- (exponent exp) 1)
            )
        )
    )

    (put 'deriv '+ deriv-sum)
    (put 'deriv '* deriv-product)
    (put 'deriv '** deriv-exponent)
)

(install-deriv-package)

(deriv '(+ x 3) 'x)


(deriv '(* x y) 'x)

(deriv '(* (* x y) (+ x 3)) 'x)

(deriv '(** x 5) 'x)

; d. The only change required is to change how the (put ...) lines
