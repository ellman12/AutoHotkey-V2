;Automates entering a list of skills into a job application website.
;Enter skills in a file named "input.txt". Enter 1 skill per line and have them separated by newlines.
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

FileRead, input, % A_ScriptDir . "/input.txt"
input := StrReplace(input, "`r")
input := StrSplit(input, "`n")

!Enter::
for k, v in input
{
    if (v == "") ;Skip blank lines
        continue

    SendRaw, %v%
    Send, {Enter}
    Sleep 5000
}
return