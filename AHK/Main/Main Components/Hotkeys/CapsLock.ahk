;Turning this useless and annoying key into useful custom hotkeys.

#If (GetKeyState("CapsLock", "P"))
Enter::Send, Kind regards`,{Enter 2}Elliott DuCharme

;Open Google Calendar.
n::Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://calendar.google.com/calendar/u/0/r

;Comma for moving window to left monitor
SC033::Send, +#{Left}

;Period for moving window to right monitor
SC034::Send, +#{Right}

i::Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://images.google.com/ ;Create a new Private Firefox window w/ Google Images.
p::Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/ ;Create a new Private Firefox window w/ Google.

;Left bracket -> Google Images Search for selected text in Private Firefox.
SC01A::searchForSelection("https://www.google.com/search?tbm=isch&q=")

;Right bracket -> Google Search for selected text in Private Firefox.
SC01B::searchForSelection("https://www.google.com/search?q=")

searchForSelection(url) {
    BlockInput, On
    oldClipboard := Clipboard
    Clipboard := 
    Send, ^c
    BlockInput, Off
    ClipWait, 0.2
    if (ErrorLevel == 1) { ;If can't find text just do what p does.
        Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window %url%
        return
    }

    Clipboard := StrReplace(Clipboard, A_Space, "+")
    runURL := url . Clipboard
    Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window %runURL%
    Clipboard := oldClipboard
}

Up::Send, {U+2191} ;↑
Right::Send, {U+2192} ;→
Down::Send, {U+2193} ;↓
Left::Send, {U+2190} ;←

#If