
```scheme
(define (a-plus-abs-b a b) ((if (> b 0) + -) a b))
```
The operator is evaluated first, then the operands, then the operands are applied to the operator
