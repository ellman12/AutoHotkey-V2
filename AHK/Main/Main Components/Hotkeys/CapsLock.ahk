;Turning this useless and annoying key into useful custom hotkeys.

#If (GetKeyState("CapsLock", "P"))
Enter::Send, Kind regards`,{Enter 2}Elliott DuCharme

;Open Google Calendar.
n::Run, "chrome.exe" https://calendar.google.com/calendar/u/0/r

;Comma for moving window to left monitor.
SC033::Send, +#{Left}

;Period for moving window to right monitor.
SC034::Send, +#{Right}

i::Run, chrome.exe --incognito https://images.google.com/ ;Create a new Incognito Chrome window w/ Google Images.
p::Run, chrome.exe --incognito https://www.google.com/ ;Create a new Incognito Chrome window w/ Google.
!i::Run, firefox.exe -private-window https://images.google.com/ ;Create a new Private Firefox window w/ Google Images.
!p::Run, firefox.exe -private-window https://www.google.com/ ;Create a new Private Firefox window w/ Google.

;Left bracket.
SC01A::searchForSelection("chrome.exe", "--incognito", "https://www.google.com/search?tbm=isch&q=")
!SC01A::searchForSelection("firefox.exe", "-private-window", "https://www.google.com/search?tbm=isch&q=")

;Right bracket.
SC01B::searchForSelection("chrome.exe", "--incognito", "https://www.google.com/search?q=")
!SC01B::searchForSelection("firefox.exe", "-private-window", "https://www.google.com/search?q=")

searchForSelection(browser, flags, url) {
    BlockInput, On
    oldClipboard := Clipboard
    Clipboard := 
    Send, ^c
    BlockInput, Off
    ClipWait, 0.2
    if (ErrorLevel == 1) { ;If can't find text just do what p does.
        Run, %browser% %flags% %url%
        return
    }

    Clipboard := StrReplace(Clipboard, A_Space, "+")
    runURL := url . Clipboard
    Run, %browser% %flags% %runURL%
    Clipboard := oldClipboard
}

Up::Send, {U+2191} ;↑
Right::Send, {U+2192} ;→
Down::Send, {U+2193} ;↓
Left::Send, {U+2190} ;←

SC00C::Send, {U+2014} ;—
+SC00C::Send, {U+2013} ;–

SC00D::Send, {U+2260} ;≠
!SC033::Send, {U+2264} ;≤
!SC034::Send, {U+2265} ;≥

#If