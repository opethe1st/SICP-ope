

(define (lookup given-key set-of-records)
    (cond
        ((null? set-of-records) #f)
        ((equal? given-key (key (entry set-of-records)))
            (entry set-of-records)
        )
        ((< given-key (car set-of-records))
            (lookup given-key (left-branch set-of-branch))
        )
        ((> given-key (car set-of-records))
            (lookup given-key (right-branch set-of-branch))
        )
    )
)
