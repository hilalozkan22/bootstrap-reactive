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
