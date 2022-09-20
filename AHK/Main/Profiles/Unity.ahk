#If WinActive("ahk_exe Unity.exe")

;Mouse G2
F14::Send, {Enter}

;Mouse G5
F17::
Send, {LAlt down}
Send, {LButton down}
KeyWait, F17
Send, {LAlt up}
Send, {LButton up}
return

;Mouse G6
F18::Send, ^p

;Mouse G8
F20::Send, ^s

#If