;Stuff for FnKeys.ahk pertaining to creating custom groupings of windows for F1-12

;------------------------VARIABLES------------------------
windowGroupF1 := [] ;Stores window IDs
currentWinF1 := 1 ;Where in array are you
F1VisToggle := 0 ;Declare these as 1 so the first time you press Fx, it hides everything. If it's 1, hide windows; if it's 0, show windows.
windowGroupF2 := []
currentWinF2 := 1
F2VisToggle := 0 
windowGroupF3 := []
currentWinF3 := 1
F3VisToggle := 0 
windowGroupF4 := []
currentWinF4 := 1
F4VisToggle := 0 
windowGroupF5 := []
currentWinF5 := 1
F5VisToggle := 0 
windowGroupF6 := []
currentWinF6 := 1
F6VisToggle := 0 
windowGroupF7 := []
currentWinF7 := 1
F7VisToggle := 0 
windowGroupF8 := []
currentWinF8 := 1
F8VisToggle := 0 
windowGroupF9 := []
currentWinF9 := 1
F9VisToggle := 0 
windowGroupF10 := []
currentWinF10 := 1
F10VisToggle := 0 
windowGroupF11 := []
currentWinF11 := 1
F11VisToggle := 0 
windowGroupF12 := []
currentWinF12 := 1
F12VisToggle := 0

;------------------------FUNCTIONS------------------------
addWindowFx(ByRef windowGroupArray) {
    WinGet, currentID, ID, A ;Active window ID.
    for index, value in windowGroupArray ;If the current ID is already in the array, don't add it.
        if (currentID = value)
        return
    windowGroupArray.Push(currentID) ;If duplicate isn't found, add window ID to the array.
}

removeWindowFx(ByRef windowGroupArray) {
    WinGet, currentID, ID, A ;Active window ID.
    for index, value in windowGroupArray
        if (value == currentID)
        windowGroupArray.RemoveAt(index)
}

addAndHideWindowFx(ByRef windowGroupArray) {
    WinGet, activeWindowID, ID, A
    addWindowFx(windowGroupArray)
    WinHide, % "ahk_id" activeWindowID
}

showOrHideWindowsFx(ByRef windowGroupArray, ByRef fxShowHideToggle) {
    removeNonexistentWindows(windowGroupArray)

    ;If it's 1, hide windows; if it's 0, it shows windows.
    fxShowHideToggle := !fxShowHideToggle

    if (fxShowHideToggle = 1)
    {
        for index, value in windowGroupArray
        {
            WinShow, % "ahk_id " value
            WinActivate, % "ahk_id " value
        }
    }
    else {
        for index, value in windowGroupArray
            WinHide, % "ahk_id " value
        Send, !{Tab} ;Go back to the previous window. When hiding Fx windows, no other windows would be active, which was annoying. This fixes that.
    }
}

nextWindowFx(ByRef windowGroupArray, ByRef currentWin) {
    removeNonexistentWindows(windowGroupArray)
    
    WinGet, activeWindowID, ID, A

    ;Checks if there's 2 windows in the array. If so, acts like !Tab.
    if (windowGroupArray.MaxIndex() = 2)
    {
        if (activeWindowID != windowGroupArray[currentWin] AND inArray(activeWindowID, windowGroupArray))
        {
            WinActivate, % "ahk_id" windowGroupArray[currentWin]
            return
        }
    }

    ;If you switch to a different window that is not in the group, and you push the button to go to the next window, it'll take you back to the last window.
    ;This is what the R thing with AHK's built-in groups does.
    if (activeWindowID != windowGroupArray[currentWin] AND !inArray(activeWindowID, windowGroupArray))
    {
        WinActivate, % "ahk_id" windowGroupArray[currentWin]
        return
    }

    ;See this link for picture explanation: https://imgur.com/1Mc5B24
    if (activeWindowID = windowGroupArray[currentWin + 1])
        currentWin += 2 ;Skip the window that is already active.
    else
        currentWin++

    ;If the current window is greater than the number of entries in the array, then reset it to the lowest index.
    if (currentWin > windowGroupArray.MaxIndex())
        currentWin := windowGroupArray.MinIndex()
    WinActivate, % "ahk_id" windowGroupArray[currentWin] ;Now activate the window based on currentWin.
}

