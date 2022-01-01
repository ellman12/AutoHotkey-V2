global PROMPT_WIDTH := 350
global PROMPT_HEIGHT := 60
global PROMPT_TITLE := "Enter a Command"
global promptVisible := 0
global prevCmds := []
global currentIndex := 0

Gui, Prompt:+AlwaysOnTop
Gui, Prompt:Color, Black
Gui, Prompt:Font, cWhite s12
Gui, Prompt:Margin, 10, 10

Gui, Prompt:Color,, Black
Gui, Prompt:Add, Text, y12, Enter Command:
editWidth := PROMPT_WIDTH - 100
Gui, Prompt:Add, Edit, x+5 yp vcurrentCmd gCmdOnInput -E0x200 ;Remove edit border: www.autohotkey.com/board/topic/71323-remove-type-specified-border-from-edit-control/?p=543956

;TODO
togglePrompt()

togglePrompt() {
    toggleGUI(promptVisible, "Prompt", PROMPT_WIDTH, PROMPT_HEIGHT, PROMPT_TITLE)
}