;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Bahçe) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "Teachpacks/bahce-teachpack.ss")

;; get new well, butterfly, garden pictures choose at random and set coord at random in teachpack...
(define butterfly (bitmap "Teachpacks/teachpack-images/butterfly-02.png"))
(define kuyu (bitmap "Teachpacks/teachpack-images/kuyu.png"))
(define bahçe (bitmap "Teachpacks/teachpack-images/garden.png"))

;;;; Tanımların burada..bahçe boyutları, marjları
(define bahçe-genişliği WIDTH)
(define bahçe-yüksekliği 480)
(define kelebek-genişliği 104)
(define kelebek-yüksekliği 75)
(define kuyu-genişliği 100)
(define kuyu-yüksekliği 125)
(define kuyu-x 320)
(define kuyu-y 240)


; sözleşme, amaç ve örneklerini unutmayınız


; bahçe-içinde-sol? : Sayı -> Mantıksal
; karakter bahçenin sol tarafından içinde mi?

(define (bahçe-içinde-sol? x)
  true)


; bahçe-içinde-sağ? : Sayı -> Mantıksal
; karakter bahçenin sağ tarafından içinde mi?

(define (bahçe-içinde-sağ? x)
  true)

; bahçe-içinde-alt? : Sayı -> Mantıksal
; karakter bahçenin alt tarafından içinde mi?

(define (bahçe-içinde-alt? y)
  true)


; bahçe-içinde-üst? : Sayı -> Mantıksal
; karakter bahçenin üst tarafından içinde mi?

(define (bahçe-içinde-üst? y)
  true)

;; bahçe-içinde-mi? : Sayı Sayı-> Mantıksal
;; Kelebeğin hepsi hala bahçe içinde mi?

(define (bahçe-içinde-mi? x y)
  (bahçe-içinde-sol? x))

;; kuyu-dışında-mı? : Sayı Sayı -> Mantıksal
;; Kelebeğin hepsi kuyu dışında mı?

(define (kuyu-dışında-mı? x y)
  true)

;; hareket-edebilir-mi? : Sayı Sayı-> Mantıksal
;; Kelebek hareket edebilir mi? ?

(define (güvende-mi? x y)
  (bahçe-içinde-mi? x y))

;;;; Animasyon otomatik olarak başlar
;;;; Kelebeği hareket ettirmek için ok tuşlarını kullan!



(start güvende-mi?)



