;Allows remapping of the mostly useless function keys (F1-F12) at runtime.
;A lot (most) of the ideas and inspiration behind this came from this video and the script(s?) in the description: https://youtu.be/OqyQABySV8k
#Include, %A_ScriptDir%/Main Components/FnKeys/Custom Window Groups.ahk

global graveAccentMode

global F1Mode
global F2Mode
global F3Mode
global F4Mode
global F5Mode
global F6Mode
global F7Mode
global F8Mode
global F9Mode
global F10Mode
global F11Mode
global F12Mode

global ctrlF1Mode
global ctrlF2Mode
global ctrlF3Mode
global ctrlF4Mode
global ctrlF5Mode
global ctrlF6Mode
global ctrlF7Mode
global ctrlF8Mode
global ctrlF9Mode
global ctrlF10Mode
global ctrlF11Mode
global ctrlF12Mode

global shiftF1Mode
global shiftF2Mode
global shiftF3Mode
global shiftF4Mode
global shiftF5Mode
global shiftF6Mode
global shiftF7Mode
global shiftF8Mode
global shiftF9Mode
global shiftF10Mode
global shiftF11Mode
global shiftF12Mode

global altF1Mode
global altF2Mode
global altF3Mode
global altF4Mode
global altF5Mode
global altF6Mode
global altF7Mode
global altF8Mode
global altF9Mode
global altF10Mode
global altF11Mode
global altF12Mode

global winF1Mode
global winF2Mode
global winF3Mode
global winF4Mode
global winF5Mode
global winF6Mode
global winF7Mode
global winF8Mode
global winF9Mode
global winF10Mode
global winF11Mode
global winF12Mode

global ctrlAltF1Mode
global ctrlAltF2Mode
global ctrlAltF3Mode
global ctrlAltF4Mode
global ctrlAltF5Mode
global ctrlAltF6Mode
global ctrlAltF7Mode
global ctrlAltF8Mode
global ctrlAltF9Mode
global ctrlAltF10Mode
global ctrlAltF11Mode
global ctrlAltF12Mode

global ctrlShiftF1Mode
global ctrlShiftF2Mode
global ctrlShiftF3Mode
global ctrlShiftF4Mode
global ctrlShiftF5Mode
global ctrlShiftF6Mode
global ctrlShiftF7Mode
global ctrlShiftF8Mode
global ctrlShiftF9Mode
global ctrlShiftF10Mode
global ctrlShiftF11Mode
global ctrlShiftF12Mode

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
runFnAction(action, windowGroupArray, ByRef currentWin, ByRef fxShowHideToggle)
{
	switch (action)
	{
		case "F2":Send, {F2}
		case "Alt Tab":Send, !{Tab}
		case "Ctrl Tab":Send, ^{Tab}
		case "Ctrl Shift Tab":Send, ^+{Tab}
		case "Ctrl PgUp":Send, ^{PgUp}
		case "Ctrl PgDn":Send, ^{PgDn}
		case "Ctrl T":Send, ^t
		case "Ctrl W":Send, ^w
		case "Minimize":WinMinimize, A
		case "Maximize":WinMaximize, A
		
		case "NewFFWin":Run, C:\Program Files\Mozilla Firefox\firefox.exe
		case "NewPrivFFWin":Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window
		case "FirefoxWins":switchBetweenWindows("firefox.exe", "C:/Program Files/Mozilla Firefox/firefox.exe", "firefoxWins")

		case "NewChrWin":Run, chrome.exe
		case "NewPrivChrWin":Run, chrome.exe -incognito
		case "ChromeWins":switchBetweenWindows("chrome.exe", "chrome.exe", "chromeWins")

		case "RiderWins":switchBetweenWindows("rider64.exe", "rider64.exe", "riderWins")

		case "WebStormWins":switchBetweenWindows("webstorm64.exe", "webstorm64.exe", "webStormWins")

		case "VSCodeWins":switchBetweenWindows("Code.exe", "Code.exe", "vscodeWins")

		case "ExplorerWins":switchToExplorer()

		case "WinAdder":addWindowFx(windowGroupArray)
		case "WinRemover":removeWindowFx(windowGroupArray)
		case "WinSwitcher":nextWindowFx(windowGroupArray, currentWin)
		case "WinHider":showOrHideWindowsFx(windowGroupArray, fxShowHideToggle)
		case "AddAndHide":addAndHideWindowFx(windowGroupArray)

		;Send the hotkey that triggered this action.
		;Need to move modifiers outside the {} or else Send won't work :/
		Default:
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