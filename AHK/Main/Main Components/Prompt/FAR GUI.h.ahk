;Find and Replace
global textToSearch := ""
global searchFor := ""
global replaceWith := ""

runFAR() {
    Gui, FAR:New, +AlwaysOnTop, Find and Replace
    Gui, FAR:Margin, 4, 4

    Gui, FAR:Font, s14
    Gui, FAR:Add, Text,, Search In

    Gui, FAR:Font, s8
    Gui, FAR:Add, Edit, w250 h120 -VScroll vtextToSearch

    Gui, FAR:Font, s14
    Gui, FAR:Add, Text,, Search For

    Gui, FAR:Font, s8
    Gui, FAR:Add, Edit, w250 vsearchFor

    Gui, FAR:Font, s14
    Gui, FAR:Add, Text,, Replace With

    Gui, FAR:Font, s8
    Gui, FAR:Add, Edit, w250 vreplaceWith

    Gui, FAR:Font, s11
    Gui, FAR:Add, Button, gFAR_OK_click, OK
    Gui, FAR:Add, Button, gFAR_Cancel_Click x+m yp, Cancel
    
    Gui, FAR:Show, w258 h285
}