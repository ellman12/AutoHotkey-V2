#c::
GuiControl, CE:,clipboardBoxText, %Clipboard%
GuiControl, CE:Focus, clipboardBoxText
toggleGUI(clipboardEditVis, "CE", EC_WIDTH, EC_HEIGHT, EC_TITLE)
return

CEGuiClose:
Gui, CE:Submit, NoHide
GuiControl, CE:Focus, clipboardBoxText
Gui, CE:Hide
clipboardEditVis := !clipboardEditVis
return

clipboardTextChanged: ;This was from MSR. IDK if it's actually needed. *shrug*
Gui, CE:Submit, NoHide
return

CEGuiSize:
ceEditWidth := A_GuiWidth - 10
ceEditHeight := A_GuiHeight - 45
GuiControl, CE:Move, clipboardBoxText, % "x4 y36 w" ceEditWidth "h" ceEditHeight
return

clipboardFinishButton:
Gui, CE:Submit
Clipboard := clipboardBoxText
clipboardEditVis := !clipboardEditVis
return