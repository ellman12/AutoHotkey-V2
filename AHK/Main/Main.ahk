;Grouping everything I use the most into 1 file.
#NoEnv
#UseHook
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
Menu, Tray, Icon, shell32.dll, 233 ;Changes the icon to a cute little computer.

;----------------------------AUTO-EXECUTE---------------------------
;---------------------CONSTANTS---------------------
global TMP_FOLDER_PATH := A_ScriptDir . "/../tmp"
global CONFIG_PATH := TMP_FOLDER_PATH . "/Main.ini"

;---------------------MAIN VARS---------------------
global activeWindowTitle, activeWindowID, FrontTopMouseBtnBehavior, BackTopMouseBtnBehavior

global F11F12Toggled ;Override F11 & F12 to be Home and End (for Asus Laptop).

global sleepDuration := 100 ;ms
global Num2And8Step := 3 ;When Num2 or Num8 pressed, how much to increase/decrease volume.
global autoNumPadModeToggle := true ;If true, switch NumPad modes automatically. Manual control if false.
global savedNumMinusVol

;---------------------FUNCTIONS---------------------
#Include, %A_ScriptDir%/../Functions/BooleanToggle.ahk
#Include, %A_ScriptDir%/../Functions/InArray.ahk
#Include, %A_ScriptDir%/../Functions/Tippy.ahk
#Include, %A_ScriptDir%/../Functions/ToggleGUI.ahk

;---------------INITIALIZATION FILES----------------
;Stuff to be ran in auto-execute before hotkeys
#Include, %A_ScriptDir%/Main Components/Initialization/AutoCorrect.h.ahk
#Include, %A_ScriptDir%/Main Components/Initialization/FnKeys.h.ahk
#Include, %A_ScriptDir%/Main Components/Initialization/FnKeysSettings.h.ahk
#Include, %A_ScriptDir%/MainSettings.h.ahk ;<-- Put after FnKeys stuff so it can access the Fn Modes constant for the ` key
#Include, %A_ScriptDir%/Main Components/Prompt/FAR GUI.h.ahk
#Include, %A_ScriptDir%/Main Components/Prompt/Prompt.h.ahk

#Include, %A_ScriptDir%/../Modules/Initialization/Clipboard Edit.h.ahk
#Include, %A_ScriptDir%/../Modules/Quick Code/Quick Code.h.ahk

;-----------------------MISC-----------------------
SetCapsLockState, AlwaysOff

OnExit, RunOnExit

Loop 12 { ;Read in all 12 win group files
	group := "windowGroupF" . A_Index
	readGroupFromFile("F" . A_Index, %group%)
}

readConfigFile()
setMainGUIValues()

;---------------------MAIN LOOP---------------------
;Only works if put here
Loop {
	WinGetActiveTitle, activeWindowTitle
	WinGet, activeWindowID, ID, A
	
	if (autoNumPadModeToggle = true) {
		if InStr(activeWindowTitle, "- YouTube") {
			SetNumLockState, AlwaysOn
			SetScrollLockState, AlwaysOn
		} else { ;Set it to MusicBee mode: the default (and also most commonly used) mode.
			SetNumLockState, AlwaysOff
			SetScrollLockState, AlwaysOff
		}
	}
	Sleep sleepDuration ;Reduce CPU usage.
}

;-------------------HOTKEY FILES--------------------
;Files that have hotkeys, labels, or anything else that can't be in the auto-execute section.
#Include, %A_ScriptDir%/MainSettings.ahk

#Include, %A_ScriptDir%/Main Components/Hotkeys/AutoCorrect.ahk
#Include, %A_ScriptDir%/Main Components/Hotkeys/CapsLock.ahk
#Include, %A_ScriptDir%/Main Components/Hotkeys/FnKeys.ahk
#Include, %A_ScriptDir%/Main Components/Hotkeys/FnKeysSettings.ahk
#Include, %A_ScriptDir%/Main Components/Hotkeys/K95.ahk
#Include, %A_ScriptDir%/Main Components/Hotkeys/MS To Do.ahk
#Include, %A_ScriptDir%/Main Components/Hotkeys/NumPad.ahk
#Include, %A_ScriptDir%/Main Components/Hotkeys/Temp Hotstrings.ahk

#Include, %A_ScriptDir%/Main Components/Prompt/FAR GUI.ahk
#Include, %A_ScriptDir%/Main Components/Prompt/Prompt.ahk

#Include, %A_ScriptDir%/Profiles/Unity.ahk

#Include, %A_ScriptDir%/../Modules/Hotkeys/Stream Deck XL/Stream Deck XL Hotkeys.ahk

#Include, %A_ScriptDir%/../Modules/Hotkeys/Clipboard Edit.ahk
#Include, %A_ScriptDir%/../Modules/Hotkeys/Easy Window Dragging.ahk
#Include, %A_ScriptDir%/../Modules/Hotkeys/GitKraken.ahk
#Include, %A_ScriptDir%/../Modules/Hotkeys/InsertModifier.ahk
#Include, %A_ScriptDir%/../Modules/Hotkeys/Text Modifier.ahk

