#lang racket
(require "teachpacks/evren-teachpack.rkt")
;(SES "ses/bark.wav")
;örnek BACKGROUND (değiştireceksin)
(define BACKGROUND (rectangle  640 480  "solid" "gray")) 
;örnek FRAME-RATE (değiştireceksin)
(define FRAME-RATE 12)
;örnek evren STRUCT tanımı (değiştireceksin)
(STRUCT evren (oyuncu ödül))
;---------------------------------------------------------------------

;; struct v
;; 2 boyutlu vektör
;; x : sayı x koordinatı
;; y : sayı y koordinatı
(STRUCT v (x y) )

(define test-circle (circle 10 "solid" "purple"))
(define test-circle2 (circle 15 "solid" "red"))
(define test-square (square 100 "solid" "green"))
(define test-square2 (square 200 "solid" "yellow"))


;; v*
;; v sayı -> v
;; bir vektörün her iki kompnentini bir sayı ile çarparak yeni bir vektör,
;; örnekler
(ÖRNEK (v* (v 2 3) 5) (v 10 15))
(ÖRNEK (v* (v -2 -3) 5) (v -10 -15))
(ÖRNEK (v* (v -2 -3) 0) (v 0 0))
(ÖRNEK (v* (v -2 -3) -5) (v 10 15))
;; template
;;(define (v* vk s)
;;  (v ..... (v-x vk)  .... (v-y vk)))
;;
(define (v* vk s)
  (v (* s (v-x vk))  (* s (v-y vk))))



;;v+
;;v v -> v
;;iki vektörün her iki kompnententi x ler kendi arasında y ler kendi arasında olacak şekilde toplanır yeni bir vektör verir.
;;örnekler
(ÖRNEK (v+ (v 5 8) (v 2 1)) (v 7 9))
(ÖRNEK (v+ (v -6 3) (v 5 4)) (v -1 7))
(ÖRNEK (v+ (v -9 2) (v 9 -2)) (v 0 0))
(ÖRNEK (v+ (v -2 -4) (v -2 -6)) (v -4 -10))
;;template
;;(define (v+ va vb)
;; (v ..... (v-x va) ... (v-x vb)  ..... (v-y va) ... (v-y vb)))
;;
(define (v+ va vb)
  ( v (+ (v-x va) (v-x vb)) (+ (v-y va) (v-y vb))))



;;v-
;; v v -> v
;;iki vektörün her iki kompnententi x ler kendi arasında y ler kendi arasında olacak şekilde çıkartılır yeni bir vektör verir.
;;örnekler
(ÖRNEK (v- (v 6 9) (v 3 5)) (v 3 4))
(ÖRNEK (v- (v 2 0) (v 7 2)) (v -5 -2))
(ÖRNEK (v- (v 3 4) (v 3 4)) (v 0 0))
(ÖRNEK (v- (v -8 10) (v -10 3)) (v 2 7))
;;template
;;(define ( v- va vb)
;; (v ..... (v-x va) (v-x vb) ..... (v-y va) (v-y vb)))
;;
(define (v- va vb)
  ( v (- (v-x va) (v-x vb)) (- (v-y va) (v-y vb))))



;;v.
;; v v -> sayı
;;iki vektörün her iki kompententi x ler kendi arasında y ler kendi arasında olacak şekilde çarpılır ve iki sonuç toplanır
;;ve toplam değeri verir.
;;örnekler
(ÖRNEK (v. (v 2 5) (v 3 3)) 21)
(ÖRNEK (v. (v -1 4) (v 5 2)) 3)
(ÖRNEK (v. (v -2 -4) (v 3 1)) -10)
(ÖRNEK (v. (v 1 7) (v -8 1)) -1)
;;template
;;(define (v. va vb)
;; (v ..... (v-x va) (v-x vb) ..... (v-y va) (v-y vb)))
;;
(define (v. va vb)
 (+ (* (v-x va) (v-x vb)) (* (v-y va) (v-y vb))))




(STRUCT nesne(imaj yer hız ivme))

;;nesne-ilerleme
;;nesne -> nesne
;;bir nesne alıp bir saniye sonraki halini üreterek yeni nesneyi verir.

