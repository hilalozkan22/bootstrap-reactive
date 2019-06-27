#lang racket
(require 2htdp/universe)
(require 2htdp/image)

; veri yapı
; pasta:
; renk - color
; mesaj-rengi - color
; kat - sayı
; mesaj - string
; yarı-çap - sayı
; kat-kalınlık - sayı
(struct pasta (renk kat mesaj mesaj-rengi yarı-çap kat-kalınlık) #:inspector (make-inspector (current-inspector)))

(define pasta-örneği
  (pasta "pink"  8 "Mutlu Yıllar!!!" "green" 200 20))


;;; Verilmiş kod
;;; Buraya dokunma..
(define (draw-pasta p)
  (overlay/align/offset "center" "top" (text (pasta-mesaj p) 16 (pasta-mesaj-rengi p)) 0  (- (pasta-kat-kalınlık p))
                     (draw-katlar (pasta-kat p) (pasta-renk p) (pasta-yarı-çap p) (pasta-kat-kalınlık p))))

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