#Include, %A_ScriptDir%/../Modules/Quick Code/Quick Code.ahk

;----------------------------MISC HOTKEYS---------------------------
;These are completely global and will work no matter the context
^#r::Reload ;Saves custom window groups on reload (exit).

#+r::resetMainSettings()

^!r:: ;Restart script without restoring window groups.
clearGroups := true
Loop 12 {
	FileDelete, %TMP_FOLDER_PATH%/F%A_Index% Group.tmp
}
Reload
return

^CtrlBreak:: ;Technically Ctrl + Pause. Read about this here: https://www.autohotkey.com/docs/KeyList.htm#other
#!p::
Suspend
return

Pause:: ;Suspends all hotkeys for the specified number in milliseconds.
#p::
SetTimer, setTimerLabel, 2500, On
Suspend, On
return

setTimerLabel:
Suspend, Off
SetTimer, setTimerLabel, Off
ToolTip
return

\::
Send, ^+{Left}
Send, {BackSpace}
return

^\::Send, \ ;This key normally deletes a word. This hotkey allows you to insert a \ without having to suspend hotkeys.

#n::Run, Notepad ;Open Notepad.

sc029::runFnAction(graveAccentMode, windowGroupGraveAccent, currentWinGraveAccent, graveAccentVisToggle) ;The grave accent key (that weird thing under the Tilde ~ symbol) can be remapped just like F1-F12.
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

~RShift:: ;A "sniper" button, which slows the mouse pointer speed down to a crawl and still outputs the RShift key.
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
	Tippy(message, 1000)
} else {
	message := activeWindowTitle . " is no longer on top"
	Tippy(message, 1000)
}
return

;------------------DISABLE ANNOYING WINDOWS HOTKEYS-----------------
^#f::
^#BackSpace::
return

;---------------------CONTEXT-SENSITIVE HOTKEYS---------------------
;These only work in certain contexts (e.g., if a certain window is active or something is toggled).
;My Asus laptop requires holding Fn to activate Home/End/PgUp/PgDn so remap useless keys to make it easier
#If F11F12Toggled
F11::Send, {Home}
^F11::Send, ^{Home}
+F11::Send, +{Home}
^+F11::Send, ^+{Home}

F12::Send, {End}
^F12::Send, ^{End}
+F12::Send, +{End}
^+F12::Send, ^+{End}
#If

;------------------------GLOBAL iCUE HOTKEYS------------------------
;Hotkeys sent from iCUE that are interpreted by AutoHotkey.
+F24::Send, ^c ;M1 on K95 RGB copies to the clipboard.
+F21::Send, ^x ;M2 on K95 RGB cuts to the clipboard.
;M3 on K95 RGB pastes the clipboard.
+F22::
if (M3Paste)
	Send, ^v
else if (M3Send)
	SendRaw, %Clipboard%
return

;Volume wheel up/down on K95 RGB does log volume scaling.
^!F22::changeVolume(1)
^+F22::changeVolume(-1)

^!F23::topMouseButtons(FrontTopMouseBtnBehavior) ;Top Front Mouse Button on Scimitar RGB.
^+F23::topMouseButtons(BackTopMouseBtnBehavior) ;Top Back Mouse Button on Scimitar RGB.

topMouseButtons(buttonMode) {
	if (buttonMode = "Double Click")
		Send, {Click 2}
	else if (buttonMode = "Triple Click")
		Send, {Click 3}
	else
		runFnAction(buttonMode, _, _, _)
}

;-------------------DEFAULT MOUSE BUTTON BEHAVIOR-------------------
;Most if not all of these hotkeys work in basically every app ever
;These can be overridden in profiles if desired
;G1
;Horizontal scroll
F13 & WheelUp::Send, {WheelLeft}
F13 & WheelDown::Send, {WheelRight}

;G2: Ctrl Tab
F14::Send, ^{Tab}

;G3: faster scrolling
F15 & WheelUp::Send, {WheelUp 8}
F15 & WheelDown::Send, {WheelDown 8}

;A way to make the mouse move faster while Mouse G3 and the Right Button are held down.
;It's basically the complete opposite of the sniper button.
F15 & RButton::
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,17, Int,1)
KeyWait, RButton
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;G4
F16::Send, ^t

;G5: tab to the right
F17::Send, ^{PGDN}

;G6: forward in history
F18::Send, !{Right}

;G7: close tab
F19::Send, ^{w}

;G8: tab to the left
F20::Send, ^{PGUP}

;G9: backwards in history
F21::Send, !{Left}

;G10: Alt + Tab
F22::Send, !{Tab}

;G11: minimize the current active window
F23::WinMinimize, A

;G12: restore previously closed tab
+F23::Send, ^+{t}

;----------------------MAIN LABELS AND FUNCS------------------------
RunOnExit:
if (!clearGroups)
{
	Loop 12 { ;Write all 12 win group files
		group := "windowGroupF" . A_Index
		writeGroupToFile("F" . A_Index, %group%)
	}
}
ExitApp
return

;--------------------------EXPERIMENTAL-----------------------------
;----------------------------TEMPORARY------------------------------