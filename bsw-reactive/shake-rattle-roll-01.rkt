#lang racket
; bootstrapworld reactive (ish) racket versiyonu
; v-05-check-expect now works with specific inspector for structs - find a better solution
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
  (place-image/align (text "Shake, Rattle and Roll, Chris Stephenson 2018" 20 "white") 0 20 "left" "top"
                     BACKGROUND))

; vc - vector
; x - sayı, x kordinat
; y - sayı, y kordinat
(struct vc (x y) #:inspector (make-inspector (current-inspector)))

; +vc - topla vektor
; +vc vc vc -> vc
(check-expect (+vc (vc 2 3) (vc 9 2)) (vc 11 5))
(check-expect (+vc (vc -2 -3) (vc 9 2)) (vc 7 -1))
(define (+vc v1 v2)
  (vc (+ (vc-x v1) (vc-x v2))
           (+ (vc-y v1) (vc-y v2))))

; -vc - çıkart vektor
; -vc vc vc -> vc
(check-expect (-vc (vc 2 3) (vc 9 2)) (vc -7 1))
(check-expect (-vc (vc -2 -3) (vc 9 2)) (vc -11 -5))
(define (-vc v1 v2)
  (vc (- (vc-x v1) (vc-x v2))
           (- (vc-y v1) (vc-y v2))))

; *vc - çıkart vektor sayıyla
; *vc vc sayı -> vc
(check-expect (*vc (vc 2 3) 2) (vc 4 6))
(check-expect (*vc (vc -2 -3) -3) (vc 6 9))
(define (*vc v1 s)
  (vc (* (vc-x v1) s)
           (* (vc-y v1) s)))



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

(define (vc->text v)
  (string-append "[" (number->string (vc-x v)) "," (number->string (vc-y v)) "]")) 

; cisim - hareket eden bir cisim
; imaj - resim
; yer - vc
; hız - vc
; ivme - vc
(struct cisim (imaj yer hız ivme)#:inspector (make-inspector (current-inspector)))

; cisim-ilerleme cisim -> cisim
; cisim-ilerleme - herket eden bir cisimin tek anlık hereketini gerçekleştirmek
(check-expect
 (cisim-ilerleme (cisim (circle 10 "solid" "yellow") (vc 1 1) (vc 2 3) (vc -1 -2)))
 (cisim (circle 10 "solid" "yellow") (vc 3 4) (vc 1 1) (vc -1 -2)))

(define (cisim-ilerleme c)
;  (cisim (cisim-imaj c) (+vc (cisim-yer c) (cisim-hız c)) (+vc (cisim-hız c) (cisim-ivme c)) (cisim-ivme c)))
  (struct-copy cisim c [yer (+vc (cisim-yer c) (cisim-hız c))] [hız (+vc (cisim-hız c) (cisim-ivme c))]))
               
; place-cisim cisim scene -> scene
; bir sahneye kordinatlarına göre bir cisim yerleştir
(define (place-cisim c sahne)
  (place-image/vc (cisim-imaj c) (cisim-yer c) sahne))

; test-sek cisim comparator limit selector image-dim-selector dim-sign
; cisim (num num -> bool) num (vc -> num) (image -> num) (num num -> num) -> bool
(check-expect (test-sek (cisim (circle 20 "solid" "yellow") (vc 19 100) (vc -1 0) (vc 0 0))
              <= 0 vc-x image-width -) true)
(check-expect (test-sek (cisim (circle 20 "solid" "yellow") (vc 20 100) (vc -1 0) (vc 0 0))
              <= 0 vc-x image-width -) true)
(check-expect (test-sek (cisim (circle 20 "solid" "yellow") (vc 21 100) (vc -1 0) (vc 0 0))
              <= 0 vc-x image-width -) false)
(define (test-sek c comp limit selector image-dim-select dim-sign)
  (and (comp (selector (cisim-hız c)) 0)
        (comp (+ (dim-sign (selector (cisim-yer c)) (/ (image-dim-select (cisim-imaj c)) 2))) limit)))
;        (comp (+ (dim-sign (selector (cisim-yer c)) (/ (image-dim-select (cisim-imaj c)) 1))) limit)))

(define (flip-cisim xf yf c)
  (cisim (cisim-imaj c) (cisim-yer c) (vc (* xf (vc-x (cisim-hız c))) (* yf (vc-y (cisim-hız c)))) (cisim-ivme c)))

