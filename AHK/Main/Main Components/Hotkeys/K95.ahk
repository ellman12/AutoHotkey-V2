;Static hotkeys on my K95 RGB that act as a sort of baby Stream Deck XL

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1
^F13::Send, Elliott

;Keeb G2
^F14::Send, DuCharme

;Keeb G3
^F15::Send, Elliott DuCharme

;Keeb G4: same as "trim" command
^F16::
Clipboard := Trim(Clipboard)
Clipboard := StrReplace(Clipboard, "`r")
Clipboard := StrReplace(Clipboard, "`n")
return

;Keeb G5: "trim" and "paste" commands
^F17::
Clipboard := Trim(Clipboard)
Clipboard := StrReplace(Clipboard, "`r")
Clipboard := StrReplace(Clipboard, "`n")
Send, %Clipboard%
return

;Keeb G6
^F18::
return

;Keeb G7
^F19::Run ::{645FF040-5081-101B-9F08-00AA002F954E}

;Keeb G8
^F20::
return

;Keeb G9
^F21::
return

;Keeb G10
^F22::
return

;Keeb G11
^F23::
return

;Keeb G12
!F23::
return

;Keeb G13
!F13::Send, ^#{F4}

;Keeb G14
!F14::Send, ^#d

;Keeb G15
!F15::
return

;Keeb G16
!F16::
return

;Keeb G17
!F17::Send, ^#{Left}

;Keeb G18
!F18::Send, ^#{Right}