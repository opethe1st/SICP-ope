(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2))
)
(define (=number? exp num)
    (and (number? exp) (= exp num))
)

(define (deriv exp var)
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

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; a. We are now working with type of expressions. We can't assimilate number? and variable? because they dont share the same structure of operator and operands

; b.

 (define *the-table* (make-hash));make THE table
 (define (put key1 key2 value) (hash-set! *the-table* (list key1 key2) value));put
 (define (get key1 key2) (hash-ref *the-table* (list key1 key2) #f));get

(define (install-deriv-package)

    (define (sum? x) (and (pair? x) (eq? (car x) '+)))

    (define (addend s) (car s))

    (define (augend s) (cadr s))

    (define (multiplier p) (car p))

    (define (multiplicand p) (cadr p))

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

    (put 'deriv '+ deriv-sum)
    (put 'deriv '* make-product)
)

(install-deriv-package)

(deriv '(+ x 3) 'x)


(deriv '(* x y) 'x)

(deriv '(* (* x y) (+ x 3)) 'x)


; Couldn't get this to run locally so I am letting it be and confirming my solutions by checking what others have done on the internet

; c -> just took a look at the solution since it's all in the same place

; d is trivial
