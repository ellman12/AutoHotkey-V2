global PROMPT_WIDTH := 500
global PROMPT_HEIGHT := 300
global PROMPT_TITLE := "Enter a Command"
global promptVisible := 0
global prevCmds := []
global currentIndex := 0

Gui, Prompt:+AlwaysOnTop
Gui, Prompt:Color, Black
Gui, Prompt:Font, cWhite s12
Gui, Prompt:Margin, 10, 10

Gui, Prompt:Color,, Black
Gui, Prompt:Add, Text, y12, Enter Cmd:
editWidth := PROMPT_WIDTH - 100
Gui, Prompt:Add, Edit, x+5 yp+1 w%editWidth% -E0x200 ;Remove edit border: www.autohotkey.com/board/topic/71323-remove-type-specified-border-from-edit-control/?p=543956

gui, prompt:show, w500 h500 x1500 y900, %PROMPT_TITLE%
; toggleGUI(promptVisible, "Prompt", PROMPT_WIDTH, PROMPT_HEIGHT, PROMPT_TITLE)