enabled := true
timing := true
startTime := A_TickCount
elapsedTime := 0
loopAmt := 0

ToolTip, Running

FormatTime, date,, yyyy-M-d

filePath := A_MyDocuments . "\Stats\"
FileCreateDir, %filePath%
filePath := filePath . date . ".txt"

Loop {
    if (!enabled)
    {
        Sleep 700
        continue
    }
    
    randomMouseMove(300, 2400, 150, 1000)
    Sleep 4000
    
    loopAmt++
}

#s::
if (enabled)
{
    ToolTip
    elapsedTime += A_TickCount - startTime
    FileDelete, %filePath%
    FileAppend, %loopAmt%`r`n%elapsedTime%, %filePath%
}
else
{
    ToolTip, Running
    startTime := A_TickCount
}
enabled := !enabled
return

randomMouseMove(xMin, xMax, yMin, yMax)
{
    Random, newMouseX, xMin, xMax
    Random, newMouseY, yMin, yMax
    MouseMove, newMouseX, newMouseY, 5
}