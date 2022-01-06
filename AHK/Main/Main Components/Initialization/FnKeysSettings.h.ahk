;Controlling Function keys at runtime
global FN_WIDTH := 392
global FN_HEIGHT := 314
global FN_TITLE := "Fx Settings"
global FN_OPTIONS := "NewFFWin|NewPrivFFWin|FirefoxTabs|FirefoxTabsReverse|FirefoxWins|NewChrWin|NewPrivChrWin|ChromeTabs|ChromeTabsReverse|ChromeWins|RiderTabs|RiderTabsReverse|RiderWins|VSCodeTabs|VSCodeTabsReverse|VSCodeWins|VSTabs|VSTabsReverse|VSWins|ExplorerWins|WinAdder|WinRemover|WinSwitcher|WinHider|AddAndHide|Default"

Gui, FnSettings:Default
Gui, +AlwaysOnTop
Gui, Color, Black

Gui, Font, cWhite s12
tabWidth := FN_WIDTH - 15
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

;------------------------^Fx------------------------
Gui, Tab, ^Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlF1Mode, %FN_OPTIONS%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlF2Mode, %FN_OPTIONS%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlF" . i . "Mode", %FN_OPTIONS%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlF" . i . "Mode", %FN_OPTIONS%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlF11Mode, %FN_OPTIONS%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlF12Mode, %FN_OPTIONS%

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

;------------------------+Fx------------------------
Gui, Tab, +Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vshiftF1Mode, %FN_OPTIONS%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vshiftF2Mode, %FN_OPTIONS%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vshiftF" . i . "Mode", %FN_OPTIONS%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vshiftF" . i . "Mode", %FN_OPTIONS%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vshiftF11Mode, %FN_OPTIONS%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vshiftF12Mode, %FN_OPTIONS%

GuiControl, ChooseString, shiftF1Mode, %shiftF1Mode%
GuiControl, ChooseString, shiftF2Mode, %shiftF2Mode%
GuiControl, ChooseString, shiftF3Mode, %shiftF3Mode%
GuiControl, ChooseString, shiftF4Mode, %shiftF4Mode%
GuiControl, ChooseString, shiftF5Mode, %shiftF5Mode%
GuiControl, ChooseString, shiftF6Mode, %shiftF6Mode%
GuiControl, ChooseString, shiftF7Mode, %shiftF7Mode%
GuiControl, ChooseString, shiftF8Mode, %shiftF8Mode%
GuiControl, ChooseString, shiftF9Mode, %shiftF9Mode%
GuiControl, ChooseString, shiftF10Mode, %shiftF10Mode%
GuiControl, ChooseString, shiftF11Mode, %shiftF11Mode%
GuiControl, ChooseString, shiftF12Mode, %shiftF12Mode%

;------------------------!Fx------------------------
Gui, Tab, !Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% valtF1Mode, %FN_OPTIONS%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% valtF2Mode, %FN_OPTIONS%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " valtF" . i . "Mode", %FN_OPTIONS%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " valtF" . i . "Mode", %FN_OPTIONS%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% valtF11Mode, %FN_OPTIONS%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% valtF12Mode, %FN_OPTIONS%

GuiControl, ChooseString, altF1Mode, %altF1Mode%
GuiControl, ChooseString, altF2Mode, %altF2Mode%
GuiControl, ChooseString, altF3Mode, %altF3Mode%
GuiControl, ChooseString, altF4Mode, %altF4Mode%
GuiControl, ChooseString, altF5Mode, %altF5Mode%
GuiControl, ChooseString, altF6Mode, %altF6Mode%
GuiControl, ChooseString, altF7Mode, %altF7Mode%
GuiControl, ChooseString, altF8Mode, %altF8Mode%
GuiControl, ChooseString, altF9Mode, %altF9Mode%
GuiControl, ChooseString, altF10Mode, %altF10Mode%
GuiControl, ChooseString, altF11Mode, %altF11Mode%
GuiControl, ChooseString, altF12Mode, %altF12Mode%

;------------------------#Fx------------------------
Gui, Tab, #Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vwinF1Mode, %FN_OPTIONS%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vwinF2Mode, %FN_OPTIONS%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vwinF" . i . "Mode", %FN_OPTIONS%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vwinF" . i . "Mode", %FN_OPTIONS%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vwinF11Mode, %FN_OPTIONS%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vwinF12Mode, %FN_OPTIONS%

