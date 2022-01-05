ShowFx:
Gui, FnSettings:Show, w%FN_WIDTH% h%FN_HEIGHT%, %FN_TITLE%
return

MainOkClick:
Gui, Main:Submit
return

MainCancelClick:
Gui, Main:Cancel
return

MainApplyClick:
Gui, Main:Submit, NoHide
return

#o::toggleGUI(mainVis, "Main", MAIN_WIDTH, MAIN_HEIGHT, MAIN_TITLE)