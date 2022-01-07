;Run a custom script at runtime from inside another script.

Gui, QC:Default
Gui, +AlwaysOnTop
Gui, Font, s9
Gui, Add, Text, x3 y3, Enter code to run:
Gui, Add, Edit, vQuickCodeEdit xp-2 y20 w196 h189
Gui, Add, Button, xp y212 gQuickCodeDoneButton, &Done

global QUICK_SCRIPT_PATH := A_ScriptDir . "/Main Components/Quick Code/Quick Script.ahk"
global QCVisibility := 0