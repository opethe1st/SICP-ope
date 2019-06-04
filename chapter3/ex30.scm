

(define (ripple-carry-adder a-list b-list c-list s-list carry)
    ;; this assumes that a-list, b-list, c-list and s-list are all of the same length
    (if (not (null? a-list))
        (full-adder (car a-list) (car b-list) carry (car s-list) (car c-list))
        (ripple-carry-adder (cdr a-list) (cdr b-list) (cdr c-list) (cdr s-list) (car c-list))
    )
)


;; the delay needed is n*full-adder-delay
;; full-adder-delay is 2* half-adder delay + or delay
;; half-adder-delay is max(2*and-delay+inverter-delay, or-delay+and-delay)
