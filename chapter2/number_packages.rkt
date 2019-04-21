#lang racket

(provide attach-tag)
(provide type-tag)
(provide contents)
(provide get)
(provide put)
(provide power)
(provide apply-generic)


(define (power m e)
    (cond
        ((= m 0) 0)
        ((= e 0) 1)
        (else (* (power m (- e 1)) m))
    )
)

(define (square x)
    (power x 2)
)

(define (attach-tag type-tag contents)
    (cons type-tag contents)
)

(define (type-tag datum)
    (cond
        ((pair? datum) (car datum))
        ((number? datum) 'scheme-number)
        (else (error "Bad tagged datum: TYPE-TAG" datum))
    )
)

(define (contents datum)
    (cond
        ((pair? datum) (cdr datum))
        ((number? datum) datum)
        (else (error "Bad tagged datum: CONTENTS" datum))
    )
)


(define *the-table* (make-hash));make THE table
(define (put key1 key2 value) (hash-set! *the-table* (list key1 key2) value));put
(define (get key1 key2) (hash-ref *the-table* (list key1 key2) #f));get

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


(provide install-scheme-number-package)
(provide install-rational-package)
(provide install-real-package)
(provide install-complex-package)
(provide make-scheme-number)
(provide make-real)
(provide make-rational)
(provide make-complex-from-real-imag)
(provide make-complex-from-mag-ang)
(provide numer)
(provide denom)
(provide real-part)
(provide equ?)


(define (equ? x y)
    (apply-generic 'equ? x y)
)

(define (install-scheme-number-package)
    (define (tag x)
        (attach-tag 'scheme-number x)
    )
    (put 'add '(scheme-number scheme-number)
        (lambda (x y) (tag (+ x y)))
    )
    (put 'sub '(scheme-number scheme-number)
        (lambda (x y) (tag (- x y)))
    )
    (put 'mul '(scheme-number scheme-number)
        (lambda (x y) (tag (* x y)))
    )
    (put 'div '(scheme-number scheme-number)
        (lambda (x y) (tag (/ x y)))
    )
    (put 'make 'scheme-number
        (lambda (x) (tag x))
    )
    (put 'equ? '(scheme-number scheme-number)
        (lambda (x y) (= x y))
    )
    'done
)

(define (make-scheme-number n)
    ((get 'make 'scheme-number) n)
)
(install-scheme-number-package)



(define (install-real-package)
    (define (tag x)
        (attach-tag 'real x)
    )
    (put 'add '(real real)
        (lambda (x y) (tag (+ x y)))
    )
    (put 'sub '(real real)
        (lambda (x y) (tag (- x y)))
    )
    (put 'mul '(real real)
        (lambda (x y) (tag (* x y)))
    )
    (put 'div '(real real)
        (lambda (x y) (tag (/ x y)))
    )
    (put 'make 'real
        (lambda (x) (tag x))
    )
    (put 'equ? '(real real)
        (lambda (x y) (= x y))
    )
    'done
)

(define (make-real n)
    ((get 'make 'real) n)
)
(install-real-package)



(define (numer x) (car x))
(define (denom x) (cdr x))

(define (install-rational-package)
    ;; internal procedures
    (define (make-rat n d)
        (let ((g (gcd n d)))
        (cons (/ n g) (/ d g)))
    )
    (define (add-rat x y)
        (make-rat (+ (* (numer x) (denom y))
                    (* (numer y) (denom x)))
                (* (denom x) (denom y))
        )
    )
    (define (sub-rat x y)
        (make-rat (- (* (numer x) (denom y))
                    (* (numer y) (denom x)))
                (* (denom x) (denom y))
        )
    )
    (define (mul-rat x y)
        (make-rat (* (numer x) (numer y))
                (* (denom x) (denom y))
        )
    )
    (define (div-rat x y)
        (make-rat (* (numer x) (denom y))
                (* (denom x) (numer y))
        )
    )
    ;; interface to rest of the system
    (define (tag x) (attach-tag 'rational x))
    (put 'add '(rational rational)
        (lambda (x y) (tag (add-rat x y)))
    )
    (put 'sub '(rational rational)
        (lambda (x y) (tag (sub-rat x y)))
    )
    (put 'mul '(rational rational)
        (lambda (x y) (tag (mul-rat x y))))
    (put 'div '(rational rational)
        (lambda (x y) (tag (div-rat x y))))

    (put 'make 'rational
        (lambda (n d) (tag (make-rat n d))))
    (put 'equ? '(rational rational)
        (lambda (x y) (and (= (numer x) (numer y)) (= (denom x) (denom y))))
    )
    'done
)

(define (make-rational n d)
    ((get 'make 'rational) n d)
)
(install-rational-package)



(define (install-rectangular-package)
    ;; internal procedures
    (define (real-part z) (car z))
    (define (imag-part z) (cdr z))
    (define (make-from-real-imag x y) (cons x y))
    (define (magnitude z)
        (sqrt (+ (square (real-part z))
                (square (imag-part z)))))
    (define (angle z)
        (atan (imag-part z) (real-part z)))
    (define (make-from-mag-ang r a)
        (cons (* r (cos a)) (* r (sin a))))

    ;; interface to the rest of the system
    (define (tag x) (attach-tag 'rectangular x))
    (put 'real-part '(rectangular) real-part)
    (put 'imag-part '(rectangular) imag-part)
    (put 'magnitude '(rectangular) magnitude)
    (put 'angle '(rectangular) angle)
    (put 'make-from-real-imag 'rectangular
        (lambda (x y) (tag (make-from-real-imag x y)))
    )
    (put 'make-from-mag-ang 'rectangular
        (lambda (r a) (tag (make-from-mag-ang r a)))
    )
    'done
)
(install-rectangular-package)



(define (install-polar-package)
    ;; internal procedures
    (define (magnitude z) (car z))
    (define (angle z) (cdr z))
    (define (make-from-mag-ang r a) (cons r a))
    (define (real-part z)
        (* (magnitude z) (cos (angle z))))
    (define (imag-part z)
        (* (magnitude z) (sin (angle z))))
    (define (make-from-real-imag x y)
        (cons (sqrt (+ (square x) (square y)))
            (atan y x)))

    ;; interface to the rest of the system
    (define (tag x) (attach-tag 'polar x))
    (put 'real-part '(polar) real-part)
    (put 'imag-part '(polar) imag-part)
    (put 'magnitude '(polar) magnitude)
    (put 'angle '(polar) angle)
    (put 'make-from-real-imag 'polar
        (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'polar
        (lambda (r a) (tag (make-from-mag-ang r a))))
    'done
)
(install-polar-package)



(define (install-complex-package)
    ;; imported procedures from rectangular and polar packages
    (define (make-from-real-imag x y)
        ((get 'make-from-real-imag 'rectangular) x y))
    (define (make-from-mag-ang r a)
        ((get 'make-from-mag-ang 'polar) r a))
    ;; internal procedures
    (define (add-complex z1 z2)
        (make-from-real-imag
            (+ (real-part z1) (real-part z2))
            (+ (imag-part z1) (imag-part z2))
        )
    )
    (define (sub-complex z1 z2)
        (make-from-real-imag
            (- (real-part z1) (real-part z2))
            (- (imag-part z1) (imag-part z2))
        )
    )
    (define (mul-complex z1 z2)
        (make-from-mag-ang
            (* (magnitude z1) (magnitude z2))
            (+ (angle z1) (angle z2))
        )
    )
    (define (div-complex z1 z2)
        (make-from-mag-ang
            (/ (magnitude z1) (magnitude z2))
            (- (angle z1) (angle z2))
        )
    )

    ;; interface to rest of the system
    (define (tag z) (attach-tag 'complex z))
    (put 'add '(complex complex)
        (lambda (z1 z2) (tag (add-complex z1 z2)))
    )
    (put 'sub '(complex complex)
        (lambda (z1 z2) (tag (sub-complex z1 z2)))
    )
    (put 'mul '(complex complex)
        (lambda (z1 z2) (tag (mul-complex z1 z2)))
    )
    (put 'div '(complex complex)
        (lambda (z1 z2) (tag (div-complex z1 z2)))
    )
    (put 'make-from-real-imag 'complex
        (lambda (x y) (tag (make-from-real-imag x y)))
    )
    (put 'make-from-mag-ang 'complex
        (lambda (r a) (tag (make-from-mag-ang r a)))
    )
    (put 'real-part '(complex) real-part)
    (put 'imag-part '(complex) imag-part)
    (put 'magnitude '(complex) magnitude)
    (put 'angle '(complex) angle)
    (put 'equ? '(complex complex)
        (lambda (a b)
            (and
                (= (real-part a) (real-part a))
                (= (imag-part a) (imag-part a))
            )
        )
    )
    'done
)

(define (real-part x)
    (apply-generic 'real-part x)
)
(define (imag-part x)
    (apply-generic 'imag-part x)
)

(define (make-complex-from-real-imag x y)
    ((get 'make-from-real-imag 'complex) x y)
)

(define (make-complex-from-mag-ang r a)
    ((get 'make-from-mag-ang 'complex) r a)
)

(install-complex-package)


; coercion
(provide raise)

(define (install-coercion-package)
    (define (scheme-number->rational x)
        (make-rational x 1)
    )
    (define (rational->real x)
        (make-real (/ (numer x) (denom x)))
    )
    (define (real->complex x)
        (make-complex-from-real-imag x 0)
    )

    (put 'raise '(scheme-number) scheme-number->rational)
    (put 'raise '(rational) rational->real)
    (put 'raise '(real) real->complex)
)

(install-coercion-package)

(define (raise x)
    (apply-generic 'raise x)
)