prevWindowFx(ByRef windowGroupArray, ByRef currentWin) {
    removeNonexistentWindows(windowGroupArray)

    ;Checks if there's 2 windows in the array. If so, acts like !Tab.
    if (windowGroupArray.MaxIndex() == 2)
    {
        if (activeWindowID != windowGroupArray[currentWin] AND inArray(activeWindowID, windowGroupArray)) {
            WinActivate, % "ahk_id" windowGroupArray[currentWin]
            return
        }
    }

    if (activeWindowID != windowGroupArray[currentWin] AND !inArray(activeWindowID, windowGroupArray))
    {
        WinActivate, % "ahk_id" windowGroupArray[currentWin]
        return
    }

    if (activeWindowID == windowGroupArray[currentWin - 1])
        currentWin -= 2 ;Skip the window that is already active.
    else
        currentWin--

    if (currentWin < windowGroupArray.MinIndex())
        currentWin := windowGroupArray.MaxIndex()
    WinActivate, % "ahk_id" windowGroupArray[currentWin] ;Now activate the window based on currentWin.
}

removeNonexistentWindows(ByRef windowGroupArray) {
    DetectHiddenWindows, On
    for index, value in windowGroupArray
        if !WinExist("ahk_id" value)
        windowGroupArray.RemoveAt(index)
    DetectHiddenWindows, Off
}

removeAllWins(Fx, ByRef windowGroupArray, ByRef currentWin) {
    FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\%Fx%.tmp ;Reset/overwrite file.
    windowGroupArray := [] ;Blank out the array. It's that simple.
    currentWin := 1
    Tippy("All windows in " . Fx . " Group have been removed.", 4000)
}

showWinTitlesFx(Fx, windowGroupArray, currentWin, fxShowHideToggle) {
    DetectHiddenWindows, On ;Needed for if windows are hidden (F8, etc.)

    if ((windowGroupArray.Length() == 0))
        message := "There are no windows in the " . Fx . " Group."
    else ;List all the windows.
    {
        for index, value in windowGroupArray
        {
            WinGetTitle, currentTitle, ahk_id %value%
            if (currentTitle == "") ;Skips windows that are in the array but that don't exist.
                continue
            message .= "Window #" . Index . " = " . currentTitle . "`n`n"
        }
    }

    MsgBox, 0, %Fx% Windows, currentWin%Fx% = %currentWin%`n`n%Fx%ShowHideToggle = %fxShowHideToggle%`n`n%message%
}

;Adds the 2 alt tab windows to an Fx group
altTabGroupAdd(ByRef windowGroupArray) {
    addWindowFx(windowGroupArray)
    Sleep 100
    Send, !{Tab}
    Sleep 100
    addWindowFx(windowGroupArray)
    Sleep 100
    Send, !{Tab}
}

;TODO
;Stores a group in a .tmp file for later use. calledOnExit is used for the Reload function so the user isn't bombarded with Tippys on every reload. 0 = false; 1 = true.
; writeGroupToFile(Fx, windowGroupArray, calledOnExit) {

;     if ((windowGroupArray.Length() == 0) AND (calledOnExit == 0)) {
;         MsgBox, 262160, Error, This array has no elements in it.
;         return
;     }

;     FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\%Fx% Group.tmp ;Reset/overwrite file.

;     for index, value in windowGroupArray ;Append values to the file.
;     {
;         valueToAppend := value . A_Space
;         FileAppend, %valueToAppend%, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\%Fx% Group.tmp
;     }

;     if (calledOnExit == 0)
;         Tippy("The " . Fx . " Group has been saved to disk.", 1000)
; }

;Retrieves that group from the file. Added calledOnStartup so when the script starts up and calls this 4 times, those Tippys aren't there every single time. Similar to calledOnExit; optional parameter as well.
readGroupFromFile(Fx, ByRef windowGroupArray, calledOnStartup := 1) {

    FileRead, groupFileContents, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\%Fx% Group.tmp
    windowGroupArray := StrSplit(groupFileContents, A_Space) ;Split up the file and store in the passed-in array. The delimiter is spaces because they're easiest to work with.
    groupFileContents := ;Free.

    if (calledOnStartup == 0)
        Tippy("The " . Fx . " Group has been restored from disk.", 1000)
}