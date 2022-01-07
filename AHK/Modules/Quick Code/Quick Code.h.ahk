;Run a custom script at runtime from inside another script.
global QC_DEFAULT_WIDTH := 500
global QC_DEFAULT_HEIGHT := 300
global QC_TITLE := "Quick Code"

global qcWidth := QC_DEFAULT_WIDTH
global qcHeight := QC_DEFAULT_HEIGHT

global qcEditWidth := qcWidth - 12
global qcEditHeight := qcHeight - 45

Gui, QC:Default
Gui, +AlwaysOnTop
Gui, +Resize
Gui, Font, s10
Gui, Add, Button, x5 y6 gQCDoneClick, &Done
Gui, Add, Button, x+4 yp gQCCloseBtnPress, &Close (#+q)
Gui, Add, Edit, vQuickCodeEdit x5 y38 w%qcEditWidth% h%qcEditHeight%

;The script used by this
global QUICK_SCRIPT_PATH := A_ScriptDir . "../../Modules/Quick Code/Quick Script.ahk"
global QCVisibility := 0