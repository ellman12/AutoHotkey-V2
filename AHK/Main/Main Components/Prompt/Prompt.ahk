;A basic "command prompt" kinda thing for running misc things that aren't deserving of their own hotkey, or that did have a hotkey in AHK-V1 but that no longer do in Main for AHK-V2 because they don't deserve/need it.
;This is basically the same thing as Run.ahk from AHK-V1

!r::togglePrompt()

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
GuiControl, Prompt:, currentCmd,
prevCmds.InsertAt(prevCmds.MaxIndex(), currentCmd)
runCommand(currentCmd)
return

#If