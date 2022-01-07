;Edit text in Clipboard
global CE_DEFAULT_WIDTH := 650
global CE_DEFAULT_HEIGHT := 400
global CE_TITLE := "Clipboard Edit"

global ceWidth := CE_DEFAULT_WIDTH
global ceHeight := CE_DEFAULT_HEIGHT

global ceEditWidth := 640
global ceEditHeight := 355
global clipboardBoxText := Clipboard

Gui, CE:Font, s12
Gui, CE:Add, Button, gclipboardFinishButtonClick x4 y5 w80, &Finish
Gui, CE:Add, Button, gtrimBtnClick x+6 yp w80, &Trim
Gui, CE:Add, Button, gresetBtnClick x+6 yp w80, &Reset

Gui, CE:Font, s11
Gui, CE:Add, Edit, HScroll VScroll x4 y40 w%ceEditWidth% h%ceEditHeight% vclipboardBoxText gclipboardTextChanged, %Clipboard%

Gui, CE:+AlwaysOnTop
Gui, CE:+Resize
Gui, CE:Color, Silver

clipboardEditVis := 0