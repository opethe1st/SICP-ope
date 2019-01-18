
```scheme
(define (a-plus-abs-b a b) ((if (> b 0) + -) a b))
```
The operands are evaluated first - right to left. the operand is evaluated last. - is this implementation dependent - are there
some implementations where the operator is evaluated first?
and then the expression is evalulated
