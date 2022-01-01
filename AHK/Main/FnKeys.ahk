;Allow F1-F12 to be remapped to something more useful. Essentially AppSwitcher and CWG from AHK-V1 merged into 1 super powerful combo.
;Some of this code is copied from Taran Van Hemert from LTT. https://www.youtube.com/watch?v=OqyQABySV8k
;A lot of my ideas can also be attributed to him as well either from videos or from emailing him.

;TODO: temp?
F1Mode := "Default"
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

Actions:
*Tabs: run program if needed. Activate that window and go through tabs forwards
*TabsReverse: same thing but reverse tab order
*Wins: run program or switch between windows
WinSwitcher: group windows together for switching between them
WinHider: group windows together for showing/hiding them
Default behavior is to just send the key like normal: Send the actual key. E.g., if Default specified for F5, send F5 and not anything else
*/
fxKeyPress(action, windowGroupArray, ByRef currentWin, ByRef fxShowHideToggle)
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

;If this Fx is in Window Switcher or Hider mode, add window to array. Else, fire like normal.
ctrlFxPress(Fx, fxMode, windowGroupArray) {
	if (fxMode == "WinSwitcher" or fxMode == "WinHider")
		addWindowFx(windowGroupArray)
	else
		Send, ^{%Fx%}
}

$F1::fxKeyPress(F1Mode, windowGroupF1, currentWinF1, F1VisToggle)
$F2::fxKeyPress(F2Mode, windowGroupF2, currentWinF2, F2VisToggle)
$F3::fxKeyPress(F3Mode, windowGroupF3, currentWinF3, F3VisToggle)
$F4::fxKeyPress(F4Mode, windowGroupF4, currentWinF4, F4VisToggle)
$F5::fxKeyPress(F5Mode, windowGroupF5, currentWinF5, F5VisToggle)
$F6::fxKeyPress(F6Mode, windowGroupF6, currentWinF6, F6VisToggle)
$F7::fxKeyPress(F7Mode, windowGroupF7, currentWinF7, F7VisToggle)
$F8::fxKeyPress(F8Mode, windowGroupF8, currentWinF8, F8VisToggle)
$F9::fxKeyPress(F9Mode, windowGroupF9, currentWinF9, F9VisToggle)
$F10::fxKeyPress(F10Mode, windowGroupF10, currentWinF10, F10VisToggle)
$F11::fxKeyPress(F11Mode, windowGroupF11, currentWinF11, F11VisToggle)
$F12::fxKeyPress(F12Mode, windowGroupF12, currentWinF12, F12VisToggle)

$^F1::ctrlFxPress("F1", F1Mode, windowGroupF1)
$^F2::ctrlFxPress("F2", F2Mode, windowGroupF2)
$^F3::ctrlFxPress("F3", F3Mode, windowGroupF3)
$^F4::ctrlFxPress("F4", F4Mode, windowGroupF4)
$^F5::ctrlFxPress("F5", F5Mode, windowGroupF5)
$^F6::ctrlFxPress("F6", F6Mode, windowGroupF6)
$^F7::ctrlFxPress("F7", F7Mode, windowGroupF7)
$^F8::ctrlFxPress("F8", F8Mode, windowGroupF8)
$^F9::ctrlFxPress("F9", F9Mode, windowGroupF9)
$^F10::ctrlFxPress("F10", F10Mode, windowGroupF10)
$^F11::ctrlFxPress("F11", F11Mode, windowGroupF11)
$^F12::ctrlFxPress("F12", F12Mode, windowGroupF12)

$+F1::fxKeyPress(shiftF1Mode, windowGroupF1, currentWinF1, F1VisToggle)
$+F2::fxKeyPress(shiftF2Mode, windowGroupF2, currentWinF2, F2VisToggle)
$+F3::fxKeyPress(shiftF3Mode, windowGroupF3, currentWinF3, F3VisToggle)
$+F4::fxKeyPress(shiftF4Mode, windowGroupF4, currentWinF4, F4VisToggle)
$+F5::fxKeyPress(shiftF5Mode, windowGroupF5, currentWinF5, F5VisToggle)
$+F6::fxKeyPress(shiftF6Mode, windowGroupF6, currentWinF6, F6VisToggle)
$+F7::fxKeyPress(shiftF7Mode, windowGroupF7, currentWinF7, F7VisToggle)
$+F8::fxKeyPress(shiftF8Mode, windowGroupF8, currentWinF8, F8VisToggle)
$+F9::fxKeyPress(shiftF9Mode, windowGroupF9, currentWinF9, F9VisToggle)
$+F10::fxKeyPress(shiftF10Mode, windowGroupF10, currentWinF10, F10VisToggle)
$+F11::fxKeyPress(shiftF11Mode, windowGroupF11, currentWinF11, F11VisToggle)
$+F12::fxKeyPress(shiftF12Mode, windowGroupF12, currentWinF12, F12VisToggle)