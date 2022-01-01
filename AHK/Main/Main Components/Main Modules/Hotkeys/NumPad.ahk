;Extremely useful groups of hotkeys that make the historically and typically useless NumPad control music, YouTube, and more depending on what's active at the moment. Can also be overridden by the user if they want.
;The #If (!GetKeyState("NumLock", "T") and !GetKeyState("ScrollLock", "T")) is so the 2nd keeb NumPad things don't overlap with these.

^NumpadSub::
SoundGet, systemMasterVolume
InputBox, systemMasterVolume, Input Custom Volume, Input a custom volume. Current volume: %systemMasterVolume%.,, 200, 150,,,,, %systemMasterVolume%
if ErrorLevel = 1
	Tippy("CANCEL/Escape was pressed", 0.95)
else
	SoundSet, %systemMasterVolume%
return

;Change the step value of NumPad 2 and NumPad 8.
!NumPadSub::InputBox, Num2And8Step, Input Num2 and Num8 step value, Input Num2 and Num8 step value. Current value: %Num2And8Step%., , , , , , , , %Num2And8Step%

^Pause:: ;autoNumPadModeToggle hotkey. Technically ^NumLock. https://www.autohotkey.com/docs/KeyList.htm#numpad
autoNumPadModeToggle := !autoNumPadModeToggle
if (autoNumPadModeToggle = "1")
	Tippy("NumPad mode will be set automatically.", 2000)
else
	Tippy("NumPad is controlled by you now.", 2000)
return

;If NumLock is Off and ScrollLock is Off: MusicBee Mode.
#If (!GetKeyState("NumLock", "T") and !GetKeyState("ScrollLock", "T")) and !(getKeyState("F24", "P"))
{
;VD to the left/right.
$NumPad0::
$NumPadIns::Send, ^#{Left}
$NumPadDot::
$NumPadDel::Send, ^#{Right}

$NumPad1::return
$NumPadEnd::return

;Turns the volume down according to the "Num2And8Step" variable.
$NumPad2::SoundSet, -%Num2And8Step%
$NumPadDown::SoundSet, -%Num2And8Step%

$NumPad3::return
$NumPadPgdn::return

$NumPadAdd::changeVolume(1)
$NumPadEnter::changeVolume(-1)

$NumPad4::Send, {Media_Prev}
$NumPadLeft::Send, {Media_Prev}

$NumPad5::Send, {Media_Play_Pause}
$NumPadClear::Send, {Media_Play_Pause}

$NumPad6::Send, {Media_Next}
$NumPadRight::Send, {Media_Next}

$NumPad7::return
$NumPadHome::return

;Turns the volume up according to the "Num2And8Step" variable.
$NumPad8::SoundSet, +%Num2And8Step%
$NumPadUp::SoundSet, +%Num2And8Step%

$NumPad9::return
$NumPadPgup::return

$NumPadDiv::SoundSet, -1
$NumPadMult::SoundSet, +1

NumPadSub::saveAndRestoreVolumeLevel()
}

;If NumLock is On and ScrollLock is On: YouTube Mode.
#If (GetKeyState("NumLock", "T") and GetKeyState("ScrollLock", "T")) and !(getKeyState("F24", "P"))
{
;VD to the left/right.
$NumPad0::Send, ^#{Left}
$NumPadIns::Send, ^#{Left}
$NumPadDot::Send, ^#{Right}
$NumPadDel::Send, ^#{Right}

;Captions
$NumPad1::Send, c
$NumPadEnd::Send, c

;Turns the volume down according to the "Num2And8Step" variable.
$NumPad2::SoundSet, -%Num2And8Step%
$NumPadDown::SoundSet, -%Num2And8Step%

;Send f to make the YouTube video full screen
$NumPad3::Send, f
$NumPadPgdn::Send, f

$NumPadAdd::changeVolume(1)
$NumPadEnter::changeVolume(-1)

;Backwards five seconds.
$NumPad4::Send, {Left}
$NumPadLeft::Send, {Left}

;Play/pause
$NumPad5::Send, k
$NumPadClear::Send, k

;Forward five seconds.
$NumPad6::Send, {Right}
$NumPadRight::Send, {Right}

;Backwards ten seconds.
$NumPad7::Send, j
$NumPadHome::Send, j

;Turns the volume up according to the "Num2And8Step" variable.
$NumPad8::SoundSet, +%Num2And8Step%
$NumPadUp::SoundSet, +%Num2And8Step%

;Forwards ten seconds.
$NumPad9::Send, l
$NumPadPgup::Send, l

$NumPadDiv::SoundSet, -1
$NumPadMult::SoundSet, +1

NumPadSub::saveAndRestoreVolumeLevel()
}

