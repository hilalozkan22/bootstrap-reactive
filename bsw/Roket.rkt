;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Roket) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "Teachpacks/fonksiyon-teachpack.ss")

; roket-yüksekliği : Number -> Number
; Belli bir saniye sayısı sonrası roket ne kadar yüksek olacak?
(ÖRNEK (roket-yüksekliği 0) 0)

(define (roket-yüksekliği saniye) saniye)


;;;; "Run" tıklanınca aşağıdan girilen bu satır roketin uçmasını sağlayacak
;;;; Saniyeleri ilerletmek için boşuk tuşuna basın
;(başlat roket-yüksekliği)


;; Bunu çalıştırdıktan sonra "başlat" yerine "uzay" "grafik" yada "hepsi" deneyebilirsin! 