#lang racket

(current-inspector (make-inspector (current-inspector)))


(struct vc (x y) #:inspector (make-inspector (current-inspector)))
;(struct vc (x y))

(equal? (struct->vector (vc 0 0)) (struct->vector (vc 0 0)))

(equal? (vc 0 0) (vc 0 0))

(struct-info (vc 0 0))

;(struct-type-info ((lambda (x y) x)(struct-info (vc 0 0))))
