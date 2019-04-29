(define (make-account balance password)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin
                (set! balance (- balance amount))
                balance
            )
            "Insufficient funds"
        )
    )
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance
    )
    (define (dispatch m)
        (cond
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request: MAKE-ACCOUNT"m))
        )
    )
    (define (passworded-dispatch pass method)
        (if (eq? password pass)
            (dispatch method)
            (lambda (x) "Incorrect password")
        )
    )
    passworded-dispatch
)

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40) ; this should be 60
((acc 'some-other-password 'deposit) 50) ; this should be "Incorrect password"
