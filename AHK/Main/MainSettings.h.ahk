;Main initialization stuff
global MAIN_WIDTH := 392
global MAIN_HEIGHT := 314
global MAIN_TITLE := "Main Settings"
global mainVis := false

Gui, Main:Default
Gui, +AlwaysOnTop
Gui, Color, Black
Gui, Font, cWhite s11
Gui, Add, Button, gShowFx, Fx Settings

modes := "Double Click|Triple Click|FirefoxTabs|FirefoxWins|ChromeTabs|ChromeWins|RiderTabs|RiderWins|VSCodeTabs|VSCodeWins|VSTabs|VSWins|ExplorerWins"
Gui, Add, Text, xm y+13 w87, Front Top Btn
Gui, Font, cWhite s9
Gui, Add, DropDownList, x+10 yp-2 w150 vFrontTopMouseBtnBehavior, %modes%
Gui, Font, cWhite s11
Gui, Add, Text, xm y+13 w87, Back Top Btn
Gui, Font, cWhite s9
Gui, Add, DropDownList, x+10 yp-2 w150 vBackTopMouseBtnBehavior, %modes%

Gui, Font, s10
Gui, Add, Button, x6 y280 gMainOkClick, OK
Gui, Add, Button, x+10 y280 gMainCancelClick, Cancel
Gui, Add, Button, x+10 yp gMainApplyClick, Apply

; toggleGUI(mainVis, "Main", MAIN_WIDTH, MAIN_HEIGHT, MAIN_TITLE)