global PROMPT_WIDTH := 350
global PROMPT_HEIGHT := 30
global PROMPT_TITLE := "Enter a Command"
global promptVisible := false
global prevCmds := []
global currentIndex := 0
global prevWinID := "" ;Used in !r
global PROMPT_HISTORY_PATH := A_ScriptDir . "/../tmp/cmd_hist.tmp"

;Variables for commands
global prevRoundCDec := 1

Gui, Prompt:+AlwaysOnTop
Gui, Prompt:Color, Black
Gui, Prompt:Font, cWhite s12
Gui, Prompt:Margin, 10, 10

Gui, Prompt:Color,, Black
editWidth := PROMPT_WIDTH - 10
Gui, Prompt:Add, Edit, x5 y5 w%editWidth% vcurrentCmd gCmdOnInput -E0x200 ;Remove edit border: www.autohotkey.com/board/topic/71323-remove-type-specified-border-from-edit-control/?p=543956

;Read in previous commands
FileRead, prevCmdsStr, %PROMPT_HISTORY_PATH%
prevCmds := StrSplit(prevCmdsStr, "`n")
currentIndex := prevCmds.Count()

togglePrompt() {
    toggleGUI(promptVisible, "Prompt", PROMPT_WIDTH, PROMPT_HEIGHT, PROMPT_TITLE)
}