;If NumLock is Off and ScrollLock is Off: Normal Mode.
#If (!GetKeyState("NumLock", "T") and !GetKeyState("ScrollLock", "T")) and !(getKeyState("F24", "P"))
{
$NumPad0::Send, {NumPad0}
$NumPadIns::Send, {NumPad0}

$NumPadDot::Send, {NumPadDot}
$NumPadDel::Send, {NumPadDot}

$NumPad1::Send, {NumPad1}
$NumPadEnd::Send, {NumPad1}

$NumPad2::Send, {NumPad2}
$NumPadDown::Send, {NumPad2}

$NumPad3::Send, {NumPad3}
$NumPadPgdn::Send, {NumPad3}

$NumPadAdd::Send, {NumPadAdd}
$NumPadEnter::Send, {NumPadEnter}

$NumPad4::Send, {NumPad4}
$NumPadLeft::Send, {NumPad4}

$NumPad5::Send, {NumPad5}
$NumPadClear::Send, {NumPad5}

$NumPad6::Send, {NumPad6}
$NumPadRight::Send, {NumPad6}

$NumPad7::Send, {NumPad7}
$NumPadHome::Send, {NumPad7}

$NumPad8::Send, {NumPad8}
$NumPadUp::Send, {NumPad8}

$NumPad9::Send, {NumPad9}
$NumPadPgup::Send, {NumPad9}

$NumPadDiv::Send, {NumPadDiv}
$NumPadMult::Send, {NumPadMult}

$NumPadSub::Send, {NumPadSub}
}

;If NumLock is Off and ScrollLock is On: Dumbed-down Mode.
;Designed for use with video sites that aren't YouTube and that have worse interfaces than YT, as well as less useful shortcuts like j, k, l, etc.
;Those have been transformed into ones that should work with most lower-budget and lower-quality video players.
; #If (numLockToggled = 0 and scrollLockToggled = 1) and !(getKeyState("F24", "P"))
#If (!GetKeyState("NumLock", "T") and GetKeyState("ScrollLock", "T")) and !(getKeyState("F24", "P"))
{
;VD to the left/right.
$NumPad0::
$NumPadIns::Send, ^#{Left}
$NumPadDot::
$NumPadDel::Send, ^#{Right}

;Mute.
$NumPad1::Send, m
$NumPadEnd::Send, m

;Turns the volume down according to the "Num2And8Step" variable.
$NumPad2::SoundSet, -%Num2And8Step%
$NumPadDown::SoundSet, -%Num2And8Step%

;Send f to make the video full screen
$NumPad3::Send, f
$NumPadPgdn::Send, f

$NumPadAdd::changeVolume(1)
$NumPadEnter::changeVolume(-1)

;Backwards five (usually) seconds.
$NumPad4::Send, {Left}
$NumPadLeft::Send, {Left}

;Play/pause
$NumPad5::Send, {Space}
$NumPadClear::Send, {Space}

;Forward five seconds.
$NumPad6::Send, {Right}
$NumPadRight::Send, {Right}

;Backwards ten seconds.
$NumPad7::Send, {Left 2}
$NumPadHome::Send, {Left 2}

;Turns the volume up according to the "Num2And8Step" variable.
$NumPad8::SoundSet, +%Num2And8Step%
$NumPadUp::SoundSet, +%Num2And8Step%

;Forwards ten seconds.
$NumPad9::Send, {Right 2}
$NumPadPgup::Send, {Right 2}

$NumPadDiv::SoundSet, -1
$NumPadMult::SoundSet, +1

NumPadSub::saveAndRestoreVolumeLevel()
}
#If

;Log volume scaling stuff: https://www.autohotkey.com/boards/viewtopic.php?t=38738
changeVolume(ud) { ;Called by NumPadAdd and NumPadEnter.
	fullVolumeTippy()
	static p := 20
	SoundGet, vol
	SoundSet, % vol * (1 + ud * p / 100)
}

;Allows the user to save the current volume level, and then return to it later. only used for NumPadSub.
;https://www.autohotkey.com/boards/viewtopic.php?f=76&t=10067
saveAndRestoreVolumeLevel()
{
    KeyWait, NumPadSub
    KeyWait, NumPadSub, D T0.1
	if ErrorLevel ;Timed out. I.e., single press.
	{
		;Save if not already set.
		if (savedNumMinusVol == "") {
			SoundGet, savedNumMinusVol
			Tippy("Saving volume", 600)
			return
		}

		;Restore Volume.
		SoundSet, savedNumMinusVol
		Tippy("Restoring volume", 600)
	}
	else ;Double press.
	{
		;Save volume if a double press.
		SoundGet, savedNumMinusVol
		Tippy("Saving volume", 600)
	}
	IniWrite, %savedNumMinusVol%, %MSR_CONFIG_PATH%, Miscellaneous, savedNumMinusVol
}

fullVolumeTippy() {
	SoundGet, systemMasterVolume
	if (systemMasterVolume = 100) {
		Tippy("The master volume is at 100%!", 1000)
		return
	}
}