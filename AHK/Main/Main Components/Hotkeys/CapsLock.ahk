;Turning this useless and annoying key into dozens of useful custom hotkeys.
;Almost all of these are copied and pasted from the old 2nd keyboard thing that I no longer use.
;I added a thing where I could use CapsLock as a modifier so I didn't need the physical keyboard and I just ended up using that more than the physical thing so here we are.

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

;------------------TEMP------------------
/::SendRaw, elliott.ducharme@trojans.dsu.edu
^/::SendRaw, elliott.ducharme

;Open Google Drive where school stuff is
AppsKey::Run, explorer G:\Other computers\My PC\DSU Year 2 Semester 1

#If