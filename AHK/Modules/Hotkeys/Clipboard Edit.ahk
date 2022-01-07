#c::
GuiControl, CE:,clipboardBoxText, %Clipboard%
GuiControl, CE:Focus, clipboardBoxText
toggleGUI(clipboardEditVis, "CE", EC_WIDTH, EC_HEIGHT, EC_TITLE)
return

CEGuiClose:
GUI, CE:Submit, NoHide
GuiControl, CE:Focus, clipboardBoxText
GUI, CE:Hide
clipboardEditVis := !clipboardEditVis
return

CEGuiSize:
ceEditWidth := A_GuiWidth - 10
ceEditHeight := A_GuiHeight - 45
GuiControl, CE:Move, clipboardBoxText, % "x4 y36 w" ceEditWidth "h" ceEditHeight
return

clipboardFinishButton:
GUI, CE:Submit
Clipboard := clipboardBoxText
clipboardEditVis := !clipboardEditVis
return