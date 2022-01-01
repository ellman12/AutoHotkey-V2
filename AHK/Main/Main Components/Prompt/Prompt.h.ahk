global PROMPT_WIDTH := 350
global PROMPT_HEIGHT := 30
global PROMPT_TITLE := "Enter a Command"
global promptVisible := 0
global prevCmds := []
global currentIndex := 0

Gui, Prompt:+AlwaysOnTop
Gui, Prompt:Color, Black
Gui, Prompt:Font, cWhite s12
Gui, Prompt:Margin, 10, 10

Gui, Prompt:Color,, Black
editWidth := PROMPT_WIDTH - 10
Gui, Prompt:Add, Edit, x5 y5 w%editWidth% vcurrentCmd gCmdOnInput -E0x200 ;Remove edit border: www.autohotkey.com/board/topic/71323-remove-type-specified-border-from-edit-control/?p=543956

;TODO
togglePrompt()

togglePrompt() {
    toggleGUI(promptVisible, "Prompt", PROMPT_WIDTH, PROMPT_HEIGHT, PROMPT_TITLE)
}

runCommand(cmd) {
    switch (cmd) {
        case "test":Tippy("hi", 1000)
        case "":Tippy("Blank command", 1000)
        Default:Tippy("Unknown command", 2000)
    }
}