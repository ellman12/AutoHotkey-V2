;Used for making the use of ToolTips a lot simpler and easier.
Tippy(Text, Duration) {
	ToolTip, %Text%
	Sleep %Duration%
	ToolTip ;Remove the ToolTip.
}