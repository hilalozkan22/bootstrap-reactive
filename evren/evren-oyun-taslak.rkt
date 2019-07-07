#lang racket
(require "teachpacks/evren-teachpack.rkt")
;(SES "ses/bark.wav")
;örnek BACKGROUND (değiştireceksin)
(define BACKGROUND (rectangle  640 480  "solid" "gray")) 
;örnek FRAME-RATE (değiştireceksin)
(define FRAME-RATE 12)
;örnek evren STRUCT tanımı (değiştireceksin)
(STRUCT evren (boş))
;---------------------------------------------------------------------
Yeni kodun buraya yerleştir...



;---------------------------------------------------------------------
;Boş evren fonksiyonları (değiştireceksin)

;evren-ilerleme evren -> evren 
(define (evren-ilerleme e)
  e)

;evren-çiz evren -> imaj
(define (evren-çiz e)
  BACKGROUND)

;evren-tuş evren tuş -> evren
(define (evren-tuş e t)
  e)

;evren-fare evren sayı sayı fare-hareketi -> evren 
(define (evren-fare e x y f)
  e)

; ilk evren 
(define yaradılış (evren 1))


;; bu satırdan sonraki kod sabit kalsın....
(test)

(big-bang yaradılış
  (on-tick evren-ilerleme (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare))


