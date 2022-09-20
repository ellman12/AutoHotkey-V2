;Hotkeys sent from iCUE that are interpreted by AutoHotkey.

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1: Go to saved mouse position #1
^F13::
CoordMode, Mouse, Screen
MouseMove, %savedMouseX1%, %savedMouseY1%, 0
return

;Keeb G2: Go to saved mouse position #2
^F14::
CoordMode, Mouse, Screen
MouseMove, %savedMouseX2%, %savedMouseY2%, 0
return

;Keeb G3: Go to saved mouse position #3
^F15::
CoordMode, Mouse, Screen
MouseMove, %savedMouseX3%, %savedMouseY3%, 0
return

;Keeb Shift + G1: Save mouse position to slot #1
^+F13::
CoordMode, Mouse, Screen
MouseGetPos, savedMouseX1, savedMouseY1
return

;Keeb Shift + G2: Save mouse position to slot #2
^+F14::
CoordMode, Mouse, Screen
MouseGetPos, savedMouseX2, savedMouseY2
return

;Keeb Shift + G3: Save mouse position to slot #3
^+F15::
CoordMode, Mouse, Screen
MouseGetPos, savedMouseX3, savedMouseY3
return

;Keeb G4
^F16::return

;Keeb G5
^F17::return

;Keeb G6
^F18::return

;Keeb G7
^F19::return

;Keeb G8
^F20::return

;Keeb G9
^F21::return

;Keeb G10
^F22::return

;Keeb G11
^F23::return

;Keeb G12
!F23::return

;Keeb G13
!F13::Send, ^#{F4}

;Keeb G14
!F14::Send, ^#d

;Keeb G15
!F15::return

;Keeb G16
!F16::return

;Keeb G17
!F17::Send, ^#{Left}

;Keeb G18
!F18::Send, ^#{Right}