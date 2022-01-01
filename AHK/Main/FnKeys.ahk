;Allow F1-F12 to be remapped to something more useful. Essentially AppSwitcher and CWG from AHK-V1 merged into 1 super powerful combo.
;Some of this code is copied from Taran Van Hemert from LTT. https://www.youtube.com/watch?v=OqyQABySV8k
;A lot of my ideas can also be attributed to him as well either from videos or from emailing him.

;TODO: temp?
F1Mode := "FirefoxTabs"
F2Mode := "Default"
F3Mode := "Default"
F4Mode := "Default"
F5Mode := "Default"
F6Mode := "WinSwitcher"
F7Mode := "WinHider"
F8Mode := "Default"
F9Mode := "Default"
F10Mode := "Default"
F11Mode := "Default"
F12Mode := "Default"

ctrlF1Mode := "Default"
ctrlF2Mode := "Default"
ctrlF3Mode := "Default"
ctrlF4Mode := "Default"
ctrlF5Mode := "Default"
ctrlF6Mode := "WinAdder"
ctrlF7Mode := "Default"
ctrlF8Mode := "Default"
ctrlF9Mode := "Default"
ctrlF10Mode := "Default"
ctrlF11Mode := "Default"
ctrlF12Mode := "Default"

shiftF1Mode := "FirefoxTabsReverse"
shiftF2Mode := "Default"
shiftF3Mode := "Default"
shiftF4Mode := "Default"
shiftF5Mode := "Default"
shiftF6Mode := "WinSwitcher"
shiftF7Mode := "WinHider"
shiftF8Mode := "Default"
shiftF9Mode := "Default"
shiftF10Mode := "Default"
shiftF11Mode := "Default"
shiftF12Mode := "Default"

;These work together to be interchangeable
#Include, %A_ScriptDir%/Custom Window Groups.ahk

/*
F1-F12 are hotkeys that each call this and can be remapped at runtime.
keyName = "F1"-"F12".
action = what to run on press.
windowGroup = the array of window IDs for that Fx. May or may not be needed depending on mode.
fxShowHideToggle = visibility toggle for windows in the group (again, may or may not be used).

Actions:
*Tabs: run program if needed. Activate that window and go through tabs forwards
*TabsReverse: same thing but reverse tab order
*Wins: run program or switch between windows
WinAdder: adding windows to the Fx group
WinSwitcher: group windows together for switching between them
WinHider: group windows together for showing/hiding them
Default behavior is to just send the key like normal: Send the actual key. E.g., if Default specified for F5, send F5 and not anything else
*/
runAction(action, windowGroupArray, ByRef currentWin, ByRef fxShowHideToggle)
{
	switch (action)
	{
		case "FirefoxTabs":activateOrSwitchTabs("firefox.exe", "firefox.exe", false)
		case "FirefoxTabsReverse":activateOrSwitchTabs("firefox.exe", "firefox.exe", true)
		case "FirefoxWins":switchBetweenWindows("firefox.exe", "firefox.exe", "firefoxWins")

		case "ChromeTabs":activateOrSwitchTabs("chrome.exe", "chrome.exe", false)
		case "ChromeTabsReverse":activateOrSwitchTabs("chrome.exe", "chrome.exe", true)
		case "ChromeWins":switchBetweenWindows("chrome.exe", "chrome.exe", "chromeWins")

		case "RiderTabs":activateOrSwitchTabs("rider64.exe", "rider64.exe", false)
		case "RiderTabsReverse":activateOrSwitchTabs("rider64.exe", "rider64.exe", true)
		case "RiderWins":switchBetweenWindows("rider64.exe", "rider64.exe", "vsWins")

		case "VSCodeTabs":activateOrSwitchTabs("Code.exe", "Code.exe", false)
		case "VSCodeTabsReverse":activateOrSwitchTabs("Code.exe", "Code.exe", true)
		case "VSCodeWins":switchBetweenWindows("Code.exe", "Code.exe", "vscodeWins")

		case "VSTabs":activateOrSwitchTabs("devenv.exe", "devenv.exe", false)
		case "VSTabsReverse":activateOrSwitchTabs("devenv.exe", "devenv.exe", true)
		case "VSWins":switchBetweenWindows("devenv.exe", "devenv.exe", "vsWins")

		case "WinAdder":addWindowFx(windowGroupArray)
		case "WinSwitcher":nextWindowFx(windowGroupArray, currentWin)
		case "WinHider":showOrHideWindowsFx(windowGroupArray, fxShowHideToggle)

		Default: ;Need to move modifiers outside the {} or else Send won't work :/
			ogHotkey := A_ThisHotkey
			if (InStr(ogHotkey, "$")) ogHotkey := StrReplace(ogHotkey, "$")

			modifiersList := ["#", "!", "^", "+"]
			for k, v in modifiersList {
				if (InStr(ogHotkey, v)) {
					ogHotkey := StrReplace(ogHotkey, v)
					modifiers .= v
				}
			}

			newHotkey := modifiers . "{" . ogHotkey . "}"
			Send, %newHotkey%
		return
	}
}

