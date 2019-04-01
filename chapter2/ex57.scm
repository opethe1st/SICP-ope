(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2))
)
(define (make-sum a1 a2)
    (cond ((=number? a1 0) a2) ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))
    )
)

(define (=number? exp num)
    (and (number? exp) (= exp num))
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

(define (sum? x) (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (make-exponentiation base exponent)
    (cond
        ((= exponent 0) 1)
        ((= exponent 1) base)
        (else (list '** base exponent))
    )
)

(define (exponentiation? x)
    (and (pair? x) (eq? (car x) '**))
)

(define (base expr)
    (if (exponentiation? expr)
        (cadr expr)
        (error "trying to find the base of an expression that's not an exponent")
    )
)

(define (exponent expr)
    (if (exponentiation? expr)
        (caddr expr)
        (error "trying to find the exponent of an expression that's not an exponent")
    )
)


(define (deriv exp var)
    (cond
        ((number? exp) 0)
        ((variable? exp)
            (if (same-variable? exp var) 1 0)
        )
        ((sum? exp)
            (make-sum
                (deriv (addend exp) var)
                (deriv (augend exp) var)
            )
        )
        ((product? exp)
            (make-sum
                (make-product
                    (multiplier exp)
                    (deriv (multiplicand exp) var)
                )
                (make-product
                        (deriv (multiplier exp) var) (multiplicand exp)
                )
            )
        )
        ((exponentiation? exp)
            (make-product
                (exponent exp)
                (make-product
                    (make-exponentiation (base exp) (- (exponent exp) 1)) ; the exponent has to be greater than or equal 0
                    (deriv (base exp) var)
                )
            )
        )
        (else
            (error "unknown expression type: DERIV" exp)
        )
    )
)

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op
            (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)

(define (make-sum-multiple . a)
    (accumulate
        make-sum
        0
        a
    )
)

(define (make-product-multiple . a)
    (accumulate
        make-product
        1
        a
    )
)

(make-sum-multiple 'x 'y 1 2 3)

(deriv (make-sum-multiple 'x 'x 'x) 'x)
)
(deriv
    (make-sum-multiple  (make-product 3 'x) (make-sum-multiple 'x 'y 2))
    'x
)

(deriv (make-product-multiple 'x 'x 'x) 'x)
)
