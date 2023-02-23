;Makes the NumPad infinitely more useful by dynamically updating its actions based on the active program.

^NumpadSub::
SoundGet, systemMasterVolume
InputBox, systemMasterVolume, Input Custom Volume, Input a custom volume. Current volume: %systemMasterVolume%.,, 200, 150,,,,, %systemMasterVolume%
if ErrorLevel = 1
	Tippy("CANCEL/Escape was pressed", 0.95)
else
	SoundSet, %systemMasterVolume%
return

;Streaming mode: YouTube, Disney+, etc.
#If numPadMode = "Streaming"

$NumPad0::Send, ^#{Left}
$NumPadIns::Send, ^#{Left}
$NumPadDot::Send, ^#{Right}
$NumPadDel::Send, ^#{Right}

;Captions
$NumPad1::Send, c
$NumPadEnd::Send, c

;Decrease YT video speed.
$NumPad2::Send, +{SC033}
$NumPadDown::Send, +{SC033}

;Full screen
$NumPad3::Send, f
$NumPadPgdn::Send, f

$NumPadAdd::changeVolume(1)
$NumPadEnter::changeVolume(-1)

;Backwards five seconds
$NumPad4::Send, {Left}
$NumPadLeft::Send, {Left}

;Play/pause
$NumPad5::Send, k
$NumPadClear::Send, k

;Forward five seconds
$NumPad6::Send, {Right}
$NumPadRight::Send, {Right}

;Backwards ten seconds
$NumPad7::Send, j
$NumPadHome::Send, j

;Increase YT video speed
$NumPad8::Send, +{SC034}
$NumPadUp::Send, +{SC034}

;Forwards ten seconds
$NumPad9::Send, l
$NumPadPgUp::Send, l

$NumPadDiv::SoundSet, -1
$NumPadMult::SoundSet, +1

NumPadSub::saveAndRestoreVolumeLevel()


;Rider and VSCode
#If numPadMode = "Code"

;Show and focus terminal, or if focused, hide terminal.
NumLock::
Suspend, On
Send, ^{sc029}
Suspend, Off
return

$NumPad0::Send, ^d
$NumPadIns::Send, ^d
$NumPadDot::Send, ^u
$NumPadDel::Send, ^u

;CamelCase select to the left.
$NumPad1::Send, ^!+{Left}
$NumPadEnd::Send, ^!+{Left}

$NumPad2::Send, {Down}
$NumPadDown::Send, {Down}

;CamelCase select to the right.
$NumPad3::Send, ^!+{Right}
$NumPadPgdn::Send, ^!+{Right}

$NumPadAdd::changeVolume(1)
$NumPadEnter::changeVolume(-1)

;Previous word
$NumPad4::Send, ^{Left}
$NumPadLeft::Send, ^{Left}

;Show context actions.
$NumPad5::Send, ^.
$NumPadClear::Send, ^.

;Next word
$NumPad6::Send, ^{Right}
$NumPadRight::Send, ^{Right}

;Select previous word
$NumPad7::Send, ^+{Left}
$NumPadHome::Send, ^+{Left}

$NumPad8::Send, {Up}
$NumPadUp::Send, {Up}

;Select next word
$NumPad9::Send, ^+{Right}
$NumPadPgUp::Send, ^+{Right}

$NumPadDiv::Send, ^z
$NumPadMult::Send, ^y

;Delete line
NumPadSub::Send, ^+k

;A mix of Code and Music mode, meant more for doing text-based work in a program like Firefox.
#If GetKeyState("ScrollLock", "T")

$NumPad2::Send, {Down}
$NumPadDown::Send, {Down}

$NumPadAdd::changeVolume(1)
$NumPadEnter::changeVolume(-1)

;Previous word
$NumPad4::Send, ^{Left}
$NumPadLeft::Send, ^{Left}

;Next word
$NumPad6::Send, ^{Right}
$NumPadRight::Send, ^{Right}

;Select previous word
$NumPad7::Send, ^+{Left}
$NumPadHome::Send, ^+{Left}

$NumPad8::Send, {Up}
$NumPadUp::Send, {Up}

;Select next word
$NumPad9::Send, ^+{Right}
$NumPadPgUp::Send, ^+{Right}

;Change volume by 1
$NumPadDiv::Send, ^z
$NumPadMult::Send, ^y

NumPadSub::saveAndRestoreVolumeLevel()


#If numPadMode = "Music"

$NumPad0::Send, ^#{Left}
$NumPadIns::Send, ^#{Left}
$NumPadDot::Send, ^#{Right}
$NumPadDel::Send, ^#{Right}

$NumPad1::return
$NumPadEnd::return

$NumPad2::return
$NumPadDown::return

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

$NumPad8::return
$NumPadUp::return

$NumPad9::return
$NumPadPgUp::return

;Change volume by 1
$NumPadDiv::SoundSet, -1
$NumPadMult::SoundSet, +1

NumPadSub::saveAndRestoreVolumeLevel()

#If


;Log volume scaling stuff: https://www.autohotkey.com/boards/viewtopic.php?t=38738
changeVolume(ud) { ;Called by NumPadAdd and NumPadEnter and volume wheel on K95.
	static p := 20
	SoundGet, vol
	SoundSet, % vol * (1 + ud * p / 100)
	
	SoundGet, systemMasterVolume
	if (systemMasterVolume = 100) {
		Tippy("The master volume is at 100%!", 700)
		return
	}
}

;Allows the user to save the current volume level, and then return to it later. Only used for NumPadSub.
;https://www.autohotkey.com/boards/viewtopic.php?f=76&t=10067
saveAndRestoreVolumeLevel()
{
	static DELAY := 1400
    KeyWait, NumPadSub
    KeyWait, NumPadSub, D T0.1
	if ErrorLevel ;Timed out. I.e., single press.
	{
		;Save if not already set.
		if (savedNumMinusVol == "") {
			SoundGet, savedNumMinusVol
			Tippy("Saving volume of " + Round(savedNumMinusVol, 2), DELAY)
			return
		}

		;Restore Volume.
		SoundSet, savedNumMinusVol
		Tippy("Restoring volume of " + Round(savedNumMinusVol, 2), DELAY)
	}
	else ;Double press.
	{
		;Save volume if a double press.
		SoundGet, savedNumMinusVol
		Tippy("Saving volume of " + Round(savedNumMinusVol, 2), DELAY)
	}
}