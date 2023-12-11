^!1::WinGet, window1, ID, A
^!2::WinGet, window2, ID, A

!a::
if (WorkComputer) {
	WinGet, window1, ID, ahk_exe webstorm64.exe
	WinGet, window2, ID, ahk_exe gitkraken.exe
}

if (window1 == "" || !WinExist("ahk_id" window1)) {
    MsgBox, Window 1 does not exist
    return
}

if (window2 == "" || !WinExist("ahk_id" window2)) {
    MsgBox, Window 2 does not exist
    return
}

if (window1 == window2) {
    MsgBox, Window 1 and 2 are the same ID
    return
}

AATEnabled := !AATEnabled

if (AATEnabled) {
    ToolTip, AAT On
    SetTimer, AutoAltTabLoop, On
} else {
    ToolTip
    SetTimer, AutoAltTabLoop, Off
    SetTimer, AutoAltTabLoop, Delete
}

return

AutoAltTabLoop:
    if (!AATEnabled)
        return
    
    WinActivate, ahk_id %window1%
    Sleep % getRandomDelay()
    
    if (!AATEnabled)
        return
    
    WinActivate, ahk_id %window2%
    Sleep % getRandomDelay()
    
    if (!AATEnabled)
        return
    
    Send, !{Tab}
    Sleep % getRandomDelay()
    
    if (!AATEnabled)
        return
    
    Send, !{Tab}
    Sleep % getRandomDelay()
return

getRandomDelay() {
    Random, randomDelay, % -AAT_DELAY_RANDOMNESS, AAT_DELAY_RANDOMNESS
    delay := AAT_DELAY + randomDelay
    return Abs(delay)
}