# AutoHotkey-V2

AutoHotkey-V2 is a significantly refined and improved version of my original AutoHotkey repo.<br>
AHK-V2 aims to be slimmer, more organized, and more modular. Modularity makes it easier to add/remove different files and also makes it easier for others to use these script(s) in their own scripts if desired.<br>

## Documentation
### Conventions for Modules
Initialization files contain code to be ran in the auto-execute section and thus must come before the hotkey files. By convention these files end in .h.ahk<br>
Hotkey files include hotkeys, labels, and anything else that must come after auto-execute. By convention these files end in just .ahk.<br>

In AHK-V1's Main Script, all the initialization stuff was dumped at the top of the Main file which made it unnecessarily long and cluttered. But here, by just #Including the .h.ahk and/or .ahk file, Main in V2 is significantly shorter and more organized.

### Steps for Adding an Item to Main Settings GUI
&nbsp;1. Add control(s) with variables to the GUI in MainSettings.h.ahk. Also a good idea to define a (global?) variable in auto-execute with the same name (what I do anyways).<br>
&nbsp;2. Add an IniWrite in writeConfigFile() in the same file. This allows the variable to be saved on exit and read on startup.<br>
&nbsp;3. Add an IniRead in readConfigFile() in the same file, plus its default value. Default value is needed if user (me) ever decides to reset the settings to their default values.<br>
&nbsp;4. Add a GuiControl in setMainGUIValues() in the same file. This allows the GUI control to have this value picked on startup.

## History + Why Do All of This?
It's hard to remember all this stuff even though they weren't even that long ago.<br>
I think it all started around 2015-2016 when I was getting into Minecraft modding (for some reason) and wanted more keyboard buttons to assist with all the UIs and other stuff that mods added. Don't remember how I came across the K95 and I can't remember if the keeb or the mouse came first. Ironically never figured out how to use the extra buttons though because I was an idiot and tried pressing the macro buttons in-game without having anything assigned to them thinking they would do anything. I'm sure I tried to use the software to do something but probably never figured it out and just gave up.<br>
I'm not sure where, when, or why the macro and keyboard shortcut obsession started but it was probably around 2017-2018 once I started poking around in the Corsair software out of curiosity and realized how insanely powerful keyboard shortcuts could be when used like this. I had never used the extra side buttons and figured I would give it a shot. I think in 2015-2016 it was the original CUE (v1) which was infamously terrible. CUE 2 though was pretty good once you figured it out and it got the job done.

### Timeline
2015/2016—acquire K95 RGB and M65 mouse.<br>
2017/2018—Actually figure out how to use the terrible and unintuitive Corsair software. Start looking into how I can use the software.<br>
October 8, 2019—My first GitHub repo created: AHK-V1. Also, AutoHotkey scripts existed a little bit before then I think, but they were extremely rough and terrible.<br>
May 29, 2019—Replace M65 with Scimitar Pro RGB (bigger, more comfortable, 14 extra buttons instead of my M65 RGB's 5 extra buttons).<br>
Setup 2nd keyboard sometime here I think. Eventually stopped using it because it didn't work very well (Stream Deck is replacing it and K95 macro buttons).
December 25, 2021—finally acquired Elgato Stream Deck XL and began this repo. A good amount of stuff copied from old repo. Also moving away from using K95 buttons in favor of Stream Deck XL.

AutoHotkey has completely changed my workflow and way of going about doing tasks on a computer. In addition to making my work easier, it has also helped me to learn and practice many important programming conventions and skills, such as DRY (Don't Repeat Yourself), KISS (Keep It Simple, Stupid), planning before programming, and how to use git and GitHub professionally and smartly. Terrible language by design but amazing tool when it does work. I think this language has also helped me improve my muscle(?) memory tenfold. My macros and shortcuts are very deeply ingrained in my muscle memory.

This is my magnum opus.