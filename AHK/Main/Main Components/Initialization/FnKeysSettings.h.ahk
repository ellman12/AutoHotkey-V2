;Main initialization stuff
global SETTINGS_WIDTH := 420
global SETTINGS_HEIGHT := 330
global SETTINGS_TITLE := "Fx Settings"
global FN_OPTIONS := "NewFFWin|NewPrivFFWin|FirefoxTabs|FirefoxTabsReverse|FirefoxWins|NewChrWin|NewPrivChrWin|ChromeTabs|ChromeTabsReverse|ChromeWins|RiderTabs|RiderTabsReverse|RiderWins|VSCodeTabs|VSCodeTabsReverse|VSCodeWins|VSTabs|VSTabsReverse|VSWins|ExplorerWins|WinAdder|WinRemover|WinSwitcher|WinHider|AddAndHide|Default"

Gui, FnSettings:Default
Gui, +AlwaysOnTop
Gui, Color, Black

Gui, Font, cWhite s12
tabWidth := SETTINGS_WIDTH - 15
Gui, Add, Tab3, x6 h260 w%tabWidth%, Fx|^Fx|+Fx|!Fx|#Fx|^!Fx|^+Fx
Gui, Font, cWhite s9
;-------------------------Fx------------------------
textWidth := 20
ddlWidth := 140

Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vF1Mode, %FN_OPTIONS%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vF2Mode, %FN_OPTIONS%

i := 3
while (i < 13) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vF" . i . "Mode", %FN_OPTIONS%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vF" . i . "Mode", %FN_OPTIONS%
    i++
}

GuiControl, ChooseString, F1Mode, %F1Mode%
GuiControl, ChooseString, F2Mode, %F2Mode%
GuiControl, ChooseString, F3Mode, %F3Mode%
GuiControl, ChooseString, F4Mode, %F4Mode%
GuiControl, ChooseString, F5Mode, %F5Mode%
GuiControl, ChooseString, F6Mode, %F6Mode%
GuiControl, ChooseString, F7Mode, %F7Mode%
GuiControl, ChooseString, F8Mode, %F8Mode%
GuiControl, ChooseString, F9Mode, %F9Mode%
GuiControl, ChooseString, F10Mode, %F10Mode%
GuiControl, ChooseString, F11Mode, %F11Mode%
GuiControl, ChooseString, F12Mode, %F12Mode%

Gui, Tab ;End this section of the Tab
Gui, Add, Button, x17 y280 gFxOkClick, hi
; Gui, Add, Button, x117 y280 gFxCancelClick, hi

Gui, Show, w%SETTINGS_WIDTH% h%SETTINGS_HEIGHT% x1800, %SETTINGS_TITLE%