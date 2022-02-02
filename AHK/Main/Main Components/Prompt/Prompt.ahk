;A basic "command prompt" kinda thing for running misc things that aren't deserving of their own hotkey, or that did have a hotkey in AHK-V1 but that no longer do in Main for AHK-V2 because they don't deserve/need it.
;This is basically the same thing as Run.ahk from AHK-V1
!r::
WinGet, prevWinID, ID, A
togglePrompt()
return

;Repeat last command
^CapsLock::
prevIndex := --currentIndex

commands := StrSplit(prevCmds[prevIndex], "&")
for k, v in commands
    runCommand(Trim(v))

prevIndex := ++currentIndex
return

CmdOnInput:
GuiControlGet, currentCmd,, currentCmd
prevCmds[currentIndex] := currentCmd
return

PromptGuiEscape:
PromptGUIClose:
togglePrompt()
return

#IfWinActive Enter a Command
Up::
if (currentIndex > 0)
    currentIndex--
currentCmd := prevCmds[currentIndex]
GuiControl, Prompt:, currentCmd, %currentCmd%
return

Down::
if (currentIndex < prevCmds.MaxIndex())
    currentIndex++
currentCmd := prevCmds[currentIndex]
GuiControl, Prompt:, currentCmd, %currentCmd%
return

Enter::
currentIndex := prevCmds.MaxIndex() + 1
prevCmds.InsertAt(prevCmds.MaxIndex(), currentCmd)
FileAppend, % currentCmd . "`n", %PROMPT_HISTORY_PATH%
togglePrompt()

commands := StrSplit(currentCmd, "&")
for k, v in commands
    runCommand(Trim(v))
GuiControl, Prompt:, currentCmd,
return

#If