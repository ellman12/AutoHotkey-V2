global PROMPT_WIDTH := 500
global PROMPT_HEIGHT := 500
global promptVisible := 0
global prevCmds := []
global currentIndex := 0

Gui, Prompt:+AlwaysOnTop
Gui, Prompt:
Gui, Prompt:
Gui, Prompt:
Gui, Prompt:
Gui, Prompt:
Gui, Prompt:
toggleGUI(promptVisible, "Prompt", PROMPT_WIDTH, PROMPT_HEIGHT)