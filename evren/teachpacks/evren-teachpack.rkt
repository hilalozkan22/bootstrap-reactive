#lang racket
; evren (ikinci hafta) teachpack
; otomatik inspect edilen STRUCT, ÖRNEK (yani check-expect ,ve structlerle çalışıyor)
; artı SES, yani play-sound

(require 2htdp/universe)
(require 2htdp/image)
(require (only-in racket/gui/base play-sound))
(require test-engine/racket-tests)

(provide STRUCT SES
         (all-from-out 2htdp/universe)
         (all-from-out 2htdp/image)
         (all-from-out test-engine/racket-tests)
         play-sound)
(provide (rename-out (check-expect ÖRNEK)))

(define (SES s)
  (play-sound s true))

(define-syntax-rule (STRUCT id body)
  (struct id body  #:inspector (make-inspector (current-inspector))))

;(STRUCT v (x y))

;(check-expect (v 1 1) (v 1 1))


