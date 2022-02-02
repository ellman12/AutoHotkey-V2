;Simple script that accepts 2-3 command line arguments to do Find and Replace stuff on text.
;Arguments:
;1: text to search in. Specify "Clipboard" to search Clipboard.
;2: text to search for.
;3: text to replace with (optional; defaults to just removing chars).
;Surround text with quotes if there are spaces.
#Include, %A_ScriptDir%/../../Functions/Tippy.ahk

if (A_Args.Length() < 2 OR A_Args.Length() > 3)
{
    MsgBox % "FAR requires 2 or 3 parameters but it received " A_Args.Length() "."
    ExitApp
}

textToSearch := A_Args[1] == "Clipboard" ? Clipboard : A_Args[1]

Clipboard := StrReplace(textToSearch, A_Args[2], A_Args[3], numReplaced)
Tippy(numReplaced . " occurrences replaced", 1300)