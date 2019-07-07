#lang racket
(require "teachpacks/evren-teachpack.rkt")

;(SES "ses/bark.wav")


(define BACKGROUND (rectangle  640 480  "solid" "gray")) 

(define FRAME-RATE 12)

(STRUCT v (x y))

(ÖRNEK (v 1 2) (v 1 2))

(STRUCT evren (boş))

(define (evren-ilerleme e)
  e)

(define (evren-çiz e)
  BACKGROUND)

(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)

(define yaradılış (evren 1))


;; bu satırdan sonraki kod sabit kalsın....
(test)

(big-bang yaradılış
  (on-tick evren-ilerleme (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare))