(define (+-random n)
  (* (random 0 n) (- 1 (* 2 (random 0 1)))))

(define (random-vc x y)
  (vc (+-random x) (+-random y)))

; sek cisim width height -> cisim
(define (sek c max-x max-y)
  (cond
    ((test-sek c >= max-y vc-y image-height +) (begin (play-sound "ses/glass.wav" true)(flip-cisim 1 -0.8 c)))
    ((test-sek c <= 0 vc-y image-height -) (begin (play-sound "ses/sonar.wav" true)(flip-cisim 1 -0.8 c)))
    ((test-sek c >= max-x vc-x image-width +) (begin (play-sound "ses/drip.wav" true)(flip-cisim -0.8 1 c)))
    ((test-sek c <= 0 vc-x image-width -) (begin (play-sound "ses/bark.wav" true)(flip-cisim -0.8 1 c)))
    (else c)))

(define (cisim-ilerleme/sek c  w h)
  (sek (cisim-ilerleme c) w h))
               
(struct dünya (ivmesi c1 c2 c3))

(define (dünya-ilerleme w) (dünya
                            (dünya-ivmesi w)
                            (cisim-ilerleme/sek (dünya-c1 w)(image-width BACKGROUND)(image-height BACKGROUND))
                            (cisim-ilerleme/sek (dünya-c2 w)(image-width BACKGROUND)(image-height BACKGROUND))
                            (cisim-ilerleme/sek (dünya-c3 w)(image-width BACKGROUND)(image-height BACKGROUND))
                            ))

(define (dünya-çiz w)
  (place-text/vc (string-append "İvme =" (vc->text (dünya-ivmesi w))) (vc (- (image-width BACKGROUND-SCENE) 150) 20) 20 "white"
                                     (place-cisim (dünya-c1 w) (place-cisim (dünya-c2 w)
                                                                            (place-cisim (dünya-c3 w) BACKGROUND-SCENE)))))
; cisim-hız-ayarla: cisim vc -> cisim
; Cisim in hızına verilen vektörü eklemek
(define (cisim-hız-ayarla c v)
  (cisim (cisim-imaj c) (cisim-yer c) (+vc v (cisim-hız c)) (cisim-ivme c)))

; set-cisim-ivme: cisim vc -> cisim
; Cisim in ivmesine verilen vektöre ayarlamk
(define (set-cisim-ivme c v)
  (cisim (cisim-imaj c) (cisim-yer c) (cisim-hız c) v))

(define (ayarla-dünya-ivmesi w v)
  (let ((new-ivme (+vc v (dünya-ivmesi w)))) 
    (dünya new-ivme
                (set-cisim-ivme (dünya-c1 w) new-ivme)
                (set-cisim-ivme (dünya-c2 w) new-ivme)
                (set-cisim-ivme (dünya-c3 w) new-ivme))))

(define (dünya-tuş w t)
  (cond
    ((string=? t " ")(dünya (dünya-ivmesi w)
                                 (cisim-hız-ayarla (dünya-c1 w) (random-vc 40 80))
                                 (cisim-hız-ayarla (dünya-c2 w) (random-vc 45 90))
                                 (cisim-hız-ayarla (dünya-c3 w) (random-vc 50 100))))
    ((string=? t "up") (ayarla-dünya-ivmesi w (vc 0 -1)))
    ((string=? t "down") (ayarla-dünya-ivmesi w (vc 0 1)))
    ((string=? t "left") (ayarla-dünya-ivmesi w (vc -1 0)))
    ((string=? t "right") (ayarla-dünya-ivmesi w (vc 1 0)))
    ((string=? t "x") (stop-with w))
    (else w)))

(define (dünya-fare w x y m) w)

(define yaradılış (dünya
                   (vc 0 5)
                   (cisim (circle 20 "solid" "yellow") (vc 0 300) (vc 20 -70) (vc 0 5))
                   (cisim (circle 30 "solid" "red") (vc 500 300) (vc 40 -90) (vc 0 5))
                   (cisim (circle 40 "solid" "green") (vc 250 600) (vc -20 100) (vc 0 5))))


(test)

(big-bang yaradılış
  (on-tick dünya-ilerleme (/ 1.0 FRAME-RATE))
  (on-draw dünya-çiz)
  (on-key dünya-tuş)
  (on-mouse dünya-fare)
  (record? "/home/chris/recorddirsrr"))
