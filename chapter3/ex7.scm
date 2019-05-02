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

(define (make-joint account account-password new-password)
    (lambda (password method)
        (if (eq? password new-password)
            (account account-password method)
            (error "Wrong password")
        )
    )
)

(define acc (make-account 100 'secret-password))
(define
    paul-acc
    (make-joint acc 'secret-password 'joint-password)
)

((paul-acc 'joint-password 'withdraw) 40) ; this should be 60
((acc 'secret-password 'withdraw) 40) ; this should be 60