runCommand(cmd) {
    FileAppend, % cmd . "`n", %PROMPT_HISTORY_PATH%
    
    switch (cmd) {
        case "", "ERROR":Tippy("Blank/invalid command", 1000)
        case "?":Run, notepad.exe %A_ScriptDir%/Main Components/Prompt/Help.txt
        Default:
            currentCmd := ""
            togglePrompt()
            Tippy("Unknown command", 2000)
        return
        
        ;----------------------------------------TEXT----------------------------------------
        case "/":Clipboard := StrReplace(Clipboard, "\", "/") ;Replace '\' in the Clipboard with '/'.
        case "\":Clipboard := StrReplace(Clipboard, "/", "\") ;Vice versa.
        
        case "/'": ;Does what '\' does and also removes "" from Clipboard too.
            Clipboard := StrReplace(Clipboard, "\", "/")
            Clipboard := StrReplace(Clipboard, """", "")
        return
        
        ;Trims whitespace and newlines in Clipboard
        case "trim":
            Clipboard := Trim(Clipboard)
            Clipboard := StrReplace(Clipboard, "`r")
            Clipboard := StrReplace(Clipboard, "`n")
        return
        
        case "FAR": ;Find and Replace.
            runFAR()
        return
        
        ;---------------------------------------NUMBER---------------------------------------
        case "round":
            InputBox, numToRound, Enter Number to Round, Enter Number to Round,, 200, 150,,,,, %Clipboard%
            InputBox, decPlaces, How Many Decimal Places?, How Many Decimal Places?,, 200, 150,,,,, 2
            Clipboard := Round(numToRound, decPlaces)
        return
        
        ;Round number in Clipboard
        case "roundc":
            InputBox, prevRoundCDec, How Many Decimal Places, How Many Decimal Places?,, 200, 150,,,,, %prevRoundCDec%
            Clipboard := Round(numToRound, decPlaces)
        return
    
        ;---------------------------------------INSERT---------------------------------------
        case "paste":SendRaw, %Clipboard% ;Send Clipboard contents
        case "ed":Send, Elliott DuCharme  ;My name
        
        ;---------------------------------------SYMBOLS--------------------------------------
        case "+-":Send, {U+00B1} ;±
        case "-+":Send, {U+2213} ;∓
        case "mult":Send, {U+00D7} ;×
        case "mult2":Send, {U+22C5} ;⋅
        case "mult3":Send, {U+00B7} ;·
        case "div":Send, {U+00F7} ;÷
        case "sqrt":Send, {U+221A} ;√
        case "int":Send, {U+222B} ;∫
        case "int top":Send, {U+2320} ;⌠
        case "int bot":Send, {U+2321} ;⌡
        case "approx":Send, {U+2248} ;≈
        case "=/=":Send, {U+2260} ;≠
        case "<=":Send, {U+2264} ;≤
        case ">=":Send, {U+2265} ;≥
        case "delta":Send, {U+0394} ;Δ
        case "pi":Send, {U+03C0} ;π
        case "micro":Send, {U+00B5} ;µ
        case "inf":Send, {U+221E} ;∞
        case "...":Send, {U+2026} ;…
        case "theta":Send, {U+03B8} ;θ
        case "u":Send, {U+2191} ;↑
        case "r":Send, {U+2192} ;→
        case "d":Send, {U+2193} ;↓
        case "l":Send, {U+2190} ;←
        case "deg":Send, {U+00B0} ;°
        case "en":Send, {U+2013} ;–
        case "em":Send, {U+2014} ;—
        case "cent":Send, {U+00A2} ;¢
        case "cent2":Send, {U+FFE0} ;￠
        case "check":Send, {U+2713} ;✓
        case "sec":Send, {U+00A7} ;§
        case "x":Send, {U+2717} ;✗

        ;----------------------------------------MISC----------------------------------------
        ;Enter points earned out of total points to figure out letter grade for an assignment
        ;Enter just l in the first box to show just the letter-number chart.
        case "Grade":
            InputBox, firstNum, Grade Percent Utility, What is the first number?,, 200, 150
            
            if (firstNum = "l") {
                MsgBox, 0, Letter/Number Grade Chart, A+`t97-100`nA`t94-96`nA-`t90-93`nB+`t87-89`nB`t84-86`nB-`t80-83`nC+`t77-79`nC`t74-76`nC-`t70-73`nD+`t67-69`nD`t64-66`nD-`t60-63`nF`t0-59
                return
            }
            
            InputBox, secondNum, Grade Percent Utility, What is the second number?,, 200, 150

            result := round((firstNum/secondNum) * 100, 2)
            MsgBox, 0, Grade, You got %result%`%.`n`nA+`t97-100`nA`t94-96`nA-`t90-93`nB+`t87-89`nB`t84-86`nB-`t80-83`nC+`t77-79`nC`t74-76`nC-`t70-73`nD+`t67-69`nD`t64-66`nD-`t60-63`nF`t0-59
        return
        
        ;Figure out your grade in a class by entering all the scores on assignments, etc.
        case "ClassGrade":
            totalPointsEarned := 0 ;E.g., if you got 17/20, this would be 17
            totalMaxPoints := 0 ;and this would be 20

            while (ErrorLevel != 1)
            {
                InputBox, pointsEarned, Enter Points Earned, Enter points earned for assignment %A_Index%. Last entry: %pointsEarned%,, 200, 150,,,,
                totalPointsEarned += pointsEarned
            }

            MsgBox, 262144, Total Points Earned, %totalPointsEarned%
            ErrorLevel := 0 ;Reset for next loop

            while (ErrorLevel != 1)
            {
                InputBox, maxPoints, Enter Max Points, Enter max points for assignment %A_Index%. Last entry: %maxPoints%,, 200, 150,,,,
                totalMaxPoints += maxPoints
            }
            MsgBox, 262144, Max Points, %totalMaxPoints%

            result := round((totalPointsEarned/totalMaxPoints) * 100, 2)
            MsgBox, 0, Grade, You got %result%`%.`n`nA+`t97-100`nA`t94-96`nA-`t90-93`nB+`t87-89`nB`t84-86`nB-`t80-83`nC+`t77-79`nC`t74-76`nC-`t70-73`nD+`t67-69`nD`t64-66`nD-`t60-63`nF`t0-59
        return
        
        case "DelPrHist": ;Delete Prompt history
            FileDelete, %PROMPT_HISTORY_PATH%
            prevCmds := []
            currentIndex := 0
        return
        
        ;---------------------------RARELY USED BUT STILL USEFUL---------------------------
        case "DownloadMusic":
            /*Used for mass downloading music tracks from this website: https://downloads.khinsider.com/
            These coordinates only work with my big 1080p Asus monitor.
            Here's how to use it:
            1. Use the Snap Links browser extension to open several tabs at once
            2. Test and make sure the screen coordinates are all correct (test a single track at a time)
            3. That's it. Just don't open too many tabs at once, or else it won't work properly because your browser will seriously slow down and won't be as responsive.
            */
            InputBox, loopAmt, Num of tabs, Enter num of tabs,, 200, 130,,,,, 13
            Sleep 600
            Loop %loopAmt% {
                ; MouseClick, Right, 751, 347 ;FLAC
                MouseClick, Right, 742, 313 ;MP3
                Sleep 300
                Send, k
                Sleep 1550
                ; Send, {Home}{Delete 5}
                ; Sleep 1200
                MouseClick, Left, 1086, 822 ;Click "Save" button
                ; Sleep 1050
                Send, ^w
                Sleep 900
            }
        return
        
        ;Used for deleting videos from YouTube playlist.
        case "DelFromYTPlaylist":
            InputBox, numVidsToDelete, How many videos do you want to delete?, As soon as you hit enter`, the script will start deleting videos. Please position cursor over the first video's x button.

            if (ErrorLevel == 1) {
                Tippy("Cancel/Escape was pressed.", 500)
                return
            }
            
            Loop %numVidsToDelete% {
            	Send, {Escape} ;Get rid of stupid annoying pop-up from YouTube.
            	Sleep 500
            	Send, {Click}
            	Sleep 500
            }
        return
    }
}