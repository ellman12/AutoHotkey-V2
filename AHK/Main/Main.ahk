;Grouping everything I use the most into 1 file.
#NoEnv
#MaxHotkeysPerInterval 999999999999999999999999999999999
#HotkeyInterval 99999999999999999999999999999999999
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
DetectHiddenWindows, Off
#SingleInstance force

;https://diymediahome.org/wp-content/uploads/shell32_icons.jpg
; Menu, Tray, Icon, shell32.dll, 233 ;Changes the icon to a cute little computer.

;------------------------AUTO-EXECUTE------------------------
;------------MODULE INITIALIZATION FILES------------
; #Include, ...
; #Include, ...
; #Include, ...

;------------MODULE HOTKEY FILES------------
; #Include, ...
; #Include, ...
; #Include, ...

;------------MAIN COMPONENTS------------
#Include, %A_ScriptDir%/Functions/BooleanToggle.ahk
#Include, %A_ScriptDir%/Functions/InArray.ahk
#Include, %A_ScriptDir%/Functions/Tippy.ahk
#Include, %A_ScriptDir%/Functions/ToggleGUI.ahk

#Include, %A_ScriptDir%/FnKeys.ahk

;------------------------MISC HOTKEYS------------------------
;These are completely global and will work no matter the context
#!p::Suspend

Pause:: ;Suspends all hotkeys for the specified number in milliseconds.
#p::
if (suspendTippyToggled = 1)
	ToolTip, Suspended...
SetTimer, setTimerLabel, 2500, On
Suspend, On
return

setTimerLabel:
Suspend, Off
SetTimer, setTimerLabel, Off
ToolTip
return

^\::Send, \ ;This key normally deletes a word. This hotkey allows you to insert a \ without having to suspend hotkeys.

#n::Run, Notepad ;Open Notepad.

sc029::Send, !{Tab} ;The grave accent key (that weird thing under the Tilde ~ symbol) sends Alt + Tab.
^sc029::Send, `` ;Holding Ctrl and pushing the grave accent key inserts the grave accent symbol: `.

!SC00C::WinMinimize, A ;Alt + -
!SC00D::WinMaximize, A ;Alt + +.

;Since Windows 10 annoyingly doesn't allow you to rearrange individual windows for a program on the Taskbar when their icons are expanded out (how I always have it), I made this fantastic workaround.
;It will move the active window to the end of the "stack(?)" of windows.
;E.g., you have 2 MSWord windows open: win1 and win2. By doing this, win1 would move to be after win2. Windows 10 doesn't allow this natively.
#m::
WinHide, A
WinShow, A
return

~$RShift:: ;A "sniper" button, which slows the mouse pointer speed down to a crawl and still outputs the RShift key.
Send, {RShift}
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,1, Int,1)
KeyWait, RShift
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;Make active window AlwaysOnTop.
#Space::
WinSet, AlwaysOnTop, Toggle, A
WinGet, onTop, ExStyle, A
if (onTop & 0x8) { ; 0x8 is WS_EX_TOPMOST.
	message := activeWindowTitle . " is AlwaysOnTop"
	; Tippy(message, 1000) ;TODO
} else {
	message := activeWindowTitle . " is no longer on top"
	; Tippy(message, 1000) ;TODO
}
return

;------------------------CONTEXT-SENSITIVE HOTKEYS------------------------
;These only work in certain contexts (e.g., if a certain window is active).

;------------------------GLOBAL iCUE HOTKEYS------------------------
;Hotkeys sent from iCUE that are interpreted by AutoHotkey.
+F24::Send, ^c ;M1 on K95 RGB copies to the clipboard.
+F21::Send, ^x ;M2 on K95 RGB cuts to the clipboard.
+F22::Send, ^v ;M3 on K95 RGB pastes the clipboard.

;TODO: will be implemented once i get around to AppSwitcher
; ^!F23::topMouseButtons(FrontMouseButtonBehavior) ;Top Front Mouse Button on Scimitar RGB.
; ^+F23::topMouseButtons(BackMouseButtonBehavior) ;Top Back Mouse Button on Scimitar RGB.

; ;Called by top 2 mouse button hotkeys.
; topMouseButtons(buttonMode) {
; global

; 	if (buttonMode = "Double Click")
; 		Send, {Click 2}
; 	else if (buttonMode = "Triple Click")
; 		Send, {Click 3}
; 	else if (buttonMode = "F1")
; 		switchToFirefoxAndBetweenTabs()
; 	else if (buttonMode = "F2")
; 		switchToOtherFirefoxWindows()
; 	else if (buttonMode = "F3")
; 		F3Hotkey()
; 	else if (buttonMode = "F4")
; 		F4Hotkey()
; 	else if (buttonMode = "F6")
; 		nextWinOrShowHideWins("F6", WindowGroupF6, currentWinF6)
; 	else if (buttonMode = "F7")
; 		nextWinOrShowHideWins("F7", WindowGroupF7, currentWinF7)
; 	else if (buttonMode = "F8")
; 		nextWinOrShowHideWins("F8", WindowGroupF8, currentWinF8)
; 	else if (buttonMode = "F10")
; 		nextWinOrShowHideWins("F10", WindowGroupF10, currentWinF10)
; 	else if (buttonMode = "F12")
; 		F12Hotkey()
; }

;------------------------GUI HOTKEYS AND LABELS------------------------
;------------AUTOCORRECT GUI------------
;------------CLIPBOARD GUI------------
;------------EDIT CLIPBOARD GUI------------
;------------MAIN CONTROL PANEL GUI------------

;------------------------MSR FUNCTIONS AND LABELS------------------------

;------------------------EXPERIMENTAL------------------------
;------------------------TEMPORARY------------------------