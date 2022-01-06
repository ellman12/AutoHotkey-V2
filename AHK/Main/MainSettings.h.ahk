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
Gui, Add, Button, x+10 yp gMainResetClick, Reset

; toggleGUI(mainVis, "Main", MAIN_WIDTH, MAIN_HEIGHT, MAIN_TITLE)

deleteConfigFile() {
    FileDelete, %CONFIG_PATH%
}

resetMainSettings() {
    deleteConfigFile()
    readConfigFile()
    setMainGUIValues()
    writeConfigFile()
}

writeConfigFile() { ;Writes #o values to the config file.
global
    section := "FnKeys"
    IniWrite, %F1Mode%, %CONFIG_PATH%, %section%, F1Mode
    IniWrite, %F2Mode%, %CONFIG_PATH%, %section%, F2Mode
    IniWrite, %F3Mode%, %CONFIG_PATH%, %section%, F3Mode
    IniWrite, %F4Mode%, %CONFIG_PATH%, %section%, F4Mode
    IniWrite, %F5Mode%, %CONFIG_PATH%, %section%, F5Mode
    IniWrite, %F6Mode%, %CONFIG_PATH%, %section%, F6Mode
    IniWrite, %F7Mode%, %CONFIG_PATH%, %section%, F7Mode
    IniWrite, %F8Mode%, %CONFIG_PATH%, %section%, F8Mode
    IniWrite, %F9Mode%, %CONFIG_PATH%, %section%, F9Mode
    IniWrite, %F10Mode%, %CONFIG_PATH%, %section%, F10Mode
    IniWrite, %F11Mode%, %CONFIG_PATH%, %section%, F11Mode
    IniWrite, %F12Mode%, %CONFIG_PATH%, %section%, F12Mode

    IniWrite, %ctrlF1Mode%, %CONFIG_PATH%, %section%, ctrlF1Mode
    IniWrite, %ctrlF2Mode%, %CONFIG_PATH%, %section%, ctrlF2Mode
    IniWrite, %ctrlF3Mode%, %CONFIG_PATH%, %section%, ctrlF3Mode
    IniWrite, %ctrlF4Mode%, %CONFIG_PATH%, %section%, ctrlF4Mode
    IniWrite, %ctrlF5Mode%, %CONFIG_PATH%, %section%, ctrlF5Mode
    IniWrite, %ctrlF6Mode%, %CONFIG_PATH%, %section%, ctrlF6Mode
    IniWrite, %ctrlF7Mode%, %CONFIG_PATH%, %section%, ctrlF7Mode
    IniWrite, %ctrlF8Mode%, %CONFIG_PATH%, %section%, ctrlF8Mode
    IniWrite, %ctrlF9Mode%, %CONFIG_PATH%, %section%, ctrlF9Mode
    IniWrite, %ctrlF10Mode%, %CONFIG_PATH%, %section%, ctrlF10Mode
    IniWrite, %ctrlF11Mode%, %CONFIG_PATH%, %section%, ctrlF11Mode
    IniWrite, %ctrlF12Mode%, %CONFIG_PATH%, %section%, ctrlF12Mode

    IniWrite, %shiftF1Mode%, %CONFIG_PATH%, %section%, shiftF1Mode
    IniWrite, %shiftF2Mode%, %CONFIG_PATH%, %section%, shiftF2Mode
    IniWrite, %shiftF3Mode%, %CONFIG_PATH%, %section%, shiftF3Mode
    IniWrite, %shiftF4Mode%, %CONFIG_PATH%, %section%, shiftF4Mode
    IniWrite, %shiftF5Mode%, %CONFIG_PATH%, %section%, shiftF5Mode
    IniWrite, %shiftF6Mode%, %CONFIG_PATH%, %section%, shiftF6Mode
    IniWrite, %shiftF7Mode%, %CONFIG_PATH%, %section%, shiftF7Mode
    IniWrite, %shiftF8Mode%, %CONFIG_PATH%, %section%, shiftF8Mode
    IniWrite, %shiftF9Mode%, %CONFIG_PATH%, %section%, shiftF9Mode
    IniWrite, %shiftF10Mode%, %CONFIG_PATH%, %section%, shiftF10Mode
    IniWrite, %shiftF11Mode%, %CONFIG_PATH%, %section%, shiftF11Mode
    IniWrite, %shiftF12Mode%, %CONFIG_PATH%, %section%, shiftF12Mode

    IniWrite, %altF1Mode%, %CONFIG_PATH%, %section%, altF1Mode
    IniWrite, %altF2Mode%, %CONFIG_PATH%, %section%, altF2Mode
    IniWrite, %altF3Mode%, %CONFIG_PATH%, %section%, altF3Mode
    IniWrite, %altF4Mode%, %CONFIG_PATH%, %section%, altF4Mode
    IniWrite, %altF5Mode%, %CONFIG_PATH%, %section%, altF5Mode
    IniWrite, %altF6Mode%, %CONFIG_PATH%, %section%, altF6Mode
    IniWrite, %altF7Mode%, %CONFIG_PATH%, %section%, altF7Mode
    IniWrite, %altF8Mode%, %CONFIG_PATH%, %section%, altF8Mode
    IniWrite, %altF9Mode%, %CONFIG_PATH%, %section%, altF9Mode
    IniWrite, %altF10Mode%, %CONFIG_PATH%, %section%, altF10Mode
    IniWrite, %altF11Mode%, %CONFIG_PATH%, %section%, altF11Mode
    IniWrite, %altF12Mode%, %CONFIG_PATH%, %section%, altF12Mode

    IniWrite, %winF1Mode%, %CONFIG_PATH%, %section%, winF1Mode
    IniWrite, %winF2Mode%, %CONFIG_PATH%, %section%, winF2Mode
    IniWrite, %winF3Mode%, %CONFIG_PATH%, %section%, winF3Mode
    IniWrite, %winF4Mode%, %CONFIG_PATH%, %section%, winF4Mode
    IniWrite, %winF5Mode%, %CONFIG_PATH%, %section%, winF5Mode
    IniWrite, %winF6Mode%, %CONFIG_PATH%, %section%, winF6Mode
    IniWrite, %winF7Mode%, %CONFIG_PATH%, %section%, winF7Mode
    IniWrite, %winF8Mode%, %CONFIG_PATH%, %section%, winF8Mode
    IniWrite, %winF9Mode%, %CONFIG_PATH%, %section%, winF9Mode
    IniWrite, %winF10Mode%, %CONFIG_PATH%, %section%, winF10Mode
    IniWrite, %winF11Mode%, %CONFIG_PATH%, %section%, winF11Mode
    IniWrite, %winF12Mode%, %CONFIG_PATH%, %section%, winF12Mode

    IniWrite, %ctrlAltF1Mode%, %CONFIG_PATH%, %section%, ctrlAltF1Mode
    IniWrite, %ctrlAltF2Mode%, %CONFIG_PATH%, %section%, ctrlAltF2Mode
    IniWrite, %ctrlAltF3Mode%, %CONFIG_PATH%, %section%, ctrlAltF3Mode
    IniWrite, %ctrlAltF4Mode%, %CONFIG_PATH%, %section%, ctrlAltF4Mode
    IniWrite, %ctrlAltF5Mode%, %CONFIG_PATH%, %section%, ctrlAltF5Mode
    IniWrite, %ctrlAltF6Mode%, %CONFIG_PATH%, %section%, ctrlAltF6Mode
    IniWrite, %ctrlAltF7Mode%, %CONFIG_PATH%, %section%, ctrlAltF7Mode
    IniWrite, %ctrlAltF8Mode%, %CONFIG_PATH%, %section%, ctrlAltF8Mode
    IniWrite, %ctrlAltF9Mode%, %CONFIG_PATH%, %section%, ctrlAltF9Mode
    IniWrite, %ctrlAltF10Mode%, %CONFIG_PATH%, %section%, ctrlAltF10Mode
    IniWrite, %ctrlAltF11Mode%, %CONFIG_PATH%, %section%, ctrlAltF11Mode
    IniWrite, %ctrlAltF12Mode%, %CONFIG_PATH%, %section%, ctrlAltF12Mode

    IniWrite, %ctrlShiftF1Mode%, %CONFIG_PATH%, %section%, ctrlShiftF1Mode
    IniWrite, %ctrlShiftF2Mode%, %CONFIG_PATH%, %section%, ctrlShiftF2Mode
    IniWrite, %ctrlShiftF3Mode%, %CONFIG_PATH%, %section%, ctrlShiftF3Mode
    IniWrite, %ctrlShiftF4Mode%, %CONFIG_PATH%, %section%, ctrlShiftF4Mode
    IniWrite, %ctrlShiftF5Mode%, %CONFIG_PATH%, %section%, ctrlShiftF5Mode
    IniWrite, %ctrlShiftF6Mode%, %CONFIG_PATH%, %section%, ctrlShiftF6Mode
    IniWrite, %ctrlShiftF7Mode%, %CONFIG_PATH%, %section%, ctrlShiftF7Mode
    IniWrite, %ctrlShiftF8Mode%, %CONFIG_PATH%, %section%, ctrlShiftF8Mode
    IniWrite, %ctrlShiftF9Mode%, %CONFIG_PATH%, %section%, ctrlShiftF9Mode
    IniWrite, %ctrlShiftF10Mode%, %CONFIG_PATH%, %section%, ctrlShiftF10Mode
    IniWrite, %ctrlShiftF11Mode%, %CONFIG_PATH%, %section%, ctrlShiftF11Mode
    IniWrite, %ctrlShiftF12Mode%, %CONFIG_PATH%, %section%, ctrlShiftF12Mode
    
    IniWrite, %FrontTopMouseBtnBehavior%, %CONFIG_PATH%, Mouse, FrontTopMouseBtnBehavior
    IniWrite, %BackTopMouseBtnBehavior%, %CONFIG_PATH%, Mouse, BackTopMouseBtnBehavior
}

