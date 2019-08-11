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

;iki-katlı : pasta -> pasta
;Girilen pastanın kat sayısının iki katına sahip diğer özellikleri aynı olan yeni bir pasta verir.

(define pasta-test
(pasta "pink" 5 "Mutlu Yıllar!!!" "green" 200 20))

(define pasta-test1
(pasta "purple" 3 "Nice Senelere" "black" 100 10))

(define pasta-test2
(pasta "green" 10 "Mutlu Yıllar" "blue" 150 20))   

(define (iki-katlı x)
(pasta (pasta-renk x) ( * (pasta-kat x) 2) (pasta-mesaj x) (pasta-mesaj-rengi x) (pasta-yarı-çap x) (pasta-kat-kalınlık x)))

(struct v (x y)  #:inspector (make-inspector (current-inspector)))

;scale : vektör sayı -> vektör
;scale fonksiyonu bir vektör ve bir sayı alıp aldığı sayı ile vektörün
;komponentlerinin her ikisini çarpıp yeni bir vektör üretecek.

;Template ;

;(define (fonksiyon-isim girdiler )
;( Fonksiyon ne üretir ? )

;(define (fonksiyon-isim  vektör  sayı)
;( * (struct-birinci-komponent  vektör) sayı) ( *(struct-ikinci-komponent vektör) sayı )))

; Örnekler ;
(define v-test
( v 3 5 ))

(define v-test1
( v 2 8 ))

(define v-test2
( v 5 15 ))

;Aşamalar : 
;girdi olarak sadace bir fonksiyon alarak sayı yerine 2 sayısını tanımlayıp struct
;yapısının kullanımını doğru yazıp yazmadığımı kontrol ettim.

;Deneme
(define (scale-deneme v-deneme)
( v ( * (v-x v-deneme) 2) ( * (v-y v-deneme) 2 )))

;Gerçek
(define (scale v-bir-fonk a)
( v ( * (v-x v-bir-fonk) a) ( * (v-y v-bir-fonk) a)))


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