;;template
;;(define (nesne-ilerleme a)
;; (nesne ... (nesne-imaj a) ... (nesne-yer a) ... (nesne-hız a) ... (nesne-ivme a)... ) )
;;

;;örnekler:

(ÖRNEK (nesne-ilerleme (nesne (circle 10 "solid" "purple") (v 3 5) (v 2 6) (v 3 5))) (nesne (circle 10 "solid" "purple") (v 5 11) (v 5 11) (v 3 5)))
(ÖRNEK (nesne-ilerleme (nesne (star 5 "outline" "black") (v 6 7) (v 0 3) (v 2 1))) (nesne (star 5 "outline" "black") (v 6 10) (v 2 4) (v 2 1)))
(ÖRNEK (nesne-ilerleme (nesne (triangle 8 "solid" "blue") (v 7 9) (v 1 5) (v 3 8))) (nesne (triangle 8 "solid" "blue") (v 8 14) (v 4 13) (v 3 8)))
(ÖRNEK (nesne-ilerleme (nesne (circle 3 "outline" "yellow") (v 2 2) (v 6 3) (v 5 1))) (nesne (circle 3 "outline" "yellow") (v 8 5) (v 11 4) (v 5 1)))

(define (nesne-ilerleme a) 
  (nesne (nesne-imaj a) (v+ (nesne-yer a) (nesne-hız a)) (v+ (nesne-hız a) (nesne-ivme a)) (nesne-ivme a)))

;place-image/v
; resim v sahne -> sahne
; bir sahneye vectöre göre bir imaj yerleştir
; template :
; (define (place-image/v im v1 sahne)
;  (... im ... (v-x v1) ... (v-y v1) ...)

(ÖRNEK (place-image/v  test-circle (v 5 5) test-square)
       (place-image/align test-circle 5 5 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 3 8) test-square)
       (place-image/align test-circle 3 8 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 1 2) test-square)
       (place-image/align test-circle 1 2 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 2 8) test-square)
       (place-image/align test-circle 2 8 "center" "center" test-square))

(define (place-image/v im v1 sahne)
  (place-image/align im (v-x v1) (v-y v1) "center" "center"  sahne))

;;place-nesne
;;nesne imaj -> imaj
;;bir nesnenin imajını nesnenin yerine göre verilen sahneye yerleştir.
;; nesne içindeki koordinatlarını nesnenin imajını sahneye yerleştirmek için kullanacağız
;; template
;; (define (place-nesne n im)
;;    ... (nesne-imaj n) ... (nesne-yer n) .... im)
;; örnekler
(ÖRNEK (place-nesne (nesne test-circle (v 10 15) (v 2 3) (v 4 5)) test-square)
       (place-image/align test-circle 10 15 "center" "center" test-square))
(ÖRNEK (place-nesne (nesne test-circle (v 7 6) (v 3 2) (v 1 7)) test-square)
       (place-image/align test-circle 7 6 "center" "center" test-square))
(ÖRNEK (place-nesne (nesne test-circle2 (v 10 3) (v 2 5) (v 1 8)) test-square)
       (place-image/align test-circle2 10 3 "center" "center" test-square))
(ÖRNEK (place-nesne (nesne test-circle (v 5 9) (v 1 8) (v 3 1)) test-square2)
       (place-image/align test-circle 5 9 "center" "center" test-square2))


(define (place-nesne n im)
  (place-image/v (nesne-imaj n) (nesne-yer n) im))
 
 (test)



;---------------------------------------------------------------------
;Boş evren fonksiyonları (değiştireceksin)

;evren-ilerleme evren -> evren 
(define (evren-ilerleme e)
  e)

;evren-çiz
;evren -> imaj
;Girdi olarak bir evren alır ve evren imajı yaratır.

;template
;(define (evren-çiz e)
;(evren ... (evren-oyuncu e) ... (evren-ödül e) ...))

(define (evren-çiz e)
 BACKGROUND)

;evren-tuş evren tuş -> evren
(define (evren-tuş e t)
  e)

;evren-fare evren sayı sayı fare-hareketi -> evren 
(define (evren-fare e x y f)
  e)

; ilk evren 
(define yaradılış (evren 1 2))


;; bu satırdan sonraki kod sabit kalsın....
(test)

(big-bang yaradılış
  (on-tick evren-ilerleme (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare))


