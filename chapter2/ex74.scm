;; Each divisions file should include a section detailing the type of record
;; and they must write their own packages with procedures that return a record
;; and also to get the addresss or salary

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (error "No method for these types: APPLY-GENERIC"
                    (list op type-tags))
            )
        )
    )
)
; a
(define (get-record name records)
    (apply-generic 'get-record name records)
)


; b
(define (get-salary record)
    (apply-generic 'get-salary record)
)

; c
(define (find-employee-record name files)
    (if (null? files)
        '()
        (if (null? (get-record name (car files)))
            (find-employee-record name (cdr files))
            (get-record name (car files))
        )
    )
)

; d
; write and install a new package
