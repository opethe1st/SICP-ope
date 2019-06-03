

(define (make-table)
    (let ((local-tree '()))

        (define get-key caar)
        (define get-value cdar)

        (define left-branch cadr)

        (define right-branch caddr)

        (define (insert! key value)
            (define (internal-insert! current-node)
                (cond
                    ((null? current-node) (set! local-tree (list (cons key value) '() '())))
                    ((eq? (get-key current-node) key) (set-cdr! current-node value))
                    ((< (get-key current-node) key)
                        (let ((left (left-branch current-node)))
                            (cond
                                ((null? left) (set-car! (cdr current-node) (list (cons key value) '() '())))
                                (else (internal-insert! left))
                            )
                        )
                    )
                    ((> (get-key current-node) key)
                        (let ((right (right-branch current-node)))
                            (cond
                                ((null? right) (set-car! (cddr current-node) (list (cons key value) '() '())))
                                (else (internal-insert! right))
                            )
                        )
                    )
                )
            )
            (internal-insert! local-tree)
        )

        (define (lookup key)
            (define (internal-lookup current-node)
                (cond
                    ((null? current-node) false)
                    ((eq? (get-key current-node) key) (get-value current-node))
                    ((< (get-key current-node) key) (internal-lookup (left-branch current-node)))
                    ((> (get-key current-node) key) (internal-lookup (right-branch current-node)))
                )
            )
            (internal-lookup local-tree)
        )

        (define (dispatch method)
            (cond
                ((eq? method 'insert!) insert!)
                ((eq? method 'lookup) lookup)
                (else (error "Unknown operation -- TABLE" method))
            )
        )
        dispatch
    )
)

(define (get key table)
    ((table 'lookup) key)
)

(define (put key value table)
    ((table 'insert!) key value)
)


(define table (make-table))
(display (get 123 table))
(newline)
(put 123 "value" table)
(display (get 123 table))
(newline)
(newline)
