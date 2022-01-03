FAR_OK_click:
    Gui, FAR:Submit
    
    newStr := StrReplace(textToSearch, searchFor, replaceWith, numReplaced)
    Clipboard := newStr
    Tippy(numReplaced . " occurrences replaced", 1300)
    
    Gui, FAR:Destroy
return

FAR_Cancel_Click:
Gui, FAR:Destroy
return

#IfWinActive, Find and Replace
^Enter::Gosub, FAR_OK_click
#If