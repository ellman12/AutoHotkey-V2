;Hotkeys for modifying text such as "This Is a Title" or "aRe YoU mOcKiNg Me?"
;Inspiration and code for this: https://autohotkey.com/board/topic/57888-title-case/ and https://autohotkey.com/board/topic/123994-capitalize-a-title/
^!t:: ;Converts text to Title Case.
Send, ^c
Sleep 90 ;Give time to store in Clipboard

;Makes the title in AHK's "Title Case", which in reality just capitalizes the first letter of each word.
StringUpper, NewTitle, Clipboard, T
head := SubStr(NewTitle, 1, 1)
tail := SubStr(NewTitle, 2)

;Stores the NewTitle in the Clipboard.             This is the list of words to NOT capitalize.
Clipboard := head RegExReplace(tail, "i)\b(a|an|and|at|but|by|for|in|nor|of|on|or|so|the|to|up|with|yet)\b", "$L1")

Send ^v
return

^!u:: ;Converts text to UPPER CASE.
Send, ^c
Sleep 90
StringUpper, NewTitle, Clipboard
Clipboard := NewTitle
Send, ^v
return

^!l:: ;Converts text to lower case.
Send, ^c
Sleep 90
StringLower, NewTitle, Clipboard
Clipboard := NewTitle
Send, ^v
return

^!s:: ;Converts text to Sentence case.
Send, ^c
Sleep 90
StringLower, NewTitle, Clipboard
Clipboard := RegExReplace(NewTitle, "((?:^|[.!?]\s+)[a-z])", "$u1")
Send, ^v
return

^!f:: ;Converts text to First Letter Capitalization.
Send, ^c
Sleep 90
StringUpper, NewTitle, Clipboard, T
Clipboard := NewTitle
Send, ^v
return

;Convert text to aLt CaSe, with the first letter being lower case.
;altCaseToggle is a toggle for if the alt case starts in lower case or not.
;A_LoopField is the single character at that point in the Parse Loop.
;0 = convert the char (A_LoopField) to lower...
;...1 = convert the char to UPPER.
^!a::
finalString :=
altCaseToggle := 0

Send, ^c
Sleep 90

;Loop through the contents of the Clipboard, and toggle between cases.
Loop, Parse, Clipboard
{
	if (altCaseToggle = 0) {
		if (A_LoopField = A_Space) {
			;If the current char is a space, don't toggle the var and just concatenate it to the finalString.
			finalString := finalString . A_Space
		} else {
			StringLower, strLwUpOutput, A_LoopField
			finalString := finalString . strLwUpOutput
			altCaseToggle := !altCaseToggle
		}
	} else if (altCaseToggle = 1) {
		if (A_LoopField = A_Space) {
			finalString := finalString . A_Space
		} else {
			StringUpper, strLwUpOutput, A_LoopField
			finalString := finalString . strLwUpOutput
			altCaseToggle := !altCaseToggle
		}
	}
}

Clipboard := finalString
Send, ^v
return

^!+a:: ;Convert text to AlT cAsE, with the first letter being UPPER case.
finalString := ""
altCaseToggle := 1

Send, ^c
Sleep 90

;Loop through the contents of the Clipboard, and toggle between cases.
Loop, Parse, Clipboard
{
	if (altCaseToggle = 0) {
		if (A_LoopField = A_Space) {
			finalString := finalString . A_Space
		} else {
			StringLower, strLwUpOutput, A_LoopField
			finalString := finalString . strLwUpOutput
			altCaseToggle := !altCaseToggle
		}
	} else if (altCaseToggle = 1) {
		if (A_LoopField = A_Space) {
			finalString := finalString . A_Space
		} else {
			StringUpper, strLwUpOutput, A_LoopField
			finalString := finalString . strLwUpOutput
			altCaseToggle := !altCaseToggle
		}
	}
}

Clipboard := finalString
Send, ^v
finalString := ""
return

^+s:: ;A d d s   a   s p a c e   b e t w e e n   l e t t e r s .
finalString := ""
Send, ^c
Sleep 90

;Loop through the contents of the Clipboard, and toggle between cases.
Loop, Parse, Clipboard
	finalString := finalString . A_LoopField . A_Space

Clipboard := finalString
Send, ^v
finalString := ""
return