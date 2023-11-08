;Hotkeys for MS To Do

#t::
if WinActive("Microsoft To Do") ;In the Tasks menu, add a task and mark it due today.
    createMSToDoTask(1, 0)
else if WinExist("Microsoft To Do")
    WinActivate
else
    Run, C:\Users\%A_UserName%\Documents\Microsoft To Do
return

#IfWinActive, Microsoft To Do

;In tasks menu, add a task and mark it due tomorrow.
!t::createMSToDoTask(1, 1)

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