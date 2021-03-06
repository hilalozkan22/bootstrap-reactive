#lang racket
(require "teachpacks/evren-teachpack.rkt")
;(SES "ses/bark.wav")
;örnek BACKGROUND (değiştireceksin)
(define BACKGROUND (square 300 "solid" "blue"))

;örnek FRAME-RATE (değiştireceksin)
(define FRAME-RATE 12)
;örnek evren STRUCT tanımı (değiştireceksin)
;;****************************************************
;;  evren in komponentlerinin veri tiplerini anlatacaksın burada...
;; evren
;; oyuncu : nesne
;; ödül : nesne
;; arka-plan : imaj
;; sekme-oran : sayı
(STRUCT evren (oyuncu ödül arka-plan sekme-oran))
;---------------------------------------------------------------------

;; struct v
;; 2 boyutlu vektör
;; x : sayı x koordinatı
;; y : sayı y koordinatı
(STRUCT v (x y) )

(define test-circle (circle 10 "solid" "white"))
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
 
 



;---------------------------------------------------------------------
;Boş evren fonksiyonları (değiştireceksin)

;evren-ilerleme
;evren -> evren
;bir evren alıp bir saniye sonraki halini üretip yeni evreni verir.
;örnekler:

(ÖRNEK (evren-ilerleme (evren (nesne test-circle (v 3 6 ) (v -1 5) (v 7 -5))
                              (nesne test-circle (v 4 7) (v -2 -4) (v 5 2)) test-square 1))
                       (evren (nesne-üstten-sek
                              (nesne-soldan-sek
                              (nesne-sağdan-sek
                              (nesne-alttan-sek
                              (nesne-ilerleme
                       (nesne test-circle (v 3 6 ) (v -1 5) (v 7 -5)))
                       test-square 1) test-square 1) test-square 1) test-square 1)
                       (nesne-üstten-sek
                       (nesne-soldan-sek  
                       (nesne-sağdan-sek
                       (nesne-alttan-sek
                       (nesne-ilerleme
                       (nesne test-circle (v 4 7) (v -2 -4) (v 5 2)))
                       test-square 1) test-square 1) test-square 1) test-square 1) test-square 1))


;template
;(define (evren-ilerleme e)
;  (evren ... (evren-oyuncu e) ... (evren-ödül e) ... (evren-arka-plan e ) ...))

(define (evren-ilerleme e)
  (evren (nesne-üstten-sek (nesne-soldan-sek(nesne-sağdan-sek
                                             (nesne-alttan-sek
                                              (nesne-ilerleme (evren-oyuncu e))
                                              (evren-arka-plan e) (evren-sekme-oran e))
                                             (evren-arka-plan e) (evren-sekme-oran e))
                                            (evren-arka-plan e) (evren-sekme-oran e))
                           (evren-arka-plan e) (evren-sekme-oran e))
         (nesne-üstten-sek (nesne-soldan-sek(nesne-sağdan-sek
                                             (nesne-alttan-sek
                                              (nesne-ilerleme (evren-ödül e)) (evren-arka-plan e) (evren-sekme-oran e))
                                             (evren-arka-plan e) (evren-sekme-oran e))
                                            (evren-arka-plan e) (evren-sekme-oran e))
                           (evren-arka-plan e)(evren-sekme-oran e))
         (evren-arka-plan e) (evren-sekme-oran e)))
 
          
;v-y-ters
; v -> v
;girdi olarak birvektör alır ve aldığı vektörün y komponentini tersine çevirerek geri verir.
;Örnekler:

(ÖRNEK (v-y-ters (v 3 5 ) 1) (v 3 -5))
(ÖRNEK (v-y-ters (v -9 -6 ) 1) (v -9 6))
(ÖRNEK (v-y-ters (v 0 -4 ) 1) (v 0 4))
(ÖRNEK (v-y-ters (v 6 1 ) 1) (v 6 -1))

; template
; (define (v-y-ters a )
;  ( ... (v-x a) ... (v-y a)))

(define (v-y-ters a oran)
  (v (v-x a) (- (* oran (v-y a)))))



;v-x-ters
;v -> v
;Girdi olarak bir vektör alır ve bununn x komponentini ters çevirir.
;Örnekler ;

(ÖRNEK (v-x-ters (v 2 0) 1) (v -2 0))
(ÖRNEK (v-x-ters (v 9 -3) 1) (v -9 -3))
(ÖRNEK (v-x-ters (v -8 6) 1) (v 8 6))
(ÖRNEK (v-x-ters (v 0 -3) 1) (v 0 -3))

