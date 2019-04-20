;; The problem was that complex numbers weren't tagged with 'complex but with 'rectangular or 'polar
;; by adding this to the operation - type table
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

;; when (magnitude z) is called it delegates to apply-generic. apply-generic checks for the type of the argument which is 'complex and then passes the contents back
;; to magnitude again but this time with the tag - 'rectangular or 'polar and it proceeds as expected.

;; apply-generic is called twice
