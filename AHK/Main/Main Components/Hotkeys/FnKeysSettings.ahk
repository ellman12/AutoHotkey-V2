FxOkClick:
Gui, FnSettings:Submit
writeConfigFile()
return

FxCancelClick:
Gui, FnSettings:Cancel
readConfigFile()
setMainGUIValues()
return

FxApplyClick:
Gui, FnSettings:Submit, NoHide
writeConfigFile()
return

FxResetClick:
resetMainSettings()
return