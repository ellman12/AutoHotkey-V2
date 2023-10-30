#include %A_ScriptDir%/../Modules/HideVolumeOSD/VolumeOSD.ahk

if (!VolumeOsd.Hide())
{
    MsgBox, Error: Could not find volume OSD
}