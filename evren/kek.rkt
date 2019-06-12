#lang racket
(require 2htdp/universe)
(require 2htdp/image)

; veri yapı
; kek:
; renk - color
; mesaj-rengi - color
; kat - sayı
; mesaj - string
; yarı-çap - sayı
; kat-kalınlık - sayı
(struct kek (renk kat mesaj mesaj-rengi yarı-çap kat-kalınlık) #:inspector (make-inspector (current-inspector)))

(define kek-örneği
  (kek "pink"  8 "mutlu yıllar " "green" 200 20))


;;; Verilmiş kod
;;; Buraya dokunma..
(define (draw-kek k)
  (overlay/align/offset "center" "top" (text (kek-mesaj k) 16 (kek-mesaj-rengi k)) 0  (- (kek-kat-kalınlık k))
                     (draw-katlar (kek-kat k) (kek-renk k) (kek-yarı-çap k) (kek-kat-kalınlık k))))

(define (draw-katlar kat-sayısı renk yarı-çap kalınlık)
  (cond
    ((= kat-sayısı 1) (draw-kat renk yarı-çap))
    (else  (overlay/align/offset "left" "top"  (draw-kat renk yarı-çap) 0 kalınlık 
                                     (draw-katlar (- kat-sayısı 1) renk yarı-çap kalınlık)))))

(define (draw-kat renk yarı-çap)
  (overlay
   (ellipse yarı-çap (/ yarı-çap 2) "outline" "black")
   (ellipse yarı-çap (/ yarı-çap 2) "solid" renk)))

;;; Verilmiş kod sonu
;;; need to add testing!!!!!

;; need to add automatic inspector...
