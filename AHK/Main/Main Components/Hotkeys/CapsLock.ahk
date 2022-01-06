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
SC01A::
BlockInput, on
prevClipboard = %clipboard%
clipboard =
Send, ^c
BlockInput, off
ClipWait, 0.2
if ErrorLevel = 0
{
    searchQuery=%clipboard%
    GoSub, GoogleImagesSearch
}
else ;If can't find text just do what i does.
    Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://images.google.com/
clipboard = %prevClipboard%
return

;Right bracket -> Google Search for selected text in Private Firefox.
SC01B::
BlockInput, on
prevClipboard = %clipboard%
clipboard =
Send, ^c
BlockInput, off
ClipWait, 0.2
if ErrorLevel = 0
{
    searchQuery = %clipboard%
    GoSub, GoogleSearch
}
else ;If can't find text just do what p does.
    Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/
clipboard = %prevClipboard%
return

;------------------TEMP------------------
/::SendRaw, elliott.ducharme@trojans.dsu.edu
^/::SendRaw, elliott.ducharme

;Open Google Drive where school stuff is
AppsKey::Run, explorer G:\Other computers\My PC\DSU Year 2 Semester 1

GoogleSearch:
   StringReplace, searchQuery, searchQuery, `r`n, %A_Space%, All
   Loop
   {
      noExtraSpaces=1
      StringLeft, leftMost, searchQuery, 1
      IfInString, leftMost, %A_Space%
      {
         StringTrimLeft, searchQuery, searchQuery, 1
         noExtraSpaces=0
      }
      StringRight, rightMost, searchQuery, 1
      IfInString, rightMost, %A_Space%
      {
         StringTrimRight, searchQuery, searchQuery, 1
         noExtraSpaces=0
      }
      If (noExtraSpaces=1)
        break
   }
   StringReplace, searchQuery, searchQuery, \, `%5C, All
   StringReplace, searchQuery, searchQuery, %A_Space%, +, All
   StringReplace, searchQuery, searchQuery, `%, `%25, All
   IfInString, searchQuery, .
   {
      IfInString, searchQuery, +
         Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window http://www.google.com/search?hl=en&q=%searchQuery%
      else
         Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window %searchQuery%
   }
   else
      Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window http://www.google.com/search?hl=en&q=%searchQuery%
return

GoogleImagesSearch:
   StringReplace, searchQuery, searchQuery, `r`n, %A_Space%, All
   Loop
   {
      noExtraSpaces=1
      StringLeft, leftMost, searchQuery, 1
      IfInString, leftMost, %A_Space%
      {
         StringTrimLeft, searchQuery, searchQuery, 1
         noExtraSpaces=0
      }
      StringRight, rightMost, searchQuery, 1
      IfInString, rightMost, %A_Space%
      {
         StringTrimRight, searchQuery, searchQuery, 1
         noExtraSpaces=0
      }
      If (noExtraSpaces=1)
         break
   }
   StringReplace, searchQuery, searchQuery, \, `%5C, All
   StringReplace, searchQuery, searchQuery, %A_Space%, +, All
   StringReplace, searchQuery, searchQuery, `%, `%25, All
   IfInString, searchQuery, .
   {
      IfInString, searchQuery, +
         Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/search?tbm=isch&q=%searchQuery%
      else
         Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window %searchQuery%
   }
   else
      Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/search?tbm=isch&q=%searchQuery%
return
#If