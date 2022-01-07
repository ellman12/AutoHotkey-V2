#c::
GuiControl, CE:,clipboardBoxText, %Clipboard%
GuiControl, CE:Focus, clipboardBoxText
toggleGUI(clipboardEditVis, "CE", ecWidth, ecHeight, EC_TITLE)
return

clipboardFinishButton:
Gui, CE:Submit
Clipboard := clipboardBoxText
clipboardEditVis := !clipboardEditVis
return

trimBtnClick:
clipboardBoxText := Trim(clipboardBoxText)
clipboardBoxText := StrReplace(clipboardBoxText, "`r")
clipboardBoxText := StrReplace(clipboardBoxText, "`n")
GuiControl, CE:, clipboardBoxText, %clipboardBoxText%
return

clipboardTextChanged:
Gui, CE:Submit, NoHide
return

CEGuiClose:
Gui, CE:Submit, NoHide
GuiControl, CE:Focus, clipboardBoxText
Gui, CE:Hide
clipboardEditVis := !clipboardEditVis
return

CEGuiSize:
ecWidth := A_GuiWidth
ecHeight := A_GuiHeight
ceEditWidth := ecWidth - 10
ceEditHeight := ecHeight - 47
GuiControl, CE:Move, clipboardBoxText, % "x4 y40 w" ceEditWidth "h" ceEditHeight
return