;Hotkeys for MS To Do
;Open MS To Do
#t::
Sleep 200
if WinActive("Microsoft To Do") { ;In the Tasks menu, add a task and mark it due today.
    createMSToDoTask(1, 0)
} else if WinExist("Microsoft To Do") ;Activate it.
    WinActivate
else {
    Run, C:\Users\%A_UserName%\Documents\Microsoft To Do ;Shortcut in Documents.
}
return

#IfWinActive, Microsoft To Do
;In tasks menu, add a task and mark it due tomorrow.
!#t::createMSToDoTask(1, 1)
#If

createMSToDoTask(numberOfTabs, numberOfDowns) {
    Sleep 250
    Send, {Tab %numberOfTabs%}
    Sleep 230
    Send, {Space}
    Sleep 230
    Send, {Down %numberOfDowns%}
    Sleep 230
    Send, {Space}
    Sleep 230
    Send, +{Tab %numberOfTabs%}{Enter}
}