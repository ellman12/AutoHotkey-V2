#c::
GuiControl, CE:,clipboardBoxText, %Clipboard%
GuiControl, CE:Focus, clipboardBoxText
toggleGUI(clipboardEditVis, "CE", ceWidth, ceHeight, CE_TITLE)
return

clipboardFinishButtonClick:
Gui, CE:Submit
Clipboard := clipboardBoxText
clipboardEditVis := !clipboardEditVis
return

trimBtnClick:
Gui, CE:Submit, NoHide
clipboardBoxText := Trim(clipboardBoxText)
clipboardBoxText := StrReplace(clipboardBoxText, "`r")
clipboardBoxText := StrReplace(clipboardBoxText, "`n")
GuiControl, CE:, clipboardBoxText, %clipboardBoxText%
return

resetBtnClick:
ceWidth := CE_DEFAULT_WIDTH
ceHeight := CE_DEFAULT_HEIGHT
Gui, CE:Show, xCenter yCenter w%ceWidth% h%ceHeight%, %CE_TITLE%
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
ceWidth := A_GuiWidth
ceHeight := A_GuiHeight
ceEditWidth := ceWidth - 10
ceEditHeight := ceHeight - 47
GuiControl, CE:Move, clipboardBoxText, % "x4 y40 w" ceEditWidth "h" ceEditHeight
return