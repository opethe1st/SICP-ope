
;; EXERCISE 3.38
(set! balance (+ balance 10)) ; 1
(set! balance (- balance 20)) ; 2
(set! balance (- balance (/ balance 2))) ; 3

; all the possible values for balance at the end
; if the order is 1, 2, 3
; then we have balance -> 100 -> 110 -> 90 -> 45
; if the order is 1, 3, 2
; then we have balance -> 100 -> 110 -> 55 -> 35
; if the order is 2, 1, 3
; then we have balance -> 100 -> 80 -> 90 -> 45
; if the order is 2, 3, 1
; then we have balance -> 100 -> 80 -> 40 -> 50
; if the order is 3, 1, 2
; then we have balance -> 100 -> 50 -> 60 -> 40
; the order is 3, 2, 1
; then we have balance -> 100 -> 50 -> 30 -> 40

; so the possible balances are 35, 40, 45, 50

; b) what if these processes are allowed to be interleaved.
; sounds like too much work😅 . But I know that if any of them are interleaved first. the last operation would take precdence as if the first never happened
; two of the operations are interleaved at the beginning the last one is run
; 1, 2 interleaved
;  with the interleaved operations happening first
;       with 2 last
;           balance is 80 then we get 40 when 3 is done
;       with 1 last
;           balance is 90 then we get 45 when 3 is done
;   with the interleaved operations happening last
;       with 2 last
;           balance is 50 then we get 30
;       with 1 last
;           balance is 50 then we get 60
; 1, 3 interleaved
;   with the interleaved operations happening first
;       with 3 last
;           balance is 50 then we get 30 when the 2 is done
;       with 1 last
;           balance is 90 then we get 70 when 2 is done
;   with the interleaved operations happening last
;       with 3 last
;           balance is 80 then we get 40
;       with 1 last
;           balance is 80 then we get 90
; 2, 3 interleaved
;   with the interleaved operations happening first
;       with 3 last
;           balance is 50 then we get 30 when the 2 is done
;       with 2 last
;           balance is 90 then we get 70 when 2 is done
;   with the interleaved operations happening last
;       with 3 last
;           balance is 110 then we get 55
;       with 2 last
;           balance is 110 then we get 90
; if all that the same time, the last one to execute would be retained- so we will have 110, 80 and 50.
