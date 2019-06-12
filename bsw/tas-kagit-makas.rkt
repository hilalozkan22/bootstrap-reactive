;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tas-kagit-makas) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "bootstrap-testing.rkt" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "bootstrap-testing.rkt" "installed-teachpacks")) #f)))
(define (hamle x)
  (cond
    [(= x 0) "kağıt"]
    [(= x 1) "makas"]
    [(= x 2) "taş"]
    [else ""]
   )
)

(define (kazandım-mı? oyuncu bilgisayar)
  (cond
  [(and (= oyuncu 2) (= bilgisayar 1)) "sen kazandın!"]
  [(and (= oyuncu 1) (= bilgisayar 0)) "sen kazandın!" ]
  [(and (= oyuncu 0) (= bilgisayar 2)) "sen kazandın!" ]
  [(= oyuncu bilgisayar) "Berabere kaldınız"]
  [else "kaybettin :("]
  )
)


(define (oyun-sonuc x y)              
        (string-append (kazandım-mı? x y) " " (hamle x) " vs " (hamle y))
)

(define (oyun x)
  (oyun-sonuc x (random 3))
)
