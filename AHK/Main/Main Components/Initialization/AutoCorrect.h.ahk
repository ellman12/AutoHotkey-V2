;GUI to add new hotstrings to AutoCorrect at runtime
;This GUI is a greatly improved version of a similar feature originally in the original script.
;If it's 1, show the GUI; if it's 0, hide it.
global ACToggle := 0

global AC_WIDTH := 284
global AC_HEIGHT := 193
global AC_TITLE := "New Hotstring"

Gui, AC:Default
Gui, Color, Silver
Gui, +AlwaysOnTop

Gui, Font, s13
Gui, Add, Text, x4 y4, Incorrect Word
Gui, Add, Text, x145 yp, Correct Word
Gui, Add, Text, x4 y60, Hotstring Options

Gui, Add, Edit, x4 y25 vIncorrectEdit w130
Gui, Add, Edit, x145 yp vCorrectEdit w130

Gui, Font, s11 q5
Gui, Add, Checkbox, x4 y83 vStarCheck, *: Ending char not needed.
Gui, Add, Checkbox, x4 yp+18 vQuestionCheck, ?: Trigger when inside another word.
Gui, Add, Checkbox, x4 yp+18 vXCheck, X: Execute text instead of replace.
Gui, Add, Checkbox, x4 yp+18 vTmpCheck, Temporary Hotstring

Gui, Font, s13 q5
Gui, Add, Button, x4 yp+22 w55 h29 gacFinishBtnClick, &Finish

Gui, Font, s9 q5
Gui, Add, Edit, xp+59 yp+4 h22 w107 vACOptions, Extra Options ;Additional, rarely-used Hotstring options like 'C', etc.
Gui, Add, Button, x+4 yp h22 gopenInVSCode, Open in VSCode