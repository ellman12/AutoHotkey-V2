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
;Keeb G1
^F13::activateOrSwitchTabs("chrome.exe", "chrome.exe", true)

;Keeb G2
^F14::activateOrSwitchTabs("chrome.exe", "chrome.exe", false)

;Keeb G3
^F15::switchBetweenWindows("chrome.exe", "chrome.exe", "chromeWins")

;Keeb G4
^F16::activateOrSwitchTabs("rider64.exe", "rider64.exe", true)

;Keeb G5
^F17::activateOrSwitchTabs("rider64.exe", "rider64.exe", false)

;Keeb G6
^F18::switchBetweenWindows("rider64.exe", "rider64.exe", "rider64Wins")

;Keeb G7
^F19::
	if WinActive("Microsoft To Do") ;In the Tasks menu, add a task and mark it due today.
		createMSToDoTask(1, 0)
	else if WinExist("Microsoft To Do")
		WinActivate
	else
		Run, C:\Users\%A_UserName%\Documents\Microsoft To Do
return

;Keeb G8
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

;Keeb G9
^F21::
if !WinExist("ahk_exe gitkraken.exe")
	Run, "C:/Users/%A_UserName%/AppData/Local/gitkraken/gitkraken.exe"
else
	WinActivate, ahk_exe gitkraken.exe
return

;Keeb G10
^F22::Send, ^t

;Keeb G11
^F23::Send, ^w

;Keeb G12
!F23::WinMinimize, A

;Keeb G13
!F13::Send, ^#{F4}

;Keeb G14
!F14::Send, ^#d

;Keeb G15
!F15::Send, !{F4}

;Keeb G16
!F16::Send, #{Tab}

;Keeb G17
!F17::Send, ^#{Left}

;Keeb G18
!F18::Send, ^#{Right}

;M1, M2, and M3: Copy, cut, and paste
+F24::Send, ^c
+F21::Send, ^x
+F22::Send, ^v