; template
; (define (v-x-ters a )
;  ( ... (v-x a) ... (v-y a)))

(define (v-x-ters a oran )
  ( v (-(* (v-x a) oran)) (v-y a)))


;nesne-alttan-sek
;nesne imaj -> nesne
;nesne arkaplanın alttan çıkmak üzereyse ve aşağa doğru gidiyorsa, nesnenin hızının y komponentini ters çevirir.
;Örnekler :

(define n1 (nesne test-circle (v 150 150) (v 0 10) (v 0 0)))
(ÖRNEK (nesne-alttan-sek  n1 BACKGROUND)
       n1 )
(define n2 (nesne test-circle (v 150 300) (v 0 -10) (v 0 0)))
(ÖRNEK (nesne-alttan-sek n2 BACKGROUND)
       n2)

(define n3 (nesne test-circle (v 150 150) (v 0 -10) (v 0 0)))
(ÖRNEK (nesne-alttan-sek n3 BACKGROUND)
       n3)

(define n4 (nesne test-circle (v 150 300) (v 0 10) (v 0 0)))
(ÖRNEK (nesne-alttan-sek n4 BACKGROUND)
       (nesne test-circle (v 150 300) (v 0 -10) (v 0 0)))

(define n5 (nesne test-circle (v 150 290) (v 0 10) (v 0 0)))
(ÖRNEK (nesne-alttan-sek n5 BACKGROUND)
       (nesne test-circle (v 150 290) (v 0 -10) (v 0 0)))

(define n6 (nesne test-circle (v 150 289) (v 0 10) (v 0 0)))
(ÖRNEK (nesne-alttan-sek n6 BACKGROUND)
       n6)
;template-1
;(define (nesne-alltan-sek n im)
; (cond
; (... (nesne-hız n)...                     ...)
; (...(nesne-yer n) ... (nesne-imaj n)      ...)
; (else                                     ...)))

;template-2
;(define (nesne-alttan-sek n im)
;   (cond
;   ( (or (... (nesne-hız n) ... (nesne-yer n) ...) (...  im) (... (nesne-imaj n)...)) n)
;   (else            (nesne .... (nesne-imaj n) ... (nesne-yer n) ... (nesne-hız n) ... (nesne-ivme n)))))




(define (nesne-alttan-sek n im oran)
   (cond
   ( (or (<= (v-y (nesne-hız n)) 0) (< (v-y (nesne-yer n)) (- (image-height im) (/ (image-height (nesne-imaj n)) 2)))) n)
   (else   (nesne (nesne-imaj n)  (nesne-yer n)  (v-y-ters (nesne-hız n) oran) (nesne-ivme n)))))                                                                 
   


;nesne-sağdan-sek
;nesne imaj -> nesne
;nesne arkaplanın sağından çıkmak üzereyse ve sağa doğru hareket ediyorsa nesnenin hızının x koordinatını ters çevirir. 
;Örnekler

(define a1 (nesne test-circle (v 150 150) (v 10 0) (v 0 0)))
(ÖRNEK (nesne-sağdan-sek a1 BACKGROUND)
         a1)

(define a2 (nesne test-circle (v 300 150) (v -10 0) (v 0 0)))
(ÖRNEK (nesne-sağdan-sek a2 BACKGROUND)
         a2)

(define a3 (nesne test-circle (v 150 150) (v -10 0) (v 0 0)))
(ÖRNEK (nesne-sağdan-sek a3 BACKGROUND)
         a3)

(define a4 (nesne test-circle (v 300 150) (v 10 0) (v 0 0)))
(ÖRNEK (nesne-sağdan-sek a4 BACKGROUND)
        (nesne test-circle (v 300 150) (v -10 0) (v 0 0)))

(define a5 (nesne test-circle (v 290 150) (v 10 0) (v 0 0)))
(ÖRNEK (nesne-sağdan-sek a5 BACKGROUND)
        (nesne test-circle (v 290 150) (v -10 0) (v 0 0)))

(define a6 (nesne test-circle (v 289 150) (v 10 0) (v 0 0)))
(ÖRNEK (nesne-sağdan-sek a6 BACKGROUND)
        a6)

;template
;(define (nesne-sağdan-sek n im)
;   (cond
;   ( ... (nesne-hız n) ... (nesne-yer n) ...) ( ...  im) (... (nesne-imaj n)...)) n)
;   (else            (nesne ... (nesne-imaj n) ... (nesne-yer n) ...(nesne-hız n) ... (nesne-ivme n)))))



