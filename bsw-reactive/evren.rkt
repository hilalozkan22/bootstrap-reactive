#lang racket
; bootstrapworld reactive (ish) racket versiyonu
; v-06-check-expect now works with specific inspector for structs - find a better solution
; place-image/vc now uses center setting for alignment
; latest struct syntax used
(require 2htdp/universe)
(require 2htdp/image)
(require (only-in racket/gui/base play-sound))
(require test-engine/racket-tests)

(check-expect(struct->vector (vc 0 0)) (struct->vector (vc 0 0)))
(define FRAME-RATE 20)
(define BACKGROUND (bitmap "imaj/kutuphane.jpg"))
(define BACKGROUND-SCENE
  (place-image/align (text "Evren 2019" 20 "white") 0 20 "left" "top"
                     BACKGROUND))

; vc - vector
; x - sayı, x kordinat
; y - sayı, y kordinat
(struct vc (x y) #:inspector (make-inspector (current-inspector)))

; vc+ - topla vektor
; vc+ vc vc -> vc
(check-expect (vc+ (vc 2 3) (vc 9 2)) (vc 11 5))
(check-expect (vc+ (vc -2 -3) (vc 9 2)) (vc 7 -1))
(define (vc+ v1 v2)
  (vc (+ (vc-x v1) (vc-x v2))
           (+ (vc-y v1) (vc-y v2))))

; vc- - çıkart vektor
; vc- vc vc -> vc
(check-expect (vc- (vc 2 3) (vc 9 2)) (vc -7 1))
(check-expect (vc- (vc -2 -3) (vc 9 2)) (vc -11 -5))
(define (vc- v1 v2)
  (vc (- (vc-x v1) (vc-x v2))
           (- (vc-y v1) (vc-y v2))))

; vc* - çarp vektor sayıyla
; vc* vc sayı -> vc
(check-expect (vc* (vc 2 3) 2) (vc 4 6))
(check-expect (vc* (vc -2 -3) -3) (vc 6 9))
(define (vc* v1 s)
  (vc (* (vc-x v1) s)
           (* (vc-y v1) s)))

(define (vc->text v)
  (string-append "[" (number->string (vc-x v)) "," (number->string (vc-y v)) "]")) 


(define (+-random n)
  (* (random 0 n) (- 1 (* 2 (random 0 1)))))

(define (random-vc x y)
  (vc (+-random x) (+-random y)))



; place-image/vc resim vc scene -> scene
; bir sahneye vectora göre bir imaj yerleştir
(define (place-image/vc im v sahne)
  (place-image/align im (vc-x v) (vc-y v) "center" "center"  sahne))

; place-line/vc vc vc color scene -> scene
; add line from v1 to v2 to scene
(define (place-line/vc v1 v2 renk s)
  (add-line s (vc-x v1) (vc-y v1) (vc-x v2) (vc-y v2) renk )) 
               
(define (place-text/vc s v size col sahne)
  (place-image/vc (text s size col) v sahne))



               
(struct dünya (boş))

(define (dünya-ilerleme w) w)

(define (dünya-çiz w)
   BACKGROUND-SCENE)


(define (dünya-tuş w t)
  w)

(define (dünya-fare w x y m) w)

(define yaradılış (dünya 0))


(test)

(big-bang yaradılış
  (on-tick dünya-ilerleme (/ 1.0 FRAME-RATE))
  (on-draw dünya-çiz)
  (on-key dünya-tuş)
  (on-mouse dünya-fare))
