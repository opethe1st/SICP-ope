#lang racket
;; Exercise1.1
10 ;; 10
(+ 5 3 4) ;; 12
(- 9 1) ;; 8
(/ 6 2) ;; 3
(+ (* 2 4) (- 4 6)) ;; 6
(define a 3) ;; 3
(define b (+ a 1)) ;; 4
(+ a b (* a b)) ;; 19
(= a b) ;; #false
(if (and (> b a) (< b (* a b)))
      b
      a) ;; 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25)
) ;; 16

(+ 2 (if (> b a ) b a)) ;; 6

(* (cond   ((> a b) a)
            ((< a b) b)
            (else -1))
   (+ a 1)) ;; 16


;; Exercise 1.2
(/ (+ 5
      4
      (- 2
         (- 3
            (+ 6 (/ 4 5))
         )
      )
   )
   (* 3 (- 6 2) (- 2 7))
)


;; Exercise 1.3
(define (largest_number a b c)
   (cond ((and (> a b) (> a c)) a)
         ((and (> b a) (> b c)) b)
         (else c)
   )
)
(define (second_largest_number a b c)
   (cond ((and (> a b) (> b c)) b)
         ((and (> b a) (> a c)) a)
         (else c)
   )
)
(define (square x) (* x x))

(define (sum_of_squares_top_two a b c)
   (+ (square (largest_number a b c)) (square (second_largest_number a b c)))
)
;; testing
(sum_of_squares_top_two 5 12 1)


;; Exercise 1.4
;; The operator is evaluated first then the operands are evaluated and then the expression is evalulated


;; Exercise 1.5
;; In applicative order, both operands need to be evaluated - (p) gets evaluated forever
(define (p) (p))
(define (test x y)
   (if (= x 0) 0 y)
)


;; Exercise 1.6
;; Goes into an infinite loop, because it keeps trying to evaluate the left and right


;; Exerciser 1.7
