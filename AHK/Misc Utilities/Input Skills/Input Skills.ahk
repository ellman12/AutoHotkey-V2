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

    Clipboard := v
    Send, ^v
    Sleep 1000
    Send, {Enter 2}
    Sleep 1000
    ; Send, {Enter}
    ; Sleep 2000
    ; Send, +{Tab}
    ; Sleep 2000
    ; Send, {Tab}
    ; Sleep 2000
}
return

!+Enter::ExitApp
^!Enter::Reload