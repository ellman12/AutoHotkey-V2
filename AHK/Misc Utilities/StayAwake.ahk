enabled := true
timing := true
startTime := A_TickCount
elapsedTime := 0
loopAmt := 0

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
    
    MouseMove, 50, 0, 0, R
    Sleep 3000
    MouseMove, -50, 0, 0, R
    Sleep 3000
    
    loopAmt++
}

#s::
if (enabled)
{
    elapsedTime += A_TickCount - startTime
    FileDelete, %filePath%
    FileAppend, %loopAmt%`r`n%elapsedTime%, %filePath%
}
else
{
    startTime := A_TickCount
}
enabled := !enabled
return