(define (nesne-sağdan-sek n im oran)
  (cond
  ( (or ( <= (v-x (nesne-hız n)) 0 ) (< (v-x (nesne-yer n)) (- (image-width im) (/ (image-width (nesne-imaj n)) 2)))) n)
  (else  (nesne (nesne-imaj n) (nesne-yer n) (v-x-ters (nesne-hız n) oran) (nesne-ivme n)))))


;nesne-soldan-sek
;nesne imaj -> nesne
;nesne arkaplanın solundan çıkmak üzereyse ve sola doğru hareket ediyorsa nesnenin hızının x koordinatını ters çevirir.

(define b1 (nesne test-circle (v 150 150) (v -10 0) (v 0 0)))
(ÖRNEK (nesne-soldan-sek b1 BACKGROUND)
         b1)

(define b2 (nesne test-circle (v 0 150) (v 10 0) (v 0 0)))
(ÖRNEK (nesne-soldan-sek b2 BACKGROUND)
         b2)

(define b3 (nesne test-circle (v 150 150) (v 10 0) (v 0 0)))
(ÖRNEK (nesne-soldan-sek b3 BACKGROUND)
         b3)

(define b4 (nesne test-circle (v 0 150) (v -10 0) (v 0 0)))
(ÖRNEK (nesne-soldan-sek b4 BACKGROUND)
        (nesne test-circle (v 0 150) (v 10 0) (v 0 0)))

(define b5 (nesne test-circle (v 10 150) (v -10 0) (v 0 0)))
(ÖRNEK (nesne-soldan-sek b5 BACKGROUND)
        (nesne test-circle (v 10 150) (v 10 0) (v 0 0)))

(define b6 (nesne test-circle (v 11 150) (v -10 0) (v 0 0)))
(ÖRNEK (nesne-soldan-sek b6 BACKGROUND)
        b6)


;template
;(define (nesne-soldan-sek n im)
;  (cond
;  ( ... (v-x (nesne-hız n) .. ) (... (v-x (nesne-yer n)) ( ... (nesne-imaj n)) ...)) n)
;  (else  (nesne ...(nesne-imaj n)... (nesne-yer n)... (nesne-hız n)... (nesne-ivme n)))))


(define (nesne-soldan-sek n im oran)
  (cond
  ( (or ( >= (v-x (nesne-hız n)) 0 ) (> (v-x (nesne-yer n)) ( /(image-width (nesne-imaj n)) 2))) n)
  (else  (nesne (nesne-imaj n) (nesne-yer n) (v-x-ters (nesne-hız n) oran) (nesne-ivme n)))))

;nesne-üstten-sek
; nesne imaj -> nesne
;nesne arkaplanın üstten çıkmak üzereyse ve yukarı doğru gidiyorsa, nesnenin hızının y komponentini ters çevirir.
;Örnekler :

(define m1 (nesne test-circle (v 150 150) (v 0 -10) (v 0 0)))
(ÖRNEK (nesne-üstten-sek m1 BACKGROUND)
       m1)
(define m2 (nesne test-circle (v 150 0) (v 0 10) (v 0 0)))
(ÖRNEK (nesne-üstten-sek m2 BACKGROUND)
       m2)
(define m3 (nesne test-circle (v 150 150) (v 0 10) (v 0 0)))
(ÖRNEK (nesne-üstten-sek m3 BACKGROUND)
       m3)
(define m4 (nesne test-circle (v 150 0) (v 0 -10) (v 0 0)))
(ÖRNEK (nesne-üstten-sek m4 BACKGROUND)
       (nesne test-circle (v 150 0) (v 0 10) (v 0 0)))
(define m5 (nesne test-circle (v 150 10) (v 0 -10) (v 0 0)))
(ÖRNEK (nesne-üstten-sek m5 BACKGROUND)
       (nesne test-circle (v 150 10) (v 0 10) (v 0 0)))

(define m6 (nesne test-circle (v 150 11)  (v 0 -10)(v 0 0)))
(ÖRNEK (nesne-üstte-sek m6 BACKGROUND)
       m6)

;template :
;(cond
;  ( ... (v-y (nesne-hız n) ... ) (...(v-y (nesne-yer n)) (... (nesne-imaj n)) ... ) n)
;  (else  (nesne ... (nesne-imaj n) ... (nesne-yer n) ... (nesne-hız n) ... (nesne-ivme n))))) 

