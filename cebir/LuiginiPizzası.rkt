;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname LuiginiPizzası) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "Teachpacks/fonksiyon-teachpack.rkt")
; maliyet : Metin-> Sayı
; bir Pizza malzemesi verildiğinde o malzemeyle yapılan pizzanın maliyetini hesaplar
(define (maliyet malzeme)
  (cond
    [(string=? malzeme "peynir")    0.00]
    [else "Mesaj"])) 

;; Çalıştır'a basın ve etkileşim penceresinde maliyet hesabı yapmayı deneyin
;; mesele (maliyet "peynir") ifadesi 9'a değerlenmelidir.

