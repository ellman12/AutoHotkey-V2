;Default behavior of macro buttons on Scimitar Pro and K95.
;The Scimitar's actions work in the vast majority of apps, while the K95's buttons aren't used much now that I have the Stream Deck XL.
;These hotkeys can be overridden in profiles if desired.

;----------------------------------------SCIMITAR RGB ACTIONS---------------------------------------
;G1: Horizontal scroll
F13 & WheelUp::Send, {WheelLeft}
F13 & WheelDown::Send, {WheelRight}

;G2: Ctrl Tab
F14::Send, ^{Tab}

;G3: Faster vertical scrolling
F15 & WheelUp::Send, {WheelUp 8}
F15 & WheelDown::Send, {WheelDown 8}

;A way to make the mouse move faster while G3 and the Right Mouse Button are held down. Useful for moving around the screen/between monitors quickly.
F15 & RButton::
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,17, Int,1)
KeyWait, RButton
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;G4: New tab
F16::Send, ^t

;G5: Tab to the right
F17::Send, ^{PGDN}

;G6: Forward in history
F18::Send, !{Right}

;G7: Close tab
F19::Send, ^{w}

;G8: Tab to the left
F20::Send, ^{PGUP}

;G9: Backwards in history
F21::Send, !{Left}

;G10: Alt + Tab
F22::Send, !{Tab}

;G11: Minimize the current active window
F23::WinMinimize, A

;G12: Restore previously closed tab
+F23::Send, ^+{t}

;Ctrl tab tab
^!F23::
Send, {CtrlDown}{Tab 2}
Send, {CtrlUp}
return

;Alt tab tab
^+F23::
Send, ^!{Tab}
Sleep 100
Send, {Right}{Enter}
return

;----------------------------------------K95 RGB ACTIONS---------------------------------------
;Keeb G1
^F13::return

;Keeb G2
^F14::return

;Keeb G3
^F15::return

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

;M1, M2, and M3: Copy, cut, and paste
+F24::Send, ^c
+F21::Send, ^x
+F22::Send, ^v