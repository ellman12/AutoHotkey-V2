global PROMPT_WIDTH := 500
global PROMPT_HEIGHT := 500
global promptVisible := 1
global prevCmds := []
global currentIndex := 0

MsgBox, [ Options, Title, Text, Timeout]
Gui, Prompt:+AlwaysOnTop
; Gui, Prompt:
; Gui, Prompt:
; Gui, Prompt:
; Gui, Prompt:
; Gui, Prompt:
; Gui, Prompt:
 GUI, Prompt:Show, w%PROMPT_WIDTH% h%PROMPT_HEIGHT%, "hi"
; toggleGUI(promptVisible, "Prompt", PROMPT_WIDTH, PROMPT_HEIGHT, "Enter a Command")