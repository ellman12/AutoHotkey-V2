global PROMPT_WIDTH := 350
global PROMPT_HEIGHT := 30
global PROMPT_TITLE := "Enter a Command"
global promptVisible := false
global prevCmds := []
global currentIndex := 0
global prevWinID := "" ;Used in !r
global PROMPT_HISTORY_PATH := A_ScriptDir . "/../tmp/cmd_hist.tmp"

;Variables for commands
global prevRoundCDec := 2
global repoName := ""
global unityRepoName := ""

Gui, Prompt:+AlwaysOnTop
Gui, Prompt:Color, Black
Gui, Prompt:Font, cWhite s12
Gui, Prompt:Margin, 10, 10

Gui, Prompt:Color,, Black
editWidth := PROMPT_WIDTH - 10
Gui, Prompt:Add, Edit, x5 y5 w%editWidth% vcurrentCmd gCmdOnInput -E0x200 ;Remove edit border: www.autohotkey.com/board/topic/71323-remove-type-specified-border-from-edit-control/?p=543956

;Read in previous commands
FileRead, prevCmdsStr, %PROMPT_HISTORY_PATH%
prevCmds := StrSplit(prevCmdsStr, "`r`n")
currentIndex := prevCmds.Count()

togglePrompt() {
    toggleGUI(promptVisible, "Prompt", PROMPT_WIDTH, PROMPT_HEIGHT, PROMPT_TITLE)
}

runCommand(cmd) {
    switch (cmd) {
        Default:
            if (InStr(cmd, "FAR"))
            {
                cmd := StrReplace(cmd, "FAR")
                cmd := Trim(cmd)
                Run, %A_ScriptDir%/../Modules/Hotkeys/FAR.ahk %cmd%
                return
            }
            else if (InStr(cmd, "Send"))
            {
                cmd := StrReplace(cmd, "Send,")
                cmd := StrReplace(cmd, "Send")
                cmd := Trim(cmd)
                if (cmd != "")
                    SendInput, %cmd%
                return
            }
            
            togglePrompt()
            return
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
        
        case "FAR": ;Find and Replace GUI.
            runFAR()
        return

        ;---------------------------------------INSERT---------------------------------------
        case "paste": SendRaw, %Clipboard% ;Send Clipboard contents
        
        case "ed":Send, Elliott DuCharme  ;My name
        
        ;---------------------------------------SYMBOLS--------------------------------------
        ;Arrows
        case "u":Send, {U+2191} ;↑
        case "r":Send, {U+2192} ;→
        case "d":Send, {U+2193} ;↓
        case "l":Send, {U+2190} ;←
        case "<---":Send, {U+27F5} ;⟵
        case "--->":Send, {U+27F6} ;⟶
        case "==>":Send, {U+27F9} ;⟹
        case "<==":Send, {U+27F8} ;⟸
        case "<->":Send, {U+2194} ;↔
        
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
        case "!=":Send, {U+2260} ;≠
        case "<=":Send, {U+2264} ;≤
        case ">=":Send, {U+2265} ;≥
        case "delta":Send, {U+0394} ;Δ
        case "pi":Send, {U+03C0} ;π
        case "micro":Send, {U+00B5} ;µ
        case "inf":Send, {U+221E} ;∞
        case "...":Send, {U+2026} ;…
        case "theta":Send, {U+03B8} ;θ
        case "deg":Send, {U+00B0} ;°
        case "en":Send, {U+2013} ;–
        case "em":Send, {U+2014} ;—
        case "cent":Send, {U+00A2} ;¢
        case "cent2":Send, {U+FFE0} ;￠
        case "check":Send, {U+2713} ;✓
        case "sec":Send, {U+00A7} ;§
        case "x":Send, {U+2717} ;✗
        case "===":Send, {U+2261} ;≡
        case "!===":Send, {U+2262} ;≢
        case "xor":Send, {U+2295} ;⊕
        case "therefore":Send, {U+2234} ;∴
        case "sq":Send, {U+00B2} ;²

        ;----------------------------------------MISC----------------------------------------
        case "?":Run, notepad.exe %A_ScriptDir%/Main Components/Prompt/Help.txt

        case "DelPrHist": ;Delete Prompt history
            FileDelete, %PROMPT_HISTORY_PATH%
            prevCmds := []
            currentIndex := 0
        return
        
        case "bkupGH": ;Backup GitHub folder (or a single repo) to tmp folder on PC and put in a timestamp folder. Useful to do before doing a destructive git operation like force push, merge, etc.
            InputBox, repoName, Which Repo?, Enter a single repo to back up`, or nothing for the whole folder.,, 250, 150,,,,, %repoName%
            
            FormatTime, timestamp,, M-d-yyyy h;mm;ss tt
            src := """C:/Users/Elliott/Documents/GitHub/" . repoName . """"
            dest := """C:/Users/Elliott/Videos/tmp/GitHub Backup " . timestamp . "/" . repoName . """"
            
            ;https://superuser.com/a/1004069
            Run, robocopy %src% %dest% /E
        return
        
        case "bkupUnityGH": ;Similar to bkupGH, but meant for a git repo for a Unity project. Backs up only the important files and folders, skipping the (usually enormous) temporary files/folders.
            InputBox, unityRepoName, Which Unity Repo?, Enter a single Unity git repo to back up.,, 250, 150,,,,, %unityRepoName%
            
            FormatTime, timestamp,, M-d-yyyy h;mm;ss tt
            src := """C:/Users/Elliott/Documents/GitHub/" . unityRepoName . """"
            dest := """C:/Users/Elliott/Videos/tmp/GitHub Backup " . timestamp . "/" . unityRepoName . "/"""

            Run, robocopy %src% %dest% /E /XD ".idea" "Library" "Logs" "obj"
        return
        
        case "Rename": ;Sets the active window title to whatever you want.
            ; DetectHiddenWindows, On
            ; DetectHiddenText, On
            WinGetActiveTitle, oldTitle
            InputBox, newTitle, Set Window Title, Enter a new name for this window.,, 250, 150
            WinSetTitle, %oldTitle%, , %newTitle%
        return
        
        ;---------------------------RARELY USED BUT STILL USEFUL---------------------------
        case "DownloadMusic":
            /*Used for mass downloading music tracks from this website: https://downloads.khinsider.com/
            Here's how to use it:
            1. Use the Snap Links browser extension to open several tabs at once
            2. Test and make sure the screen coordinates are all correct (test a single track at a time)
            3. That's it. Just don't open too many tabs at once, or else it won't work properly because your browser will seriously slow down and won't be as responsive.
            */
            InputBox, loopAmt, Num of tabs, Enter num of tabs,, 200, 130,,,,, 13
            Sleep 2000
            Loop %loopAmt% {
                Send, {RButton}
                Sleep 300
                Send, v
                Sleep 800
                ; Send, !{s}
                Send, {LButton}
                Sleep 800
                Send, ^w
                Sleep 800
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