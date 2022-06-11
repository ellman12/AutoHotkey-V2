;Close Discord and minimize it to the system tray.
#IfWinActive, Discord
^!c::
MouseGetPos, ogX, ogY
MouseClick, Left, 1920, 0, 1, 0
MouseMove, ogX, ogY, 0
Send, !{Tab}
return

#IfWinActive, Stardew Valley
^!c::Send, {Click 12} ;Click a bunch of times

#IfWinActive, ahk_exe rider64.exe
^!c::
SendRaw, //
Send, {Home}
Send, /
Send, {End}
Send, {LAlt}
return
#If