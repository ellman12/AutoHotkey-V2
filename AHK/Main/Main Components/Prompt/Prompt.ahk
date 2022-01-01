;A basic "command prompt" kinda thing for running misc things that aren't deserving of their own hotkey, or that did have a hotkey in AHK-V1 but that no longer do in Main for AHK-V2 because they don't deserve/need it.
;This is basically the same thing as Run.ahk from AHK-V1

;TODO: copy other stuff from Run into here, too.
;TODO: Stuff copied and pasted from MSR that will be implemented later:

; ^+g:: ;Calculate percent grade on a homework assignment or whatever, then show result and letter grade equivalent. So, for something like 40/50, you'd enter 40 and then 50.
; InputBox, firstNum, Grade Percent Utility, What is the first number?,, 200, 150
; InputBox, secondNum, Grade Percent Utility, What is the second number?,, 200, 150

; result := round((firstNum/secondNum) * 100, 2)
; MsgBox, 0, Grade, You got %result%`%.`n`nA+`t97-100`nA`t94-96`nA-`t90-93`nB+`t87-89`nB`t84-86`nB-`t80-83`nC+`t77-79`nC`t74-76`nC-`t70-73`nD+`t67-69`nD`t64-66`nD-`t60-63`nF`t0-59
; return

; ;Shows just the letter/number grades part of the MsgBox from ^+g.
; !+g::MsgBox, 0, Letter/Number Grade Chart, A+`t97-100`nA`t94-96`nA-`t90-93`nB+`t87-89`nB`t84-86`nB-`t80-83`nC+`t77-79`nC`t74-76`nC-`t70-73`nD+`t67-69`nD`t64-66`nD-`t60-63`nF`t0-59

;***********************************RARELY USED BUT STILL USEFUL***********************************
; ^!+d:: ;Used for deleting videos from YouTube playlist. Asks you how many to delete and then it starts doing its thing.
; InputBox, numVidsToDelete, How many videos do you want to delete?, As soon as you hit enter`, the script will start deleting videos. Please position cursor over the first video's x button.

; Loop %numVidsToDelete% {
; 	Send, {Escape} ;Get rid of stupid annoying pop-up from YouTube.
; 	Sleep 500
; 	Send, {Click}
; 	Sleep 500
; }
; return

; #+d::deleteMostRecentItemInFolder("Downloads") ;Recycle the most recently created file or folder in the Downloads folder.
; ^#+d::deleteMostRecentItemInFolder("Desktop") ;Same thing but for Desktop folder.

; deleteMostRecentItemInFolder(folderName)
; {
; 	Loop, Files, C:\Users\%A_UserName%\%folderName%\*.*, FD ;FD = Include Files and Directories
; 	{
; 		;Loops through this directory, and if it encounters a file/folder that is newer than the previously encountered one,
; 		; make that the one to potentially delete.
; 		if ((A_LoopFileTimeModified > currentMaxCreationDate) AND (A_LoopFileName != ".tmp.drivedownload"))
; 		{
; 			currentMaxCreationDate := A_LoopFileTimeModified
; 			thingToDelete := A_LoopFileName
; 			thingToDeleteFileExt := A_LoopFileExt
; 		}
; 	}

; 	if (thingToDelete == "") ;If the folder is empty.
; 	{
; 		MsgBox, 262160, Error., No more items in %folderName% folder. The current thread will now exit.
; 		return
; 	}

; 	if (thingToDeleteFileExt == "") ;If it's a folder, don't tack on an extension thing in the prompt asking if you for sure want to delete it.
; 		message = Recycle folder "%thingToDelete%"?
; 	else
; 		message = Recycle file "%thingToDelete%"?

; 	MsgBox, 262180, Recycle Latest Thing in %folderName% Folder?, %message%
; 	IfMsgBox, No
; 		return

; 	FileRecycle, C:\Users\%A_UserName%\%folderName%\%thingToDelete%
; 	if (ErrorLevel == 1)
; 		MsgBox, 262160, Error, An error occurred while trying to recycle "%thingToDelete%".
; }

/*
Used for mass downloading music tracks from this website: https://downloads.khinsider.com/
These coordinates only work with big 1080p Asus monitor.
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

;if active win = whatever
;up = inc index 
;down = dec index
;enter to run it

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