#include %A_ScriptDir%/../Modules/HideVolumeOSD/VolumeOSD.ahk

if (!VolumeOsd.Show())
{
    MsgBox, Error: Could not find volume OSD
}