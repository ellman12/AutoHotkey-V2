QCGuiSize:
qcWidth := A_GuiWidth
qcHeight := A_GuiHeight
qcEditWidth := qcWidth - 12
qcEditHeight := qcHeight - 45
GuiControl, QC:Move, QuickCodeEdit, % "x5 y38 w" qcEditWidth "h" qcEditHeight
return

QCGuiClose:
toggleGUI(QCVisibility, "QC", qcWidth, qcHeight, QC_TITLE`)
return

QCDoneClick:
    QCVisibility := 0
    GUI, QC:Submit ;Get text from edit box.
    if (QuickCodeEdit == "") ;Don't run the empty file.
        Tippy("Nothing entered in Quick Code GUI.", 1000)
    else
    {
        FileRecycle, %QUICK_SCRIPT_PATH% ;Reset (overwrite) the file.
        FileAppend, %QuickCodeEdit%, %QUICK_SCRIPT_PATH%

        GoSub, #+q ;Close the script to avoid the annoying thing about an instance already running.
        Run, %QUICK_SCRIPT_PATH%
    }
return

;Show the GUI, and whatever is already in the file, fill in the Edit control.
#q::
    FileRead, tempScriptContents, %QUICK_SCRIPT_PATH%
    GuiControl, QC:, QuickCodeEdit, %tempScriptContents%

    toggleGUI(QCVisibility, "QC", qcWidth, qcHeight, QC_TITLE`)
return

QCCloseBtnPress:
#+q:: ;Close Temp Script.ahk. https://www.autohotkey.com/docs/commands/PostMessage.htm#ExPID
    SetTitleMatchMode, 2
    DetectHiddenWindows, On
    SendMessage, 0x44, 0x405, 0, , Temp Script.ahk - AutoHotkey v
    WinClose, ahk_pid %ErrorLevel%
return