GuiControl, ChooseString, winF1Mode, %winF1Mode%
GuiControl, ChooseString, winF2Mode, %winF2Mode%
GuiControl, ChooseString, winF3Mode, %winF3Mode%
GuiControl, ChooseString, winF4Mode, %winF4Mode%
GuiControl, ChooseString, winF5Mode, %winF5Mode%
GuiControl, ChooseString, winF6Mode, %winF6Mode%
GuiControl, ChooseString, winF7Mode, %winF7Mode%
GuiControl, ChooseString, winF8Mode, %winF8Mode%
GuiControl, ChooseString, winF9Mode, %winF9Mode%
GuiControl, ChooseString, winF10Mode, %winF10Mode%
GuiControl, ChooseString, winF11Mode, %winF11Mode%
GuiControl, ChooseString, winF12Mode, %winF12Mode%

;------------------------^!Fx------------------------
Gui, Tab, ^!Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlAltF1Mode, %FN_OPTIONS%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlAltF2Mode, %FN_OPTIONS%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlAltF" . i . "Mode", %FN_OPTIONS%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlAltF" . i . "Mode", %FN_OPTIONS%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlAltF11Mode, %FN_OPTIONS%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlAltF12Mode, %FN_OPTIONS%

GuiControl, ChooseString, ctrlAltF1Mode, %ctrlAltF1Mode%
GuiControl, ChooseString, ctrlAltF2Mode, %ctrlAltF2Mode%
GuiControl, ChooseString, ctrlAltF3Mode, %ctrlAltF3Mode%
GuiControl, ChooseString, ctrlAltF4Mode, %ctrlAltF4Mode%
GuiControl, ChooseString, ctrlAltF5Mode, %ctrlAltF5Mode%
GuiControl, ChooseString, ctrlAltF6Mode, %ctrlAltF6Mode%
GuiControl, ChooseString, ctrlAltF7Mode, %ctrlAltF7Mode%
GuiControl, ChooseString, ctrlAltF8Mode, %ctrlAltF8Mode%
GuiControl, ChooseString, ctrlAltF9Mode, %ctrlAltF9Mode%
GuiControl, ChooseString, ctrlAltF10Mode, %ctrlAltF10Mode%
GuiControl, ChooseString, ctrlAltF11Mode, %ctrlAltF11Mode%
GuiControl, ChooseString, ctrlAltF12Mode, %ctrlAltF12Mode%

;------------------------^+Fx------------------------
Gui, Tab, ^+Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlShiftF1Mode, %FN_OPTIONS%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlShiftF2Mode, %FN_OPTIONS%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlShiftF" . i . "Mode", %FN_OPTIONS%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlShiftF" . i . "Mode", %FN_OPTIONS%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlShiftF11Mode, %FN_OPTIONS%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlShiftF12Mode, %FN_OPTIONS%

GuiControl, ChooseString, ctrlShiftF1Mode, %ctrlShiftF1Mode%
GuiControl, ChooseString, ctrlShiftF2Mode, %ctrlShiftF2Mode%
GuiControl, ChooseString, ctrlShiftF3Mode, %ctrlShiftF3Mode%
GuiControl, ChooseString, ctrlShiftF4Mode, %ctrlShiftF4Mode%
GuiControl, ChooseString, ctrlShiftF5Mode, %ctrlShiftF5Mode%
GuiControl, ChooseString, ctrlShiftF6Mode, %ctrlShiftF6Mode%
GuiControl, ChooseString, ctrlShiftF7Mode, %ctrlShiftF7Mode%
GuiControl, ChooseString, ctrlShiftF8Mode, %ctrlShiftF8Mode%
GuiControl, ChooseString, ctrlShiftF9Mode, %ctrlShiftF9Mode%
GuiControl, ChooseString, ctrlShiftF10Mode, %ctrlShiftF10Mode%
GuiControl, ChooseString, ctrlShiftF11Mode, %ctrlShiftF11Mode%
GuiControl, ChooseString, ctrlShiftF12Mode, %ctrlShiftF12Mode%

;Not in any tab group
Gui, Tab
Gui, Font, s10
Gui, Add, Button, x6 y280 gFxOkClick, OK
Gui, Add, Button, x+10 y280 gFxCancelClick, Cancel
Gui, Add, Button, x+10 yp gFxApplyClick, Apply
Gui, Add, Button, x+10 yp gFxResetClick, Reset