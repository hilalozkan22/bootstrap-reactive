;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Bayraklar) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "Teachpacks/bootstrap-teachpack.rkt")

; 1) Kırmızı noktayla başlayalım,  radius 50
(define dot (circle 50 "solid" "red"))


; 2)  "blank" isimli bir değişken tanıtalım, 300x200, içi boş, siyah bir dikdörtgen 
(define blank (rectangle 300 200 "outline" "black"))


; 3) japonya bir japonya bayrağı olsun.  (Boş  dikdörtgen ortasında kırmızı bir noklta)
(define japonya (put-image dot
                         150 100
                         blank))


; Şimdi sen neleri yapabilirsin?...?