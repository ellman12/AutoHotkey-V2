# Documentation
## Conventions for Modules
`Initialization files` contain code to be ran in the auto-execute section and thus must come before the hotkey files. By convention these files end in `.h.ahk`.<br>
`Hotkey files` include hotkeys, labels, and anything else that must come after auto-execute. By convention these files end in just `.ahk`.<br>

## Steps for Adding an Item to Main Settings GUI
&nbsp;1. Add control(s) with variables to the GUI in `MainSettings.h.ahk`. Also a good idea to define a global variable in auto-execute with the same name.<br>
&nbsp;2. Add an `IniWrite` in `writeConfigFile()` in the same file. This allows the variable to be saved on exit and read on startup.<br>
&nbsp;3. Add an `IniRead` in `readConfigFile()` in the same file, plus its default value. Default value is needed if the user ever decides to reset the settings to their default values.<br>
&nbsp;4. Add a `GuiControl` in `setMainGUIValues()` in the same file. This allows the GUI control to have this value picked on startup.
