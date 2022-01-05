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

Gui, Tab, ^Fx
;------------------------^Fx------------------------
textWidth := 24

Gui, Add, Text, x17 y45 w%textWidth%, ^F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlF1Mode, %FN_OPTIONS%
Gui, Add, Text, x+20 yp+2 w%textWidth%, ^F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlF2Mode, %FN_OPTIONS%

i := 3
while (i < 13) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "^F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlF" . i . "Mode", %FN_OPTIONS%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "^F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlF" . i . "Mode", %FN_OPTIONS%
    i++
}

GuiControl, ChooseString, ctrlF1Mode, %ctrlF1Mode%
GuiControl, ChooseString, ctrlF2Mode, %ctrlF2Mode%
GuiControl, ChooseString, ctrlF3Mode, %ctrlF3Mode%
GuiControl, ChooseString, ctrlF4Mode, %ctrlF4Mode%
GuiControl, ChooseString, ctrlF5Mode, %ctrlF5Mode%
GuiControl, ChooseString, ctrlF6Mode, %ctrlF6Mode%
GuiControl, ChooseString, ctrlF7Mode, %ctrlF7Mode%
GuiControl, ChooseString, ctrlF8Mode, %ctrlF8Mode%
GuiControl, ChooseString, ctrlF9Mode, %ctrlF9Mode%
GuiControl, ChooseString, ctrlF10Mode, %ctrlF10Mode%
GuiControl, ChooseString, ctrlF11Mode, %ctrlF11Mode%
GuiControl, ChooseString, ctrlF12Mode, %ctrlF12Mode%

;Not in any tab group
Gui, Tab
Gui, Font, s10
Gui, Add, Button, x6 y280 gFxOkClick, Confirm
Gui, Add, Button, x+10 yp gFxApplyClick, Apply

Gui, Show, w%SETTINGS_WIDTH% h%SETTINGS_HEIGHT% x1800, %SETTINGS_TITLE%