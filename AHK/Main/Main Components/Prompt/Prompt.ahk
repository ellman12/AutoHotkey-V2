;A basic "command prompt" kinda thing for running misc things that aren't deserving of their own hotkey, or that did have a hotkey in AHK-V1 but that no longer do in Main for AHK-V2 because they don't deserve/need it.
;This is basically the same thing as Run.ahk from AHK-V1

;TODO: copy other stuff from Run into here, too.

/*
Used for mass downloading music tracks from this website: https://downloads.khinsider.com/
These coordinates only work with my big 1080p Asus monitor.
Here's how to use it:
1. Use the Snap Links extension to open several tabs at once
2. Test and make sure the screen coordinates are all correct (test a single track at a time)
3. That's it. Just don't open too many tabs at once, or else it won't work properly because your browser will seriously slow down.
*/
; RAlt::
; InputBox, loopAmt, Num of tabs, Enter num of tabs,, 200, 130,,,,, 13
; Sleep 600
; Loop %loopAmt% {
; 	; MouseClick, Right, 751, 347 ;FLAC
; 	MouseClick, Right, 742, 313 ;MP3
; 	Sleep 300
; 	Send, k
; 	Sleep 1550
; 	; Send, {Home}{Delete 5}
; 	; Sleep 1200
; 	MouseClick, Left, 1086, 822 ;Click "Save" button
; 	; Sleep 1050
; 	Send, ^w
; 	Sleep 900
; }
; return

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
togglePrompt()
runCommand(currentCmd)
return

#If