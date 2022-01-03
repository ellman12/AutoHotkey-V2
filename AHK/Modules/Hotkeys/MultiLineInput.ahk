Ralt::
newInput(MLI_TITLE, "Text to Search For", MLI_WIDTH, MLI_HEIGHT)
return

rctrl::destroyInput()

mliOK:
GuiControlGet, input,, MLIInput
Clipboard := input
return

mliCancel:

return