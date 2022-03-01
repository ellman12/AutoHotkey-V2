#If WinActive("ahk_exe Unity.exe")

;Mouse G4
F16::Send, ^p
return

;Mouse G5
F17::
Send, {MButton down}
KeyWait, F17
Send, {MButton up}
return

;Mouse G8
F20::Send, ^s
return

#If