readConfigFile() { ;Reads values from the ini file for #o (really only for the script startup).
global
    section := "FnKeys"
    ;Last parameter is the default value if it isn't found in the .ini file.
    IniRead, F1Mode, %CONFIG_PATH%, %section%, F1Mode, FirefoxTabs
    IniRead, F2Mode, %CONFIG_PATH%, %section%, F2Mode, FirefoxWins
    IniRead, F3Mode, %CONFIG_PATH%, %section%, F3Mode, VSCodeTabs
    IniRead, F4Mode, %CONFIG_PATH%, %section%, F4Mode, VSCodeWins
    IniRead, F5Mode, %CONFIG_PATH%, %section%, F5Mode, Default
    IniRead, F6Mode, %CONFIG_PATH%, %section%, F6Mode, WinSwitcher
    IniRead, F7Mode, %CONFIG_PATH%, %section%, F7Mode, WinSwitcher
    IniRead, F8Mode, %CONFIG_PATH%, %section%, F8Mode, WinHider
    IniRead, F9Mode, %CONFIG_PATH%, %section%, F9Mode, ExplorerWins
    IniRead, F10Mode, %CONFIG_PATH%, %section%, F10Mode, WinHider
    IniRead, F11Mode, %CONFIG_PATH%, %section%, F11Mode, Default
    IniRead, F12Mode, %CONFIG_PATH%, %section%, F12Mode, Default
    
    IniRead, ctrlF1Mode, %CONFIG_PATH%, %section%, ctrlF1Mode, NewFFWin
    IniRead, ctrlF2Mode, %CONFIG_PATH%, %section%, ctrlF2Mode, NewFFWin
    IniRead, ctrlF3Mode, %CONFIG_PATH%, %section%, ctrlF3Mode, NewChrWin
    IniRead, ctrlF4Mode, %CONFIG_PATH%, %section%, ctrlF4Mode, NewChrWin
    IniRead, ctrlF5Mode, %CONFIG_PATH%, %section%, ctrlF5Mode, Default
    IniRead, ctrlF6Mode, %CONFIG_PATH%, %section%, ctrlF6Mode, WinAdder
    IniRead, ctrlF7Mode, %CONFIG_PATH%, %section%, ctrlF7Mode, WinAdder
    IniRead, ctrlF8Mode, %CONFIG_PATH%, %section%, ctrlF8Mode, WinAdder
    IniRead, ctrlF9Mode, %CONFIG_PATH%, %section%, ctrlF9Mode, Default
    IniRead, ctrlF10Mode, %CONFIG_PATH%, %section%, ctrlF10Mode, WinAdder
    IniRead, ctrlF11Mode, %CONFIG_PATH%, %section%, ctrlF11Mode, Default
    IniRead, ctrlF12Mode, %CONFIG_PATH%, %section%, ctrlF12Mode, Default
    
    IniRead, shiftF1Mode, %CONFIG_PATH%, %section%, shiftF1Mode, FirefoxTabsReverse
    IniRead, shiftF2Mode, %CONFIG_PATH%, %section%, shiftF2Mode, Default
    IniRead, shiftF3Mode, %CONFIG_PATH%, %section%, shiftF3Mode, VSCodeTabsReverse
    IniRead, shiftF4Mode, %CONFIG_PATH%, %section%, shiftF4Mode, Default
    IniRead, shiftF5Mode, %CONFIG_PATH%, %section%, shiftF5Mode, Default
    IniRead, shiftF6Mode, %CONFIG_PATH%, %section%, shiftF6Mode, Default
    IniRead, shiftF7Mode, %CONFIG_PATH%, %section%, shiftF7Mode, Default
    IniRead, shiftF8Mode, %CONFIG_PATH%, %section%, shiftF8Mode, Default
    IniRead, shiftF9Mode, %CONFIG_PATH%, %section%, shiftF9Mode, Default
    IniRead, shiftF10Mode, %CONFIG_PATH%, %section%, shiftF10Mode, Default
    IniRead, shiftF11Mode, %CONFIG_PATH%, %section%, shiftF11Mode, Default
    IniRead, shiftF12Mode, %CONFIG_PATH%, %section%, shiftF12Mode, Default
    
    IniRead, altF1Mode, %CONFIG_PATH%, %section%, altF1Mode, NewPrivFFWin
    IniRead, altF2Mode, %CONFIG_PATH%, %section%, altF2Mode, NewPrivFFWin
    IniRead, altF3Mode, %CONFIG_PATH%, %section%, altF3Mode, NewPrivChrWin
    IniRead, altF4Mode, %CONFIG_PATH%, %section%, altF4Mode, NewPrivChrWin
    IniRead, altF5Mode, %CONFIG_PATH%, %section%, altF5Mode, Default
    IniRead, altF6Mode, %CONFIG_PATH%, %section%, altF6Mode, AddAndHide
    IniRead, altF7Mode, %CONFIG_PATH%, %section%, altF7Mode, AddAndHide
    IniRead, altF8Mode, %CONFIG_PATH%, %section%, altF8Mode, AddAndHide
    IniRead, altF9Mode, %CONFIG_PATH%, %section%, altF9Mode, Default
    IniRead, altF10Mode, %CONFIG_PATH%, %section%, altF10Mode, AddAndHide
    IniRead, altF11Mode, %CONFIG_PATH%, %section%, altF11Mode, Default
    IniRead, altF12Mode, %CONFIG_PATH%, %section%, altF12Mode, Default
    
    IniRead, winF1Mode, %CONFIG_PATH%, %section%, winF1Mode, Default
    IniRead, winF2Mode, %CONFIG_PATH%, %section%, winF2Mode, Default
    IniRead, winF3Mode, %CONFIG_PATH%, %section%, winF3Mode, Default
    IniRead, winF4Mode, %CONFIG_PATH%, %section%, winF4Mode, Default
    IniRead, winF5Mode, %CONFIG_PATH%, %section%, winF5Mode, Default
    IniRead, winF6Mode, %CONFIG_PATH%, %section%, winF6Mode, Default
    IniRead, winF7Mode, %CONFIG_PATH%, %section%, winF7Mode, Default
    IniRead, winF8Mode, %CONFIG_PATH%, %section%, winF8Mode, Default
    IniRead, winF9Mode, %CONFIG_PATH%, %section%, winF9Mode, Default
    IniRead, winF10Mode, %CONFIG_PATH%, %section%, winF10Mode, Default
    IniRead, winF11Mode, %CONFIG_PATH%, %section%, winF11Mode, Default
    IniRead, winF12Mode, %CONFIG_PATH%, %section%, winF12Mode, Default
    
    IniRead, ctrlAltF1Mode, %CONFIG_PATH%, %section%, ctrlAltF1Mode, Default
    IniRead, ctrlAltF2Mode, %CONFIG_PATH%, %section%, ctrlAltF2Mode, Default
    IniRead, ctrlAltF3Mode, %CONFIG_PATH%, %section%, ctrlAltF3Mode, Default
    IniRead, ctrlAltF4Mode, %CONFIG_PATH%, %section%, ctrlAltF4Mode, Default
    IniRead, ctrlAltF5Mode, %CONFIG_PATH%, %section%, ctrlAltF5Mode, Default
    IniRead, ctrlAltF6Mode, %CONFIG_PATH%, %section%, ctrlAltF6Mode, WinRemover
    IniRead, ctrlAltF7Mode, %CONFIG_PATH%, %section%, ctrlAltF7Mode, WinRemover
    IniRead, ctrlAltF8Mode, %CONFIG_PATH%, %section%, ctrlAltF8Mode, WinRemover
    IniRead, ctrlAltF9Mode, %CONFIG_PATH%, %section%, ctrlAltF9Mode, Default
    IniRead, ctrlAltF10Mode, %CONFIG_PATH%, %section%, ctrlAltF10Mode, WinRemover
    IniRead, ctrlAltF11Mode, %CONFIG_PATH%, %section%, ctrlAltF11Mode, Default
    IniRead, ctrlAltF12Mode, %CONFIG_PATH%, %section%, ctrlAltF12Mode, Default
    
    IniRead, ctrlShiftF1Mode, %CONFIG_PATH%, %section%, ctrlShiftF1Mode, Default
    IniRead, ctrlShiftF2Mode, %CONFIG_PATH%, %section%, ctrlShiftF2Mode, Default
    IniRead, ctrlShiftF3Mode, %CONFIG_PATH%, %section%, ctrlShiftF3Mode, Default
    IniRead, ctrlShiftF4Mode, %CONFIG_PATH%, %section%, ctrlShiftF4Mode, Default
    IniRead, ctrlShiftF5Mode, %CONFIG_PATH%, %section%, ctrlShiftF5Mode, Default
    IniRead, ctrlShiftF6Mode, %CONFIG_PATH%, %section%, ctrlShiftF6Mode, Default
    IniRead, ctrlShiftF7Mode, %CONFIG_PATH%, %section%, ctrlShiftF7Mode, Default
    IniRead, ctrlShiftF8Mode, %CONFIG_PATH%, %section%, ctrlShiftF8Mode, Default
    IniRead, ctrlShiftF9Mode, %CONFIG_PATH%, %section%, ctrlShiftF9Mode, Default
    IniRead, ctrlShiftF10Mode, %CONFIG_PATH%, %section%, ctrlShiftF10Mode, Default
    IniRead, ctrlShiftF11Mode, %CONFIG_PATH%, %section%, ctrlShiftF11Mode, Default
    IniRead, ctrlShiftF12Mode, %CONFIG_PATH%, %section%, ctrlShiftF12Mode, Default

    IniRead, FrontTopMouseBtnBehavior, %CONFIG_PATH%, Mouse, FrontTopMouseBtnBehavior, Double Click
    IniRead, BackTopMouseBtnBehavior, %CONFIG_PATH%, Mouse, BackTopMouseBtnBehavior, Double Click
}

setMainGUIValues() {
global
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

    ;Might need "Main:" here because of leftover Gui Default from FnSetting
    GuiControl, Main:ChooseString, FrontTopMouseBtnBehavior, %FrontTopMouseBtnBehavior%
    GuiControl, Main:ChooseString, BackTopMouseBtnBehavior, %BackTopMouseBtnBehavior%
}