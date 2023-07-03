;AutoInput: Allows you to automatically input a specified (hot)key repeatedly.
global AI_WIDTH := 220
global AI_HEIGHT := 80
global AI_TITLE := "AutoInput"

global AIHotkey := "!{Tab}"
global AIDelay := 30000
global AIEnabled := false
global autoInputVis := 0

Gui, AI:Font, s11
Gui, AI:-Resize
Gui, AI:Color, Silver
Gui, AI:Margin, 4, 4

Gui, AI:Add, Edit, vAIHotkey r1 w70, !{Tab}
Gui, AI:Add, Edit, vAIDelay r1 w70, 30000
Gui, AI:Add, CheckBox, vAIEnabled gAICheckClicked, Enabled