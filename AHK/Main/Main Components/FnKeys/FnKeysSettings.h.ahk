;Controlling Function keys at runtime
global FN_WIDTH := 392
global FN_HEIGHT := 314
global FN_TITLE := "Fx Settings"
global FN_MODES := "Alt Tab|NewFFWin|NewPrivFFWin|FirefoxTabs|FirefoxTabsReverse|FirefoxWins|NewChrWin|NewPrivChrWin|ChromeTabs|ChromeTabsReverse|ChromeWins|RiderTabs|RiderTabsReverse|RiderWins|VSCodeTabs|VSCodeTabsReverse|VSCodeWins|VSTabs|VSTabsReverse|VSWins|ExplorerWins|WinAdder|WinRemover|WinSwitcher|WinHider|AddAndHide|Default"

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
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vF1Mode, %FN_MODES%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vF2Mode, %FN_MODES%

i := 3
while (i < 13) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vF" . i . "Mode", %FN_MODES%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vF" . i . "Mode", %FN_MODES%
    i++
}

;------------------------^Fx------------------------
Gui, Tab, ^Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlF1Mode, %FN_MODES%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlF2Mode, %FN_MODES%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlF" . i . "Mode", %FN_MODES%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlF" . i . "Mode", %FN_MODES%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlF11Mode, %FN_MODES%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlF12Mode, %FN_MODES%

;------------------------+Fx------------------------
Gui, Tab, +Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vshiftF1Mode, %FN_MODES%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vshiftF2Mode, %FN_MODES%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vshiftF" . i . "Mode", %FN_MODES%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vshiftF" . i . "Mode", %FN_MODES%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vshiftF11Mode, %FN_MODES%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vshiftF12Mode, %FN_MODES%

;------------------------!Fx------------------------
Gui, Tab, !Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% valtF1Mode, %FN_MODES%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% valtF2Mode, %FN_MODES%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " valtF" . i . "Mode", %FN_MODES%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " valtF" . i . "Mode", %FN_MODES%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% valtF11Mode, %FN_MODES%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% valtF12Mode, %FN_MODES%

;------------------------#Fx------------------------
Gui, Tab, #Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vwinF1Mode, %FN_MODES%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vwinF2Mode, %FN_MODES%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vwinF" . i . "Mode", %FN_MODES%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vwinF" . i . "Mode", %FN_MODES%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vwinF11Mode, %FN_MODES%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vwinF12Mode, %FN_MODES%

;------------------------^!Fx------------------------
Gui, Tab, ^!Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlAltF1Mode, %FN_MODES%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlAltF2Mode, %FN_MODES%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlAltF" . i . "Mode", %FN_MODES%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlAltF" . i . "Mode", %FN_MODES%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlAltF11Mode, %FN_MODES%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlAltF12Mode, %FN_MODES%

;------------------------^+Fx------------------------
Gui, Tab, ^+Fx
Gui, Add, Text, x17 y45 w%textWidth%, F1
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlShiftF1Mode, %FN_MODES%
Gui, Add, Text, x+20 yp+2 w%textWidth%, F2
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlShiftF2Mode, %FN_MODES%

i := 3
while (i < 11) {
    Gui, Add, Text, x17 y+20 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlShiftF" . i . "Mode", %FN_MODES%    
    i++
    
    Gui, Add, Text, x+20 yp+2 w%textWidth%, % "F" . i
    Gui, Add, DropDownList, % "x+8 yp-2 w" ddlWidth " vctrlShiftF" . i . "Mode", %FN_MODES%
    i++
}
Gui, Add, Text, x17 y+20 w%textWidth%, F11
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlShiftF11Mode, %FN_MODES%    

Gui, Add, Text, x+20 yp+2 w%textWidth%, F12
Gui, Add, DropDownList, x+8 yp-2 w%ddlWidth% vctrlShiftF12Mode, %FN_MODES%

;Not in any tab group
Gui, Tab
Gui, Font, s10
Gui, Add, Button, x6 y280 gFxOkClick, OK
Gui, Add, Button, x+10 y280 gFnCancelClick, Cancel
Gui, Add, Button, x+10 yp gFxApplyClick, Apply
Gui, Add, Button, x+10 yp gFxResetClick, Reset