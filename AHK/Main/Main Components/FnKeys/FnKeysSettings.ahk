FnOkClick:
Gui, FnSettings:Submit
writeConfigFile()
return

FnGuiClose:
FnCancelClick:
    Gui, FnSettings:Cancel
    readConfigFile()
    setMainGUIValues()
return

FnApplyClick:
Gui, FnSettings:Submit, NoHide
writeConfigFile()
return

FnResetClick:
resetMainSettings()
return