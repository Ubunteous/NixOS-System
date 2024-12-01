; Colemak Mod-DH mapping for ISO boards
; on french azerty layout
; #SingleInstance
; #:win, !:alt, ^:ctrl, +:shift
; Esc::ExitApp

#SingleInstance Force

;;;;;;;;;;;;;;;;;
;;   COLEMAK   ;;
;;;;;;;;;;;;;;;;;

SC010::q
SC011::w

SC012::f
SC013::p
SC014::b
SC015::j
SC016::l
SC017::u
SC018::y
SC019::!
<+SC019::%

SC01E::a
SC01F::r
SC020::s
SC021::t
;SC022::g
SC023::m
SC024::n
SC025::e
SC026::i
SC027::o
SC028::backspace

;SC056::z
SC02c::z
SC02d::x
SC02e::c
SC02f::d
SC030::v
SC031::k
SC032::h
SC033::,
SC034::.
<+SC034::;
SC035::/
<+SC035:::

;;;;;;;;;;;;;;;;;;;;;;;
;;   HOME ROW MODS   ;;
;;;;;;;;;;;;;;;;;;;;;;;

; SC011 & SC018::LWin ; M-y launcher
; SC011 & SC018::!Space ; M-y launcher
SC011 & SC018::#y ; M-y launcher
SC011 & SC023::!m ; M-m focus-next
SC011 & SC024::!n ; M-n prev-ws
SC011 & SC026::!o ; M-i (remap o) next-ws
SC011 & SC025::#e ; M-e file explorer

SC018 & SC02d::!c ; kill (diminish)

SC011 & SC039::!space ; toggle fullscreen
SC018 & SC039::!space ; toggle fullscreen

#+Enter::#e ; M-S-<enter> Terminal
; TODO: promote master swap

;;;;;;;;;;;;;;
;;   MISC   ;;
;;;;;;;;;;;;;;

; Numrow fix ; TODO
; SC15B & SC002::!1
; SC15B & SC003::!2
; SC15B & SC004::!3
; SC15B & SC005::!4

; Anti missfires
SC038 & SC011::!w ; M-w
SC038 & SC039::!Space ; M-<SPC>
SC038 & SC056::!< ; M-<
!+SC056::!> ; M->
; !SC02d::!x ; M-x ; problem C-c t

; swap win and alt
SC15B::LAlt
SC038::LWin

; set Backspace to Control key
sc03a::control