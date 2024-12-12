;Adapted from: https://www.autohotkey.com/docs/v1/lib/DllCall.htm#HideCursor
;and: https://github.com/Stefan-Z-Camilleri-zz/Windows-Cursor-Hider/tree/master

SystemCursor("Init")

MouseGetPos mX0, mY0

SetTimer, CheckIdle, 250

