;AutoInput: Allows you to automatically input a specified (hot)key repeatedly.
global AI_WIDTH := 220
global AI_HEIGHT := 110
global AI_TITLE := "AutoInput"

global AIHotkey := "!{Tab}"
global AIDelay := 30000
global delayRandomness := 5000
global AIEnabled := false
global autoInputVis := 0

Gui, AI:Font, s11
Gui, AI:-Resize
Gui, AI:Color, Silver
Gui, AI:Margin, 4, 4

Gui, AI:Add, Text, xm ym+2, Hotkey
Gui, AI:Add, Edit, vAIHotkey r1 w70 x52 yp-2, !{Tab}
Gui, AI:Add, Text, xm y+5, Delay
Gui, AI:Add, Edit, vAIDelay r1 w70 x52 yp-2, 3000
Gui, AI:Add, Text, xm y+5, Delta
Gui, AI:Add, Edit, vdelayRandomness r1 w70 x52 yp-2, 5000
Gui, AI:Add, CheckBox, xm vAIEnabled gAICheckClicked, Enabled