/*
Either run a program if 0 windows exist of that .exe, or switch to a window if one exists.
If a window is active, switch between tabs.

Parameter Examples:
string exeName = 'firefox.exe'
string exePath = 'C:\Program Files\Mozilla Firefox\firefox.exe'
bool reverse = False for forward (--> / PgDn). True for reverse (<-- / PgUp).
*/
activateOrSwitchTabs(exeName, exePath, reverse) {
	fullExe := "ahk_exe " . exeName
	if !WinExist(fullExe)
		Run, %exePath%
	else if WinActive(fullExe)
		if (reverse)
		Send ^{PgUp}
	else
		Send ^{PgDn}
	else {
		; WinActivate %fullExe% ;TODO??????????
		WinActivatebottom ahk_exe firefox.exe
		;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
		;the below code should fix that.
		WinGet, hWnd, ID, ahk_exe firefox.exe
		DllCall("SetForegroundWindow", UInt, hWnd)
	}
}

/*
Either run a program if 0 windows exist of that .exe, or switch between windows.

Parameter Examples:
string exeName = 'firefox.exe'
string exePath = 'C:\Program Files\Mozilla Firefox\firefox.exe'
string groupName = name of group to store windows in.
*/
switchBetweenWindows(exeName, exePath, groupName) {
	fullExe := "ahk_exe " . exeName
	if !WinExist(fullExe)
		Run, %exePath%
	else
	{
		GroupAdd, %groupName%, %fullExe%
		if WinActive(fullExe)
			GroupActivate, %groupName%, R
		else
			WinActivate %fullExe%
	}
}

$F1::runAction(F1Mode, windowGroupF1, currentWinF1, F1VisToggle)
$F2::runAction(F2Mode, windowGroupF2, currentWinF2, F2VisToggle)
$F3::runAction(F3Mode, windowGroupF3, currentWinF3, F3VisToggle)
$F4::runAction(F4Mode, windowGroupF4, currentWinF4, F4VisToggle)
$F5::runAction(F5Mode, windowGroupF5, currentWinF5, F5VisToggle)
$F6::runAction(F6Mode, windowGroupF6, currentWinF6, F6VisToggle)
$F7::runAction(F7Mode, windowGroupF7, currentWinF7, F7VisToggle)
$F8::runAction(F8Mode, windowGroupF8, currentWinF8, F8VisToggle)
$F9::runAction(F9Mode, windowGroupF9, currentWinF9, F9VisToggle)
$F10::runAction(F10Mode, windowGroupF10, currentWinF10, F10VisToggle)
$F11::runAction(F11Mode, windowGroupF11, currentWinF11, F11VisToggle)
$F12::runAction(F12Mode, windowGroupF12, currentWinF12, F12VisToggle)

$^F1::runAction(ctrlF1Mode, windowGroupF1, currentWinF1, F1VisToggle)
$^F2::runAction(ctrlF2Mode, windowGroupF2, currentWinF2, F2VisToggle)
$^F3::runAction(ctrlF3Mode, windowGroupF3, currentWinF3, F3VisToggle)
$^F4::runAction(ctrlF4Mode, windowGroupF4, currentWinF4, F4VisToggle)
$^F5::runAction(ctrlF5Mode, windowGroupF5, currentWinF5, F5VisToggle)
$^F6::runAction(ctrlF6Mode, windowGroupF6, currentWinF6, F6VisToggle)
$^F7::runAction(ctrlF7Mode, windowGroupF7, currentWinF7, F7VisToggle)
$^F8::runAction(ctrlF8Mode, windowGroupF8, currentWinF8, F8VisToggle)
$^F9::runAction(ctrlF9Mode, windowGroupF9, currentWinF9, F9VisToggle)
$^F10::runAction(ctrlF10Mode, windowGroupF10, currentWinF10, F10VisToggle)
$^F11::runAction(ctrlF11Mode, windowGroupF11, currentWinF11, F11VisToggle)
$^F12::runAction(ctrlF12Mode, windowGroupF12, currentWinF12, F12VisToggle)

$+F1::runAction(shiftF1Mode, windowGroupF1, currentWinF1, F1VisToggle)
$+F2::runAction(shiftF2Mode, windowGroupF2, currentWinF2, F2VisToggle)
$+F3::runAction(shiftF3Mode, windowGroupF3, currentWinF3, F3VisToggle)
$+F4::runAction(shiftF4Mode, windowGroupF4, currentWinF4, F4VisToggle)
$+F5::runAction(shiftF5Mode, windowGroupF5, currentWinF5, F5VisToggle)
$+F6::runAction(shiftF6Mode, windowGroupF6, currentWinF6, F6VisToggle)
$+F7::runAction(shiftF7Mode, windowGroupF7, currentWinF7, F7VisToggle)
$+F8::runAction(shiftF8Mode, windowGroupF8, currentWinF8, F8VisToggle)
$+F9::runAction(shiftF9Mode, windowGroupF9, currentWinF9, F9VisToggle)
$+F10::runAction(shiftF10Mode, windowGroupF10, currentWinF10, F10VisToggle)
$+F11::runAction(shiftF11Mode, windowGroupF11, currentWinF11, F11VisToggle)
$+F12::runAction(shiftF12Mode, windowGroupF12, currentWinF12, F12VisToggle)