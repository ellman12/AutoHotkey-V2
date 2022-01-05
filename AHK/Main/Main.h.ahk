;Main initialization stuff
global MAIN_WIDTH := 392
global MAIN_HEIGHT := 314
global MAIN_TITLE := "Settings"

Gui, Main:Default
Gui, +AlwaysOnTop
Gui, Color, Black
Gui, Font, cWhite s12
Gui, Add, Text,, Hello

; Gui, Show, w%MAIN_WIDTH% h%MAIN_HEIGHT% x1800, %MAIN_TITLE%