;Close Discord and minimize it to the system tray.
^!c::
MouseGetPos, ogX, ogY
MouseClick, Left, 1920, 0, 1, 0
MouseMove, ogX, ogY, 0
Send, !{Tab}
return