ShowFx:
Gui, FnSettings:Show, w%FN_WIDTH% h%FN_HEIGHT%, %FN_TITLE%
return

MainOkClick:
Gui, Main:Submit
writeConfigFile()
return

MainGuiClose:
MainCancelClick:
    Gui, Main:Cancel
    readConfigFile()
    setMainGUIValues()
return

MainApplyClick:
Gui, Main:Submit, NoHide
writeConfigFile()
return

MainResetClick:
resetMainSettings()
return

#o::toggleGUI(mainVis, "Main", MAIN_WIDTH, MAIN_HEIGHT, MAIN_TITLE)