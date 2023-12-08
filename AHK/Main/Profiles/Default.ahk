;Default behavior of macro buttons on Scimitar Pro and K95.
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
F17::Send, ^{PgDn}

;G6: Forward in history
F18::Send, !{Right}

;G7: Close tab
F19::Send, ^{w}

;G8: Tab to the left
F20::Send, ^{PgUp}

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
;G1
^F13::Send, ^{PgUp}

;G2
^F14::Send, ^{PgDn}

;G3
#IfWinActive, ahk_exe chrome.exe
^F15::Send, !w
#If

^F15::Send, ^{Tab}

;G4
^F16::
if !WinExist("ahk_exe gitkraken.exe")
	Run, "C:/Users/%A_UserName%/AppData/Local/gitkraken/gitkraken.exe"
else
	WinActivate, ahk_exe gitkraken.exe
return

;G5
^F17::switchBetweenWindows("chrome.exe", "chrome.exe", "chromeWins")

;G6
^F18::switchBetweenWindows("rider64.exe", "C:/ProgramData/Microsoft/Windows/Start Menu/Programs/JetBrains/JetBrains Rider 2022.2.2.lnk", "riderWins")

;G7
^F19::switchBetweenWindows("mintty.exe", "C:/ProgramData/Microsoft/Windows/Start Menu/Programs/Git/Git Bash.lnk", "bashWin")

;G8
^F20::
F8VisToggle := 1
if (WorkComputer) {
	WinShow, ahk_exe Teams.exe
	switchBetweenWindows("teams.exe", "C:/Users/" . A_UserName . "/AppData/Local/Microsoft/Teams/Update.exe", "teams")
} else {
	WinShow, ahk_exe Discord.exe
	switchBetweenWindows("discord.exe", "C:/Users/" . A_UserName . "/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Discord Inc/Discord.lnk", "discord")
}
return

;G9
^F21::switchBetweenWindows("firefox.exe", "C:/Program Files/Mozilla Firefox/firefox.exe", "firefoxWins")

;G10
^F22::
if WinActive("Microsoft To Do") ;In the Tasks menu, add a task and mark it due today.
	createMSToDoTask(1, 0)
else if WinExist("Microsoft To Do")
	WinActivate
else
	Run, C:\Users\%A_UserName%\Documents\Microsoft To Do
return

;G11
^F23::switchBetweenWindows("nvim.exe", "C:/Program Files/Neovim/bin/nvim.exe", "neovimWins")

;G12
!F23::Send, !{F4}

;G13
!F13::Send, ^#{F4}

;G14
!F14::Send, ^#d

;G15
!F15::switchBetweenWindows("MusicBee.exe", "C:/Program Files (x86)/MusicBee/MusicBee.exe", "musicBee")

;G16
!F16::Send, #{Tab}

;G17
!F17::Send, ^#{Left}

;G18
!F18::Send, ^#{Right}

;M1, M2, and M3: Copy, cut, and paste
+F24::Send, ^c
+F21::Send, ^x
+F22::Send, ^v