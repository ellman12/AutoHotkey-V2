;Edit text in Clipboard
global EC_WIDTH := 650
global EC_HEIGHT := 400
global EC_TITLE := "Clipboard Edit"

global ecEditWidth := 640
global ecEditHeight := 355

Gui, CE:Font, s12
Gui, CE:Add, Button, gclipboardFinishButton x4 y2 w80,&Finish

Gui, CE:Font, s11
Gui, CE:Add, Edit, HScroll VScroll x4 y36 w%ecEditWidth% h%ecEditHeight% vclipboardBoxText gclipboardTextChanged, %Clipboard%

; Gui, CE:+AlwaysOnTop
Gui, CE:+Resize
Gui, CE:Color, Silver

clipboardEditVis := 0