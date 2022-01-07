;Edit text in Clipboard
global CE_DEFAULT_WIDTH := 650
global CE_DEFAULT_HEIGHT := 400
global CE_TITLE := "Clipboard Edit"

global ecWidth := CE_DEFAULT_WIDTH
global ecHeight := CE_DEFAULT_HEIGHT

global ecEditWidth := 640
global ecEditHeight := 355
global clipboardBoxText := Clipboard

Gui, CE:Font, s12
Gui, CE:Add, Button, gclipboardFinishButtonClick x4 y5 w80, &Finish
Gui, CE:Add, Button, gtrimBtnClick x+6 yp w80, &Trim
Gui, CE:Add, Button, gresetBtnClick x+6 yp w80, &Reset

Gui, CE:Font, s11
Gui, CE:Add, Edit, HScroll VScroll x4 y40 w%ecEditWidth% h%ecEditHeight% vclipboardBoxText gclipboardTextChanged, %Clipboard%

Gui, CE:+AlwaysOnTop
Gui, CE:+Resize
Gui, CE:Color, Silver

clipboardEditVis := 0