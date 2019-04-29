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

    (define failed-password-attempts 0)
    (define (call-the-cops amount)
        (display "Hey, Popo, hackers have been trying to get to my account")
    )
    (define (incorrect-password)
        (begin
            (set! failed-password-attempts (+ 1 failed-password-attempts))
            (if (> failed-password-attempts 2)
                call-the-cops
                (lambda (amount) "Incorrect password")
            )
        )
    )

    (define (passworded-dispatch pass method)
        (if (eq? password pass)
            (dispatch method)
            (incorrect-password)
        )
    )
    passworded-dispatch
)

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40) ; this should be 60
((acc 'some-other-password 'deposit) 50) ; this should be "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; this should be "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; this should call the cops too.