(define (nesne-üstten-sek n im  oran)
(cond
  ( (or ( >= (v-y (nesne-hız n)) 0 ) (> (v-y (nesne-yer n)) ( /(image-width (nesne-imaj n)) 2))) n)
  (else  (nesne (nesne-imaj n) (nesne-yer n) (v-y-ters (nesne-hız n) oran) (nesne-ivme n)))))  



  





;evren-çiz
;evren -> imaj
;Girdi olarak bir evren alır ve evren imajı yaratır.

;Örnekler
(ÖRNEK (evren-çiz (evren (nesne test-circle (v 30 40) (v 1 2) (v 4 5))
                         (nesne test-circle (v 60 70) (v 1 2) (v 4 5)) test-square 1))
                  (place-nesne (nesne test-circle (v 30 40) (v 1 2) (v 4 5))
                               (place-nesne (nesne test-circle (v 60 70) (v 1 2) (v 4 5)) test-square)))

(ÖRNEK (evren-çiz (evren (nesne test-circle2 (v 10 20) (v 10 5) (v 5 8))
                         (nesne test-circle (v 20 40) (v 3 2) (v 4 8)) test-square2 1))
                  (place-nesne (nesne test-circle2 (v 10 20) (v 10 5) (v 5 8))
                               (place-nesne (nesne test-circle (v 20 40) (v 3 2) (v 4 8)) test-square2)))

(ÖRNEK (evren-çiz (evren (nesne test-circle (v 100 50) (v 5 5) (v 8 8))
                         (nesne test-circle2 (v 60 70) (v 3 5) (v 9 8)) test-square2 1))
                  (place-nesne (nesne test-circle (v 100 50) (v 5 5) (v 8 8))
                               (place-nesne (nesne test-circle2 (v 60 70) (v 3 5) (v 9 8)) test-square2)))

(ÖRNEK (evren-çiz (evren (nesne test-circle2 (v 30 20) (v 3 8) (v 2 2))
                         (nesne test-circle2 (v 5 10) (v 6 7) (v 1 1)) test-square 1))
                  (place-nesne (nesne test-circle2 (v 30 20) (v 3 8) (v 2 2))
                               (place-nesne (nesne test-circle2 (v 5 10) (v 6 7) (v 1 1)) test-square)))

;template
;(define (evren-çiz e)
;(... (evren-oyuncu e) ... (evren-ödül e) ... (evren-arka-plan e)))

(define (evren-çiz e)
(place-text/v (v (/ (image-width (evren-arka-plan e)) 2) 20)
              (string-append "Sekme Oranı ; " (number->string (evren-sekme-oran e))) 20 "red" 
  (place-nesne (evren-oyuncu e) (place-nesne (evren-ödül e) (evren-arka-plan e)))))

;; place-line/v v v color görüntü -> görüntü
;; v1'den v2'e giden bir çizgi arka imajına yerleştir
(ÖRNEK (place-line/v (v 2 3) (v 5 1) "red" test-square)
       (add-line test-square 2 3 5 1 "red")) 

(define (place-line/v v1 v2 renk arka)
  (add-line arka (v-x v1) (v-y v1) (v-x v2) (v-y v2) renk)) 
;
;place-text/v v metin sayı color görüntü -> görüntü
; v pozisyonda  verilen metni arka imajına yerleştir
(ÖRNEK (place-text/v (v 20 30) "Hello" 15 "red" test-square)
       (place-image/v (text "Hello" 15 "red") (v 20 30) test-square))
(define (place-text/v v metin size col arka)
  (place-image/v (text metin size col) v arka))

;evren-tuş evren tuş -> evren
(define (evren-tuş e t)
  (cond
    ((string=? t "up")   (struct-copy evren e
                                      [sekme-oran (+ (evren-sekme-oran e) 0.01)]))
    ((string=? t "down") (struct-copy evren e
                                      [sekme-oran (- (evren-sekme-oran e) 0.01)]))
    (else  e)))


;evren-fare evren sayı sayı fare-hareketi -> evren 
(define (evren-fare e x y f)
  e)

; ilk evren 
(define yaradılış
  (evren (nesne test-circle (v 30 40) (v 2 -7) (v 0 1)) (nesne test-circle2 (v 60 70) (v 3 -8) (v 0 1)) BACKGROUND 1))


;; bu satırdan sonraki kod sabit kalsın....
(test)

(big-bang yaradılış
  (on-tick evren-ilerleme (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare))


