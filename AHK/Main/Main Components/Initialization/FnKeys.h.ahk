#Include, %A_ScriptDir%/Main Components/Custom Window Groups.ahk

F1Mode := "FirefoxTabs"
F2Mode := "FirefoxWins"
F3Mode := "VSCodeTabs"
F4Mode := "VSCodeWins"
F5Mode := "Default"
F6Mode := "WinSwitcher"
F7Mode := "WinSwitcher"
F8Mode := "WinHider"
F9Mode := "ExplorerWins"
F10Mode := "WinHider"
F11Mode := "Default"
F12Mode := "Default"

ctrlF1Mode := "NewFFWin"
ctrlF2Mode := "NewFFWin"
ctrlF3Mode := "NewChrWin"
ctrlF4Mode := "NewChrWin"
ctrlF5Mode := "Default"
ctrlF6Mode := "WinAdder"
ctrlF7Mode := "WinAdder"
ctrlF8Mode := "WinAdder"
ctrlF9Mode := "Default"
ctrlF10Mode := "WinAdder"
ctrlF11Mode := "Default"
ctrlF12Mode := "Default"

shiftF1Mode := "FirefoxTabsReverse"
shiftF2Mode := "Default"
shiftF3Mode := "VSCodeTabsReverse"
shiftF4Mode := "Default"
shiftF5Mode := "Default"
shiftF6Mode := "Default"
shiftF7Mode := "Default"
shiftF8Mode := "Default"
shiftF9Mode := "Default"
shiftF10Mode := "Default"
shiftF11Mode := "Default"
shiftF12Mode := "Default"

altF1Mode := "NewPrivFFWin"
altF2Mode := "NewPrivFFWin"
altF3Mode := "NewPrivChrWin"
altF4Mode := "NewPrivChrWin"
altF5Mode := "Default"
altF6Mode := "AddAndHide"
altF7Mode := "AddAndHide"
altF8Mode := "AddAndHide"
altF9Mode := "Default"
altF10Mode := "AddAndHide"
altF11Mode := "Default"
altF12Mode := "Default"

winF1Mode := "Default"
winF2Mode := "Default"
winF3Mode := "Default"
winF4Mode := "Default"
winF5Mode := "Default"
winF6Mode := "Default"
winF7Mode := "Default"
winF8Mode := "Default"
winF9Mode := "Default"
winF10Mode := "Default"
winF11Mode := "Default"
winF12Mode := "Default"

ctrlAltF1Mode := "Default"
ctrlAltF2Mode := "Default"
ctrlAltF3Mode := "Default"
ctrlAltF4Mode := "Default"
ctrlAltF5Mode := "Default"
ctrlAltF6Mode := "WinRemover"
ctrlAltF7Mode := "WinRemover"
ctrlAltF8Mode := "WinRemover"
ctrlAltF9Mode := "Default"
ctrlAltF10Mode := "WinRemover"
ctrlAltF11Mode := "Default"
ctrlAltF12Mode := "Default"

ctrlShiftF1Mode := "Default"
ctrlShiftF2Mode := "Default"
ctrlShiftF3Mode := "Default"
ctrlShiftF4Mode := "Default"
ctrlShiftF5Mode := "Default"
ctrlShiftF6Mode := "Default"
ctrlShiftF7Mode := "Default"
ctrlShiftF8Mode := "Default"
ctrlShiftF9Mode := "Default"
ctrlShiftF10Mode := "Default"
ctrlShiftF11Mode := "Default"
ctrlShiftF12Mode := "Default"

/*
F1-F12 are hotkeys that each call this and can be remapped at runtime.
keyName = "F1"-"F12".
action = what to run on press.
windowGroup = the array of window IDs for that Fx. May or may not be needed depending on mode.
fxShowHideToggle = visibility toggle for windows in the group (again, may or may not be used).

Actions:
NewFFWin/NewChrWin & NewPrivFFWin/NewPrivChrWin: yes
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
		case "NewFFWin":Run, C:\Program Files\Mozilla Firefox\firefox.exe
		case "NewPrivFFWin":Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window
		case "FirefoxTabs":activateOrSwitchTabs("firefox.exe", "firefox.exe", false)
		case "FirefoxTabsReverse":activateOrSwitchTabs("firefox.exe", "firefox.exe", true)
		case "FirefoxWins":switchBetweenWindows("firefox.exe", "firefox.exe", "firefoxWins")

		case "NewChrWin":Run, chrome.exe
		case "NewPrivChrWin":Run, chrome.exe -incognito
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
		
		case "ExplorerWins":switchToExplorer()

		case "WinAdder":addWindowFx(windowGroupArray)
		case "WinRemover":removeWindowFx(windowGroupArray)
		case "WinSwitcher":nextWindowFx(windowGroupArray, currentWin)
		case "WinHider":showOrHideWindowsFx(windowGroupArray, fxShowHideToggle)
		case "AddAndHide":addAndHideWindowFx(windowGroupArray)

		Default: ;Need to move modifiers outside the {} or else Send won't work :/
			ogHotkey := A_ThisHotkey
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

;Run explorer if not exist and if does switch between windows
switchToExplorer() {
	IfWinNotExist, ahk_class CabinetWClass
        Run, explorer.exe
    GroupAdd, explorerWins, ahk_class CabinetWClass
    if WinActive("ahk_exe explorer.exe")
        GroupActivate, explorerWins, R
    else
        WinActivate ahk_class CabinetWClass
}