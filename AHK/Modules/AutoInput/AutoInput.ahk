!a::
    AIEnabled := !AIEnabled
    GuiControl, AI:, AIEnabled, %AIEnabled%
    Gosub, AICheckClicked
return

!+a::toggleGUI(autoInputVis, "AI", AI_WIDTH, AI_HEIGHT, AI_TITLE)

AICheckClicked:
    Gui, AI:Submit, NoHide

    if (AIEnabled)
        SetTimer, AILoopTimer, %AIDelay%
    else
        SetTimer, AILoopTimer, Off
return

AILoopTimer:
    Send, %AIHotkey%
    Sleep, %AIDelay%
return