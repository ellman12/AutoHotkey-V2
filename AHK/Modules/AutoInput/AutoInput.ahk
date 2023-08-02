!+a::
    AIEnabled := !AIEnabled
    GuiControl, AI:, AIEnabled, %AIEnabled%
    Gosub, AICheckClicked
return

!#+a::toggleGUI(autoInputVis, "AI", AI_WIDTH, AI_HEIGHT, AI_TITLE)

AICheckClicked:
    Gui, AI:Submit, NoHide

    if (AIEnabled)
    {
        Tippy("AI Enabled", 1000)
        SetTimer, AILoopTimer, On
    }
    else
    {
        Tippy("AI Disabled", 1000)
        SetTimer, AILoopTimer, Off
    }
return

AILoopTimer:
    Send, %AIHotkey%
    Random, delay, % -delayRandomness, delayRandomness
    delay += AIDelay
    delay := Abs(delay)
    Sleep, %delay%
return