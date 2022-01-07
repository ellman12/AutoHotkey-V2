;Normally, a window can only be dragged by clicking on its title bar.
;This extends that so that any point inside a window can be dragged.
;EWD is short for Easy Window Dragging.
;Where I found this: https://www.autohotkey.com/docs/scripts/#EasyWindowDrag
~LButton & RButton::
    CoordMode, Mouse ;Switch to screen/absolute coordinates.
    MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
    WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
    WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin%
    if EWD_WinState = 0 ;Only if the window isn't maximized
        SetTimer, EWD_WatchMouse, 10 ;Track the mouse as the user drags it.
return

EWD_WatchMouse:
    GetKeyState, EWD_LButtonState, LButton, P
    if EWD_LButtonState = U ;Button has been released, so drag is complete.
    {
        SetTimer, EWD_WatchMouse, Off
        return
    }
    GetKeyState, EWD_EscapeState, Escape, P
    if EWD_EscapeState = D ;Escape has been pressed, so drag is cancelled.
    {
        SetTimer, EWD_WatchMouse, Off
        WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
        return
    }
    ;Otherwise, reposition the window to match the change in mouse coordinates
    ;caused by the user having dragged the mouse:
    CoordMode, Mouse
    MouseGetPos, EWD_MouseX, EWD_MouseY
    WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
    SetWinDelay, -1 ;Makes the below move faster/smoother.
    WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
    EWD_MouseStartX := EWD_MouseX ;Update for the next timer-call to this subroutine.
    EWD_MouseStartY := EWD_MouseY
return