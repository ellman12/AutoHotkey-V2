;Main initialization stuff
global MAIN_WIDTH := 392
global MAIN_HEIGHT := 314
global MAIN_TITLE := "Settings"
global mainVis := false

Gui, Main:Default
Gui, +AlwaysOnTop
Gui, Color, Black
Gui, Font, cWhite s10
Gui, Add, Button, gShowFx, Fx Settings