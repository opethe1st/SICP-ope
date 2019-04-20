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
(define (get-record name file)
    ((get 'get-record (type-tag file)) name)
)
; so this is such that a file has a type-tag that identifies the type of file.
; there would be a package with all the stuff related to a particular division
; with the get-record for a particular division would be registered there too.


; b
(define (get-salary record)
    (apply-generic 'get-salary record)
)
; record should have a type-tag that identifies the division it is for


; c
(define (find-employee-record name files)
    (if (null? files)
        '()
        ; should be using let here technically so I don't get-record twice
        (let ((record (get-record name (car files))))
            (if (null? record)
                (find-employee-record name (cdr files))
                (get-record name (car files))
            )
        )
    )
)

; d
; write and install a new package
