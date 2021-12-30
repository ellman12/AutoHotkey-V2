;Allow F1-F12 to be remapped to something more useful. Essentially AppSwitcher and CWG from AHK-V1 merged into 1 super powerful combo.
;Some of this code is copied from Taran Van Hemert from LTT. https://www.youtube.com/watch?v=OqyQABySV8k
;A lot of my ideas can also be attributed to him as well either from videos or from emailing him.

;TODO: temp?
F1Mode := "Default"
F2Mode := "Default"
F3Mode := "Default"
F4Mode := "Default"
F5Mode := "Default"
F6Mode := "Default"
F7Mode := "Default"
F8Mode := "Default"
F9Mode := "Default"
F10Mode := "Default"
F11Mode := "Default"
F12Mode := "Default"

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
WinGroup: group windows together for switching between them
WinHider: group windows together for showing/hiding them
Default behavior is to just send the key like normal: Send the actual key. E.g., if Default specified for F5, send F5 and not anything else
*/
fxKeyPress(keyName, action, windowGroup)
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

		;Custom Window Groups

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

;TODO
$F1::fxKeyPress("F1", F1Mode, "todo lmao")
$F2::fxKeyPress("F2", F2Mode, "todo lmao")
$F3::fxKeyPress("F3", F3Mode, "todo lmao")
$F4::fxKeyPress("F4", F4Mode, "todo lmao")
$F5::fxKeyPress("F5", F5Mode, "todo lmao")
$F6::fxKeyPress("F6", F6Mode, "todo lmao")
$F7::fxKeyPress("F7", F7Mode, "todo lmao")
$F8::fxKeyPress("F8", F8Mode, "todo lmao")
$F9::fxKeyPress("F9", F9Mode, "todo lmao")
$F10::fxKeyPress("F10", F10Mode, "todo lmao")
$F11::fxKeyPress("F11", F11Mode, "todo lmao")
$F12::fxKeyPress("F12", F12Mode, "todo lmao")

$^F1::fxKeyPress("F1", F1Mode, "todo lmao")
$^F2::fxKeyPress("F2", F2Mode, "todo lmao")
$^F3::fxKeyPress("F3", F3Mode, "todo lmao")
$^F4::fxKeyPress("F4", F4Mode, "todo lmao")
$^F5::fxKeyPress("F5", F5Mode, "todo lmao")
$^F6::fxKeyPress("F6", F6Mode, "todo lmao")
$^F7::fxKeyPress("F7", F7Mode, "todo lmao")
$^F8::fxKeyPress("F8", F8Mode, "todo lmao")
$^F9::fxKeyPress("F9", F9Mode, "todo lmao")
$^F10::fxKeyPress("F10", F10Mode, "todo lmao")
$^F11::fxKeyPress("F11", F11Mode, "todo lmao")
$^F12::fxKeyPress("F12", F12Mode, "todo lmao")

$+F1::fxKeyPress("F1", F1Mode, "todo lmao")
$+F2::fxKeyPress("F2", F2Mode, "todo lmao")
$+F3::fxKeyPress("F3", F3Mode, "todo lmao")
$+F4::fxKeyPress("F4", F4Mode, "todo lmao")
$+F5::fxKeyPress("F5", F5Mode, "todo lmao")
$+F6::fxKeyPress("F6", F6Mode, "todo lmao")
$+F7::fxKeyPress("F7", F7Mode, "todo lmao")
$+F8::fxKeyPress("F8", F8Mode, "todo lmao")
$+F9::fxKeyPress("F9", F9Mode, "todo lmao")
$+F10::fxKeyPress("F10", F10Mode, "todo lmao")
$+F11::fxKeyPress("F11", F11Mode, "todo lmao")
$+F12::fxKeyPress("F12", F12Mode, "todo lmao")