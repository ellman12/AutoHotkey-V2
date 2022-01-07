;This script is awesome. Here's a link to the video where I found this: https://www.youtube.com/watch?v=TRJDB3nM3bg&feature=em-uploademail
/*
	Written By: Hellbent
	Date Started: June 24th, 2019
	Date of last edit: Oct 30th, 2019
	Name: Clipboard Master v2.1.1 (Release Version)
*/

#SingleInstance,Ignore
#NoEnv
ListLines,Off
SetBatchLines,-1
CoordMode,Mouse,Screen
Gdip_Startup()
OnExit,GuiClose
global Classic:=0, ColorSet:=[]


;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     User Defined Options / Settings     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

;==============================================================================


global Enable_Master_Hotkey_Lock_Saved_Data := 0   ;<----- Set this to 1 to make it possible for saved hotkeys to work as soon as you run the script.


;==============================================================================


;Optional Exit Hotkey. Activate (Remove the ";") and change the hotkey as you see fit. 
;Hotkey , *^ESC , GuiClose , On  


;==============================================================================


;===================== Color ======================
;~ colorSet:=["22aa22","22aa22","22aa22","22aa22","2A6C2C"]  ; <============= Green Theme 1
;~ colorSet:=["5DFE37","5DFE37","5DFE37","5DFE37","5DFE37"]  ; <============= Green Theme 2 
;~ colorSet:=["0077aa","0077aa","0077aa","0077aa","0077aa"]  ; <============= Blue Theme 1
;~ colorSet:=["00FFFF","00FFFF","00FFFF","00FFFF","00FFFF"]  ; <============= Blue Theme 2 
;~ colorSet:=["FFD80C","FFD80C","FFD80C","FFD80C","FFD80C"]  ; <============= Yellow Theme 1
;~ colorSet:=["FCF68F","FCF68F","FCF68F","FCF68F","FCF68F"]  ; <============= Yellow Theme 2 
;~ colorSet:=["FFA23B","FFA23B","FFA23B","FFA23B","FFA23B"]  ; <============= Orange Theme 1
colorSet:=["E3A409","E3A409","E3A409","E3A409","E3A409"]  ; <============= Orange Theme 2
;~ colorSet:=["ACBEF6","ACBEF6","ACBEF6","ACBEF6","ACBEF6"]  ; <============= Pale Purple Theme
;~ colorSet:=["F1047E","F1047E","F1047E","F1047E","F1047E"]  ; <============= Pink Theme 
;~ Loop, 5
	;~ colorSet[A_Index]:="00FF00"
;=================================================================================================

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



IfNotExist,%A_ScriptDir%\Clipboard Master Save Folder
	FileCreateDir,%A_ScriptDir%\Clipboard Master Save Folder
SetWorkingDir,%A_ScriptDir%\Clipboard Master Save Folder
global ClipArray:=[]
Loop,30	{
	IfExist,%A_WorkingDir%\Saved Clip %A_Index%.txt
	{
		FileRead,Temp,%A_WorkingDir%\Saved Clip %A_Index%.txt
		ClipArray[A_Index]:=temp,temp:=""
	}
}
global HB_Button:=[],ToggleTips,ToggleHotkeyLock,HotkeyLocks:=[],Indicators:=[],Tab,PreviewWindow:={},WinFade,PreviewEditHwnd,EnableSettingsTips:={},EnableSounds:={},EnableClipView:={},ClipViewTime:=2,SaveHK1,SaveHK2,SaveHK3,SaveHK4,SaveHK5,SaveHK6,SaveHK7,SaveHK8,SaveHK9,SaveHK10,ClipHK1,ClipHK2,ClipHK3,ClipHK4,ClipHK5,ClipHK6,ClipHK7,ClipHK8,ClipHK9,ClipHK10,SHK1,SHK2,SHK3,SHK4,SHK5,SHK6,SHK7,SHK8,SHK9,SHK10,CHK1,CHK2,CHK3,CHK4,CHK5,CHK6,CHK7,CHK8,CHK9,CHK10,CBM1,CBM2,switchTabs,HideWin,telePortWin,OpenSlotHK
global AllHotkeysLock:={},Clip_Hotkeys_Locks:=[],Save_Hotkeys_Locks:=[],ToggleSaveHotkeys:={},ToggleClipHotkeys:={},EnableClipView:={},TPWINLOCK:={},TPWINHK,HWINLOCK:={},HWINHK,STHK,STHLLOCK:={},SettingsTipEdit,ClipViewTimeHwnd,SaveToOpenSlotHK,SaveToOpenSlotLock:={},ClipMasterHotkeyLock1:={},CBM1HK,ClipMasterHotkeyLock2:={},CBM2HK,PHARR:={},Tar:=[]
gosub,UpdateLocksWithSavedData 
global Main := New Custom_Window( x:= 0 , y:= 0 , w:= 740 , h:= 323 , Name:= "1" , Options:= "+AlwaysOnTop -Caption -DPIScale +Toolwindow" , Title:= "HB Clipboard Master v2" , Background_Bitmap:= Main_Window() )
Gui,1:Add,Text,x5 y5 w150 h40 BackgroundTrans hwndMoveWindowHwnd gMove_Window
ToggleTips:=New Flat_Round_Switch_Type_1(x:=170,y:=20,w:=100,Text:="Enable Tips",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="38393C",State:=0,Label:="ToggleTips",Type:="ToggleTips")
ToggleHotkeyLock:=New Flat_Round_Switch_Type_1(x+=w+10,y,w:=105,Text:="      Toggle Hotkey Locks",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="38393C",State:=1,Label:="ToggleHotkeysLocks",Type:="ToggleHotkeysLocks")
Tab:=New Dark_3_Tabs_1(x:=415, y:=15, window:="1", label:="Change_Tabs", Selected_Tab:=1, Background_Color:="333437",Font_Color:=colorSet[1])
Panel1:=New NumClass(x:=26,y:=66,window:="1",Font_Color:=(Classic)?("16508B"):(colorSet[1]))
Panel1.Draw_1()
Panel2:=New NumClass(x:=386,y:=66,window:="1",Font_Color:=(Classic)?("16508B"):(colorSet[1]))
Panel2.Draw_2()
Indicators.Push(New Indicator(x:=61,y:=69,Window:="1",Tab1_Value:=(ClipArray[1])?(1):(0),Tab2_Value:=(ClipArray[11])?(1):(0),Tab3_Value:=(ClipArray[21])?(1):(0),Indicator_Color:=colorSet[1]))
Indicators.Push(New Indicator(x,y+=41,Window:="1",Tab1_Value:=(ClipArray[2])?(1):(0),Tab2_Value:=(ClipArray[12])?(1):(0),Tab3_Value:=(ClipArray[22])?(1):(0),Indicator_Color:=colorSet[1]))
Indicators.Push(New Indicator(x,y+=41,Window:="1",Tab1_Value:=(ClipArray[3])?(1):(0),Tab2_Value:=(ClipArray[13])?(1):(0),Tab3_Value:=(ClipArray[23])?(1):(0),Indicator_Color:=colorSet[1]))
Indicators.Push(New Indicator(x,y+=41,Window:="1",Tab1_Value:=(ClipArray[4])?(1):(0),Tab2_Value:=(ClipArray[14])?(1):(0),Tab3_Value:=(ClipArray[24])?(1):(0),Indicator_Color:=colorSet[1]))
Indicators.Push(New Indicator(x,y+=41,Window:="1",Tab1_Value:=(ClipArray[5])?(1):(0),Tab2_Value:=(ClipArray[15])?(1):(0),Tab3_Value:=(ClipArray[25])?(1):(0),Indicator_Color:=colorSet[1]))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=100, y:=69, w:=30, h:=30, window:="1", Label:="AddNewClip", Text:="+", Font:="Arial", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset:=1, Type:="Add" ))
Loop 4
	HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=100, y+=h+11, w:=30, h:=30, window:="1", Label:="AddNewClip", Text:="+", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[1], Font_Color_Bottom, Background_Color:="333437", y_Offset:=1, Type:="Add" ))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=145, y:=69, w:=30, h:=30, window:="1", Label:="RemoveClip", Text:="_", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[2], Font_Color_Bottom, Background_Color:="333437", y_Offset:=-3, Type:="Remove" ))
Loop 4
	HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h+11, w:=30, h:=30, window:="1", Label:="RemoveClip", Text:="_", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[2], Font_Color_Bottom, Background_Color:="333437", y_Offset:=-3, Type:="Remove" ))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=190, y:=69, w:=50, h:=30, window:="1", Label:="ViewIt", Text:="View", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[3], Font_Color_Bottom, Background_Color:="333437", y_Offset:=0, Type:="View" ))
Loop 4
	HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h+11, w:=50, h:=30, window:="1", Label:="ViewIt", Text:="View", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[3], Font_Color_Bottom, Background_Color:="333437", y_Offset:=0, Type:="View" ))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=255, y:=69, w:=50, h:=30, window:="1", Label:="ClipIt", Text:="Clip", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[4], Font_Color_Bottom, Background_Color:="333437", y_Offset:=0, Type:="Clip" ))
Loop 4
	HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h+11, w:=50, h:=30, window:="1", Label:="ClipIt", Text:="Clip", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[4], Font_Color_Bottom, Background_Color:="333437", y_Offset:=0, Type:="Clip" ))
HotkeyLocks.Push(New Flat_Round_Switch_Type_1(x:=320,y:=75,w:=30,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",State:=0,Label:="Update_LocksValue",Type:="Lock_Clip",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
Loop 4
	HotkeyLocks.Push(New Flat_Round_Switch_Type_1(x:=320,y+=h+11,w:=30,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",State:=0,Label:="Update_LocksValue",Type:="Lock_Clip",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
Indicators.Push(New Indicator(x:=421,y:=69,Window:="1",Tab1_Value:=(ClipArray[6])?(1):(0),Tab2_Value:=(ClipArray[16])?(1):(0),Tab3_Value:=(ClipArray[26])?(1):(0),Indicator_Color:=colorSet[1]))
Indicators.Push(New Indicator(x,y+=41,Window:="1",Tab1_Value:=(ClipArray[7])?(1):(0),Tab2_Value:=(ClipArray[17])?(1):(0),Tab3_Value:=(ClipArray[27])?(1):(0),Indicator_Color:=colorSet[1]))
Indicators.Push(New Indicator(x,y+=41,Window:="1",Tab1_Value:=(ClipArray[8])?(1):(0),Tab2_Value:=(ClipArray[18])?(1):(0),Tab3_Value:=(ClipArray[28])?(1):(0),Indicator_Color:=colorSet[1]))
Indicators.Push(New Indicator(x,y+=41,Window:="1",Tab1_Value:=(ClipArray[9])?(1):(0),Tab2_Value:=(ClipArray[19])?(1):(0),Tab3_Value:=(ClipArray[29])?(1):(0),Indicator_Color:=colorSet[1]))
Indicators.Push(New Indicator(x,y+=41,Window:="1",Tab1_Value:=(ClipArray[10])?(1):(0),Tab2_Value:=(ClipArray[20])?(1):(0),Tab3_Value:=(ClipArray[30])?(1):(0),Indicator_Color:=colorSet[1]))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=460, y:=69, w:=30, h:=30, window:="1", Label:="AddNewClip", Text:="+", Font:="Arial", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset:=1, Type:="Add" ))
Loop 4
	HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=460, y+=h+11, w:=30, h:=30, window:="1", Label:="AddNewClip", Text:="+", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[1], Font_Color_Bottom, Background_Color:="333437", y_Offset:=1, Type:="Add" ))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=505, y:=69, w:=30, h:=30, window:="1", Label:="RemoveClip", Text:="_", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[2], Font_Color_Bottom, Background_Color:="333437", y_Offset:=-3, Type:="Remove" ))
Loop 4
	HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h+11, w:=30, h:=30, window:="1", Label:="RemoveClip", Text:="_", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[2], Font_Color_Bottom, Background_Color:="333437", y_Offset:=-3, Type:="Remove" ))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=550, y:=69, w:=50, h:=30, window:="1", Label:="ViewIt", Text:="View", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[3], Font_Color_Bottom, Background_Color:="333437", y_Offset:=0, Type:="View" ))
Loop 4
	HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h+11, w:=50, h:=30, window:="1", Label:="ViewIt", Text:="View", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[3], Font_Color_Bottom, Background_Color:="333437", y_Offset:=0, Type:="View" ))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=615, y:=69, w:=50, h:=30, window:="1", Label:="ClipIt", Text:="Clip", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[4], Font_Color_Bottom, Background_Color:="333437", y_Offset:=0, Type:="Clip" ))
Loop 4
	HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h+11, w:=50, h:=30, window:="1", Label:="ClipIt", Text:="Clip", Font:="Arial", Font_Size, Font_Color_Top:=colorSet[4], Font_Color_Bottom, Background_Color:="333437", y_Offset:=0, Type:="Clip" ))
HotkeyLocks.Push(New Flat_Round_Switch_Type_1(x:=680,y:=75,w:=30,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",State:=0,Label:="Update_LocksValue",Type:="Lock_Clip",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
Loop 4
	HotkeyLocks.Push(New Flat_Round_Switch_Type_1(x,y+=h+11,w:=30,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",State:=0,Label:="Update_LocksValue",Type:="Lock_Clip",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=23, y:=284, w:=108, h:=29, window:="1", Label:="Create_Settings_Window", Text:="Hotkeys & Settings", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset:=-2,Type:="Settings Menu"))
;*********************************************************

;      <><><>  Free Button  <><><>
HB_Button.Push(New Clipboard_Master_v2_Buttons(x+=w+0, y, w, h, window:="1", Label:="", Text:="Reserved", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="Reserved" ))

;*********************************************************
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=263, y:=284, w:=108, h:=29, window:="1", Label:="OpenSavedClipsFolder", Text:="Open Folder", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="Open Folder"))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x+=w+0, y, w, h, window:="1", Label:="DeleteClips", Text:="Delete Clips", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="Delete Clips" ))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=503, y:=284, w:=108, h:=29, window:="1", Label:="APPENDCBM1PREP", Text:="Clip Master 1", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="CBM"))
HB_Button.Push(New Clipboard_Master_v2_Buttons(x+=w+0, y, w, h, window:="1", Label:="APPENDCBM2PREP", Text:="Clip Master 2", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="CBM" ))
Gui,1:Color,333437,333437
Gui,1:Font,cWhite s9, Segoe ui
Gui,1:Add,Text,x30 y330 w680 h60 Center vTipsEdit,
gosub,UpdateLocksWithSavedData 
GuiControl,1:Focus,% HB_Button[1].Hwnd
Create_Preview(),Create_Settings_Window(),Main.Show_Window()
gosub,ActiveHKOnStartup
SetTimer,Tips,Off
SetTimer,HB_Button_Hover,50
return
GuiClose:
	Suspend,Permit
	Gui,1:Hide
	gosub,Save_Main_Locks
	ExitApp

UpdateLocksWithSavedData:
	ttabs:=1
	Loop,3	{
		Loop,10	{
			if(ttabs=1){
				IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,Lock%A_Index%Tab%ttabs%_Value
				HotkeyLocks[A_Index].Tab1_Value:=temp,HotkeyLocks[A_Index].State:=!HotkeyLocks[A_Index].Tab1_Value,HotkeyLocks[A_Index].Switch_State()
			}else if(ttabs=2){
				IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,Lock%A_Index%Tab%ttabs%_Value
				HotkeyLocks[A_Index].Tab2_Value:=temp
			}else if(ttabs=3){
				IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,Lock%A_Index%Tab%ttabs%_Value
				HotkeyLocks[A_Index].Tab3_Value:=temp
			}
		}
		ttabs++
	}
	return
	
Save_Main_Locks:
	tb:=1
	Loop,3	{
		Loop,10	{
			if(tb=1){
				temp:=HotkeyLocks[A_Index].Tab1_Value
				IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,Lock%A_Index%Tab%tb%_Value
			}else if(tb=2){
				temp:=HotkeyLocks[A_Index].Tab2_Value
				IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,Lock%A_Index%Tab%tb%_Value
			}else if(tb=3){
				temp:=HotkeyLocks[A_Index].Tab3_Value
				IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,Lock%A_Index%Tab%tb%_Value
			}
		}
		tb++
	}
	return

Move_Window(){
	SetTimer,HB_Button_Hover,Off
	PostMessage,0xA1,2
	While(GetKeyState("LButton"))
		sleep 20
	SetTimer,HB_Button_Hover,On
}

GuiContextMenu:
	if(TogWinTab:=!TogWinTab){
		Gui,1:Show,w160 h50 NA
		SetTimer,Tips,Off
		SetTimer,HB_Button_Hover,Off
	}else	{
		if(ToggleTips.State){
			Gui,1:Show,w740 h400 NA
			SetTimer,Tips,On
			SetTimer,HB_Button_Hover,On
		}else	{
			Gui,1:Show,w740 h323 NA
			SetTimer,HB_Button_Hover,On
		}
	}
	return

ToggleTips:
	if(ToggleTips.State){
		SetTimer,Tips,On
		Gui,1:Show,w740 h400 
	}else	{
		SetTimer,Tips,Off
		Gui,1:Show,w740 h323
	}
	return
	
ToggleHotkeysLocks:
	if(GetKeyState("Shift")){
		if(ToggleHotkeyLock.State){
			Loop,10	{
				HotkeyLocks[A_Index].State:=0,HotkeyLocks[A_Index].Switch_State()
				(Tab.Tab=1)?(HotkeyLocks[A_Index].Tab1_Value := HotkeyLocks[A_Index].State):(Tab.Tab=2)?(HotkeyLocks[A_Index].Tab2_Value := HotkeyLocks[A_Index].State):(Tab.Tab=3)?(HotkeyLocks[A_Index].Tab3_Value := HotkeyLocks[A_Index].State)
			}
		}else	{
			Loop,10	{
				HotkeyLocks[A_Index].State:=1,HotkeyLocks[A_Index].Switch_State()
				(Tab.Tab=1)?(HotkeyLocks[A_Index].Tab1_Value := HotkeyLocks[A_Index].State):(Tab.Tab=2)?(HotkeyLocks[A_Index].Tab2_Value := HotkeyLocks[A_Index].State):(Tab.Tab=3)?(HotkeyLocks[A_Index].Tab3_Value := HotkeyLocks[A_Index].State)
			}
		}
	}
	return

DeleteClips:
	if(GetKeyState("Ctrl")&&GetKeyState("Shift")){
		if(Tab.Tab=1){
			Loop,10	{
				if(ClipArray[A_Index]&&!HotkeyLocks[A_Index].Tab1_Value){
					FileDelete,% A_WorkingDir "\Saved Clip " A_Index ".txt"
					Indicators[A_Index].Tab1_Value:=0,Indicators[A_Index].Draw_Off(),ClipArray[A_Index]:=""
				}
			}
			if(EnableSounds.State)
				SoundBeep,500
			return
		}else if(Tab.Tab=2){
			Loop,10	{
				if(ClipArray[A_Index+10]&&!HotkeyLocks[A_Index].Tab2_Value){
					FileDelete,% A_WorkingDir "\Saved Clip " A_Index+10 ".txt"
					Indicators[A_Index].Tab2_Value:=0,Indicators[A_Index].Draw_Off(),ClipArray[A_Index+10]:=""
				}
			}
			if(EnableSounds.State)
				SoundBeep,500
			return
		}else if(Tab.Tab=3){
			Loop,10	{
				if(ClipArray[A_Index+20]&&!HotkeyLocks[A_Index].Tab3_Value){
					FileDelete,% A_WorkingDir "\Saved Clip " A_Index+20 ".txt"
					Indicators[A_Index].Tab3_Value:=0,Indicators[A_Index].Draw_Off(),ClipArray[A_Index+20]:=""
				}
			}
			if(EnableSounds.State)
				SoundBeep,500
			return
		}
	}else	{
		if(EnableSounds.State)
			Loop, 3
				SoundBeep,777
	}
	return
	
Change_Tabs:
	Loop,10	
		(Tab.Tab=1)?(HotkeyLocks[A_Index].State:=!HotkeyLocks[A_Index].Tab1_Value,HotkeyLocks[A_Index].Switch_State(),((Indicators[A_Index].Tab1_Value=1)?(Indicators[A_Index].Draw_On()):(Indicators[A_Index].Draw_Off()))):(Tab.Tab=2)?(HotkeyLocks[A_Index].State:=!HotkeyLocks[A_Index].Tab2_Value,HotkeyLocks[A_Index].Switch_State(),((Indicators[A_Index].Tab2_Value=1)?(Indicators[A_Index].Draw_On()):(Indicators[A_Index].Draw_Off()))):(Tab.Tab=3)?(HotkeyLocks[A_Index].State:=!HotkeyLocks[A_Index].Tab3_Value,HotkeyLocks[A_Index].Switch_State(),((Indicators[A_Index].Tab3_Value=1)?(Indicators[A_Index].Draw_On()):(Indicators[A_Index].Draw_Off())))
	(Tab.Tab=1)?(Panel1.Draw_1(),Panel2.Draw_2()):(Tab.Tab=2)?(Panel1.Draw_3(),Panel2.Draw_4()):(Tab.Tab=3)?(Panel1.Draw_5(),Panel2.Draw_6())
	return
	
OpenSavedClipsFolder(){
	try
		Run,% A_WorkingDir
}

AddNewClip(){  
	MouseGetPos,,,,tctrl,2
	Loop,% HB_Button.Length()	{
		if(HB_Button[A_Index].Hwnd=tctrl){
			if(GetKeyState("Shift")){
				if(A_Index<6){
					FileDelete,% A_WorkingDir "\Saved Clip " A_Index + (Tab.Tab*10-10) ".txt"
					FileAppend,%Clipboard%,% A_WorkingDir "\Saved Clip " A_Index + (Tab.Tab*10-10) ".txt"
					ClipArray[A_Index + (Tab.Tab*10-10)]:=Clipboard
					(Tab.Tab=1)?(Indicators[A_Index].Tab1_Value:=1,Indicators[A_Index].Draw_On()):(Tab.Tab=2)?(Indicators[A_Index].Tab2_Value:=1,Indicators[A_Index].Draw_On()):(Tab.Tab=3)?(Indicators[A_Index].Tab3_Value:=1,Indicators[A_Index].Draw_On())
					
				}else if(A_Index>6){
					FileDelete,% A_WorkingDir "\Saved Clip " (A_Index-15) + (Tab.Tab*10-10) ".txt"
					FileAppend,%Clipboard%,% A_WorkingDir "\Saved Clip " (A_Index-15) + (Tab.Tab*10-10) ".txt"
					ClipArray[(A_Index-15) + (Tab.Tab*10-10)]:=Clipboard
					(Tab.Tab=1)?(Indicators[A_Index-15].Tab1_Value:=1,Indicators[A_Index-15].Draw_On()):(Tab.Tab=2)?(Indicators[A_Index-15].Tab2_Value:=1,Indicators[A_Index-15].Draw_On()):(Tab.Tab=3)?(Indicators[A_Index-15].Tab3_Value:=1,Indicators[A_Index-15].Draw_On())
				}
				if(EnableSounds.State)
					SoundBeep,500
			}else 	{
				if(EnableSounds.State)
					loop 3
						SoundBeep, 777
			}
		}
	}
}

RemoveClip(){  
	MouseGetPos,,,,tctrl,2
	Loop,% HB_Button.Length()	{
		if(HB_Button[A_Index].Hwnd=tctrl){
			if(GetKeyState("Shift")){
				if(A_Index<11){
					FileDelete,% A_WorkingDir "\Saved Clip " (A_Index-5) + (Tab.Tab*10-10) ".txt"
					ClipArray[(A_Index-5) + (Tab.Tab*10-10)]:=""
					(Tab.Tab=1)?(Indicators[A_Index-5].Tab1_Value:=0,Indicators[A_Index-5].Draw_Off()):(Tab.Tab=2)?(Indicators[A_Index-5].Tab2_Value:=0,Indicators[A_Index-5].Draw_Off()):(Tab.Tab=3)?(Indicators[A_Index-5].Tab3_Value:=0,Indicators[A_Index-5].Draw_Off())
					
				}else if(A_Index>11){
					FileDelete,% A_WorkingDir "\Saved Clip " (A_Index-20) + (Tab.Tab*10-10) ".txt"
					ClipArray[(A_Index-20) + (Tab.Tab*10-10)]:=""
					(Tab.Tab=1)?(Indicators[A_Index-20].Tab1_Value:=0,Indicators[A_Index-20].Draw_Off()):(Tab.Tab=2)?(Indicators[A_Index-20].Tab2_Value:=0,Indicators[A_Index-20].Draw_Off()):(Tab.Tab=3)?(Indicators[A_Index-20].Tab3_Value:=0,Indicators[A_Index-20].Draw_Off())
				}
				if(EnableSounds.State)
					SoundBeep, 500
			}else 	{
				if(EnableSounds.State)
					loop 3
						SoundBeep, 777
			}
		}
	}
}

ClipIt(){
	MouseGetPos,,,,tctrl,2
	Loop,% HB_Button.Length()	{
		if(HB_Button[A_Index].Hwnd=tctrl){
			if(A_Index<21){
				if(ClipArray[A_Index-15 + (Tab.Tab*10-10)]){
					Clipboard:=	ClipArray[A_Index-15 + (Tab.Tab*10-10)]
					ClipWait,
					if(EnableSounds.State)
						SoundBeep, 500
				}else	{
					if(EnableSounds.State)
						loop,3
							SoundBeep,777
				}
			}else if(A_Index>21){
				if(ClipArray[A_Index-30 + (Tab.Tab*10-10)]){
					Clipboard:=	ClipArray[A_Index-30 + (Tab.Tab*10-10)]
					ClipWait,
					if(EnableSounds.State)
						SoundBeep, 500
				}else	{
					if(EnableSounds.State)
						loop,3
							SoundBeep,777
				}
			}
		}
	}
}

ViewIt(){
	MouseGetPos,,,,tctrl,2
	Loop,% HB_Button.Length()	{
		if(HB_Button[A_Index].Hwnd=tctrl){
			if(GetKeyState("Shift")&&GetKeyState("ctrl")){
				if(A_Index<16&&ClipArray[(A_Index-10)+(Tab.Tab*10-10)]){
					try
						Run,% A_WorkingDir "\Saved Clip " (A_Index-10)+(Tab.Tab*10-10) ".txt"
					return
				}else if(A_Index<16&&!ClipArray[(A_Index-10)+(Tab.Tab*10-10)]){
					if(EnableSounds.State)
						Loop, 3
							SoundBeep,777
					return
				}else if(A_Index>16&&ClipArray[(A_Index-25)+(Tab.Tab*10-10)]){
					try
						Run,% A_WorkingDir "\Saved Clip " (A_Index-25)+(Tab.Tab*10-10) ".txt"
					return	
				}else if(A_Index>16&&!ClipArray[(A_Index-25)+(Tab.Tab*10-10)]){
					if(EnableSounds.State)
						Loop, 3
							SoundBeep,777
					return	
				}
			}
			if(A_Index<16){
				if(ClipArray[(A_Index-10)+(Tab.Tab*10-10)]){
					Show_Preview(ClipArray[(A_Index-10)+(Tab.Tab*10-10)])
					return	
				}else	{
					if(EnableSounds.State)
						Loop, 3
							SoundBeep,777
					return	
				}
			}else if(A_Index>16){
				if(ClipArray[(A_Index-25)+(Tab.Tab*10-10)]){
					Show_Preview(ClipArray[(A_Index-25)+(Tab.Tab*10-10)])
					return	
				}else	{
					if(EnableSounds.State)
						Loop, 3
							SoundBeep,777
					return	
				}
			}
		}
	}
}

Update_LocksValue:
	MouseGetPos,,,,lctrl,2
	if(Tab.Tab=1){
		Loop,10	{
			if(HotkeyLocks[A_Index].Hwnd=lctrl)
				HotkeyLocks[A_Index].Tab1_Value:=HotkeyLocks[A_Index].State
		}
	}else if(Tab.Tab=2){
		Loop,10	{
			if(HotkeyLocks[A_Index].Hwnd=lctrl)
				HotkeyLocks[A_Index].Tab2_Value:=HotkeyLocks[A_Index].State
		}
	}else if(Tab.Tab=3){
		Loop,10	{
			if(HotkeyLocks[A_Index].Hwnd=lctrl)
				HotkeyLocks[A_Index].Tab3_Value:=HotkeyLocks[A_Index].State
		}
	}
	return

Tips(){
	static LActive
	MouseGetPos,cmx,cmy,,ctrl,2
	WingetPos,wx,wy,,,% "ahk_Id" Main.hwnd
	if(LActive!=ctrl){
		Loop,% HB_Button.Length()	{
			if(HB_Button[A_Index].Hwnd=ctrl){
				if(HB_Button[A_Index].Type="Minimize Window"){
					GuiControl,1:,TipsEdit,Press this button to minimize the window
				}else if(HB_Button[A_Index].Type="Clip"){
					GuiControl,1:,TipsEdit,`nPut this saved clip into your Clipboard
				}else if(HB_Button[A_Index].Type="Add"){
					GuiControl,1:,TipsEdit, Save the contents of your Clipboard`n*** HOLD SHIFT *** when you press the button.
				}else if(HB_Button[A_Index].Type="Remove"){
					GuiControl,1:,TipsEdit, Delete this clip`n*** HOLD SHIFT *** when you press the button.
				}else if(HB_Button[A_Index].Type="View"){
					GuiControl,1:,TipsEdit, Briefly displays a small window with the contents saved here`nHold "Shift" && "Ctrl" to open the file instead. 
				}else if(HB_Button[A_Index].Type="Open Folder"){
					GuiControl,1:,TipsEdit, Opens the folder containing all saved clips.
				}else if(HB_Button[A_Index].Type="Delete Clips"){
					GuiControl,1:,TipsEdit,HOLD *** CTRL + SHIFT ***`nDeletes all clips in the current tab`nDoesn't effect clips that have the hotkey lock turned on
				}else if(HB_Button[A_Index].Type="CBM"){
					GuiControl,1:,TipsEdit, *** Hold Shift ***`nAdd the contents of your clipboard to this master file`nThis is one of two Database like files.
				}else if(HB_Button[A_Index].Type="Reserved"){
					GuiControl,1:,TipsEdit,This button currently has no action assigned to it
				}else if(HB_Button[A_Index].Type="Settings Menu"){
					GuiControl,1:,TipsEdit,Opens the Hotkeys and Settings Menu
				}
				LActive:=ctrl
				Return
			}
		}
		Loop, % HotkeyLocks.Length()	{
			if(HotkeyLocks[A_Index].Hwnd=ctrl){
				if(HotkeyLocks[A_Index].Type="Lock_Clip")
					GuiControl,1:,TipsEdit,Toggle this switch On to LOCK this clip.`nWhile locked, Hotkeys and Clearing all clips will have no effect on this clip.
				LActive:=ctrl
				Return
			}
		}
		Loop,% Indicators.Length(){
			if(Indicators[A_Index].Hwnd=ctrl){
				GuiControl,1:,TipsEdit,Indicates if a clip is currently saved at this location
				LActive:=ctrl
				Return
			}
		}
		loop,2	{
			if(Panel%A_Index%.Hwnd=ctrl){
				GuiControl,1:,TipsEdit,The Clip Number`nFiles are saved with same number`nSaved Clip "Number" .txt
				LActive:=ctrl
				Return
			}
		}
		if(ToggleTips.Hwnd=ctrl){
			GuiControl,1:,TipsEdit,Toggle this switch to turn On or Off Tips
			LActive:=ctrl
			Return
		}else if(ToggleHotkeyLock.Hwnd=ctrl){
			GuiControl,1:,TipsEdit,***  Hold Shift  ***`nToggle All Hotkey Locks in the current tab to this State
			LActive:=ctrl
			Return
		}else if(cmx>=wx&&cmx<=wx+160&&cmy<=wy+60&&cmy>=wy){
			GuiControl,1:,TipsEdit,Click && Drag To Move Window`nRight Click To Expand / Shrink The Window
			LActive:=Null
			Return
		}
	}
}

Create_Preview(){
	PreviewWindow := New Custom_Window( x:= 0 , y:= 0 , w:= 700 , h:= 175 , Name:= "2" , Options:= "+AlwaysOnTop -Caption -DPIScale +ToolWindow" , Title:= "Preview Window" , Background_Bitmap:= PreviewWindow() )
	Gui,2:Color,333437,333437
	Gui,2:Font,cWhite s10 ,Arial
	Gui,2:Add,Edit,x15 y10 w670 h120 -VScroll -E0x200 ReadOnly -Wrap hwndPreviewEditHwnd,
	HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=480, y:=140, w:=100, h:=30, window:="2", Label:="FreezePreviewWindow", Text:="Freeze", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="38393C", y_Offset:=0 ))
	HB_Button.Push(New Clipboard_Master_v2_Buttons(x+=w+10, y:=140, w:=100, h:=30, window:="2", Label:="ClosePreviewWindow", Text:="Close", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="38393C", y_Offset:=0 ))
	GuiControl,2:Focus,% HB_Button[44].Hwnd
	Gui,2:Show,Hide x0 y0 w700 h175,Preview Window
	WinFade:=255
}

Show_Preview(DisplayMsg){
	SetTimer,PreviewExitTimer,Off
	SetTimer,PreviewFadeTimer,Off
	Gui,2:Show,NA
	Winset,Transparent,255,% "ahk_Id" PreviewWindow.HWnd
	GuiControl,2:,% PreviewEditHwnd,% DisplayMsg
	WinFade:=255
	SetTimer,PreviewExitTimer,% (ClipViewTime *-1)*1000
}

FreezePreviewWindow:
	SetTimer,PreviewExitTimer,Off
	SetTimer,PreviewFadeTimer,Off
	Winset,Transparent,255,% "ahk_Id" PreviewWindow.HWnd
	return
	
ClosePreviewWindow:
	SetTimer,PreviewExitTimer,Off
	SetTimer,PreviewFadeTimer,Off
	Gui,2:Hide
	return
	
PreviewExitTimer:
	SetTimer,PreviewFadeTimer,0
	return
	
PreviewFadeTimer:
	if(WinFade>1){
		Winset,Transparent,% WinFade-=5,% "ahk_Id" PreviewWindow.HWnd
	}else	{
		SetTimer,PreviewFadeTimer,Off
		Gui,2:Hide
	}
	return

Create_Settings_Window(){
	static ftr
	if(!ftr){
		ftr:=1  
		SettingsWindow := New Custom_Window( x:= 0 , y:= 0 , w:= 860 , h:= 590 , Name:= "4" , Options:= "+AlwaysOnTop -Caption -DPIScale +Owner1" , Title:= "Settings Window" , Background_Bitmap:= Settings_Window() )
		Gui,4:Add,Text,x5 y5 w150 h40 BackgroundTrans gMove_Window
		Gui,4:Color,333437,333437
		Gui,4:Font,cWhite s8
		gosub,LoadSettingsData
		if(Enable_Master_Hotkey_Lock_Saved_Data=1)
			AllHotkeysLock:=New Flat_Round_Switch_Type_1(x:=180 , y:=20 ,w:=100,Text:="Enable Hotkeys",Font:="Segoe Ui",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.AllHotkeysLock,Label:="MasterHKLock",Type:="")
		else 
			AllHotkeysLock:=New Flat_Round_Switch_Type_1(x:=180 , y:=20 ,w:=100,Text:="Enable Hotkeys",Font:="Segoe Ui",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=0,Label:="MasterHKLock",Type:="")
		ToggleSaveHotkeys:=New Flat_Round_Switch_Type_1(x:=350 , y:=34 ,w:=200,Text:="Enable Save Clip Hotkeys",Font:="Arial",FontSize:= "10 Bold" , FontColor:="ffffff" ,Window:="4",Background_Color:="38393C",State:=PHARR.ToggleSaveHotkeys,Label:="ActivateSaveHKs",Type:="")
		ToggleClipHotkeys:=New Flat_Round_Switch_Type_1(x:=640 , y:=34 ,w:=200,Text:="Enable Clip Hotkeys",Font:="Arial",FontSize:= "10 Bold" , FontColor:="ffffff" ,Window:="4",Background_Color:="38393C",State:=PHARR.ToggleClipHotkeys,Label:="ActivateClipHKs",Type:="")
		Gui,4:Add,Hotkey,x340 y107 w95 h22 hwndSHK1 vSaveHK1 ,% PHARR.SaveHK[1]
		Loop 9	{
			SHKindex:=A_Index+1
			Gui,4:Add,Hotkey,x340 yp+30 w95 h22 hwndSHK%SHKIndex% vSaveHK%SHKIndex% ,% PHARR.SaveHK[A_index+1]
		}
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=450, y:=103, w:=60, h:=30, window:="4", Label:="Update_SaveHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset:=-1,Type:="UpdateHotkey",Name:="SaveHK1" ))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=450, y+=h, w:=60, h:=30, window:="4", Label:="Update_SaveHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="SaveHK2"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=450, y+=h, w:=60, h:=30, window:="4", Label:="Update_SaveHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="SaveHK3"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=450, y+=h, w:=60, h:=30, window:="4", Label:="Update_SaveHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="SaveHK4"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=450, y+=h, w:=60, h:=30, window:="4", Label:="Update_SaveHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="SaveHK5"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=450, y+=h, w:=60, h:=30, window:="4", Label:="Update_SaveHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="SaveHK6"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=450, y+=h, w:=60, h:=30, window:="4", Label:="Update_SaveHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="SaveHK7"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=450, y+=h, w:=60, h:=30, window:="4", Label:="Update_SaveHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="SaveHK8"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=450, y+=h, w:=60, h:=30, window:="4", Label:="Update_SaveHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="SaveHK9"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=450, y+=h, w:=60, h:=30, window:="4", Label:="Update_SaveHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="SaveHK10"))
		Save_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=525 , y:=110 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Save_Hotkeys_Locks[1],Label:="UpdateSaveHKLock",Type:="ToggleHotkey"))
		Save_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=525 , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Save_Hotkeys_Locks[2],Label:="UpdateSaveHKLock",Type:="ToggleHotkey"))
		Save_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=525 , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Save_Hotkeys_Locks[3],Label:="UpdateSaveHKLock",Type:="ToggleHotkey"))
		Save_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=525 , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Save_Hotkeys_Locks[4],Label:="UpdateSaveHKLock",Type:="ToggleHotkey"))
		Save_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=525 , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Save_Hotkeys_Locks[5],Label:="UpdateSaveHKLock",Type:="ToggleHotkey"))
		Save_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=525 , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Save_Hotkeys_Locks[6],Label:="UpdateSaveHKLock",Type:="ToggleHotkey"))
		Save_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=525 , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Save_Hotkeys_Locks[7],Label:="UpdateSaveHKLock",Type:="ToggleHotkey"))
		Save_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=525 , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Save_Hotkeys_Locks[8],Label:="UpdateSaveHKLock",Type:="ToggleHotkey"))
		Save_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=525 , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Save_Hotkeys_Locks[9],Label:="UpdateSaveHKLock",Type:="ToggleHotkey"))
		Save_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=525 , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Save_Hotkeys_Locks[10],Label:="UpdateSaveHKLock",Type:="ToggleHotkey"))
		Gui,4:Add,Hotkey,x625 y107 w95 h22 hwndCHK1 vClipHK1 ,% PHARR.ClipHK[1]
		Loop 9	{
			CHKindex:=A_Index+1
			Gui,4:Add,Hotkey,x625 yp+30 w95 h22 hwndCHK%CHKIndex% vClipHK%CHKIndex% ,% PHARR.ClipHK[A_Index+1]
		}
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=735, y:=103, w:=60, h:=30, window:="4", Label:="Update_Clipkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey",Name:="ClipHK1" ))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h, w:=60, h:=30, window:="4", Label:="Update_Clipkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="ClipHK2"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h, w:=60, h:=30, window:="4", Label:="Update_Clipkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="ClipHK3" ))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h, w:=60, h:=30, window:="4", Label:="Update_Clipkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="ClipHK4"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h, w:=60, h:=30, window:="4", Label:="Update_Clipkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="ClipHK5"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h, w:=60, h:=30, window:="4", Label:="Update_Clipkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="ClipHK6"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h, w:=60, h:=30, window:="4", Label:="Update_Clipkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="ClipHK7"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h, w:=60, h:=30, window:="4", Label:="Update_Clipkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="ClipHK8"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h, w:=60, h:=30, window:="4", Label:="Update_Clipkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="ClipHK9"))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x, y+=h, w:=60, h:=30, window:="4", Label:="Update_Clipkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ,Name:="ClipHK10"))
		Clip_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x:=810 , y:=110 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Clip_Hotkeys_Locks[1],Label:="Update_ClipLock",Type:="ToggleHotkey",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
		Clip_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Clip_Hotkeys_Locks[2],Label:="Update_ClipLock",Type:="ToggleHotkey",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
		Clip_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Clip_Hotkeys_Locks[3],Label:="Update_ClipLock",Type:="ToggleHotkey",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
		Clip_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Clip_Hotkeys_Locks[4],Label:="Update_ClipLock",Type:="ToggleHotkey",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
		Clip_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Clip_Hotkeys_Locks[5],Label:="Update_ClipLock",Type:="ToggleHotkey",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
		Clip_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Clip_Hotkeys_Locks[6],Label:="Update_ClipLock",Type:="ToggleHotkey",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
		Clip_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Clip_Hotkeys_Locks[7],Label:="Update_ClipLock",Type:="ToggleHotkey",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
		Clip_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Clip_Hotkeys_Locks[8],Label:="Update_ClipLock",Type:="ToggleHotkey",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
		Clip_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Clip_Hotkeys_Locks[9],Label:="Update_ClipLock",Type:="ToggleHotkey",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
		Clip_Hotkeys_Locks.Push(New Flat_Round_Switch_Type_1(x , y+=30 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.Clip_Hotkeys_Locks[10],Label:="Update_ClipLock",Type:="ToggleHotkey",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0))
		Gui,4:Add,Hotkey,x20 y83 w145 h22 hwndCBM1 vCBM1HK ,% PHARR.CBM1HK
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=175, y:=79, w:=60, h:=30, window:="4", Label:="UPDATECBM1HK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ))
		ClipMasterHotkeyLock1:=New Flat_Round_Switch_Type_1(x+=w+10 , y+=6 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="333437",State:=PHARR.ClipMasterHotkeyLock1,Label:="ClipMasterHotkeyLock1",Type:="ToggleHotkey")
		Gui,4:Add,Hotkey,x20 y148 w145 h22 hwndCBM2 vCBM2HK ,% PHARR.CBM2HK
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=175, y:=144, w:=60, h:=30, window:="4", Label:="UPDATECBM2HK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ))
		ClipMasterHotkeyLock2:=New Flat_Round_Switch_Type_1(x+=w+10 , y+=6 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="333437",State:=PHARR.ClipMasterHotkeyLock2,Label:="ClipMasterHotkeyLock2",Type:="ToggleHotkey")
		Gui,4:Add,Hotkey,x20 y213 w145 h22 hwndswitchTabs vSTHK ,% PHARR.STHK
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=175, y:=209, w:=60, h:=30, window:="4", Label:="UPDATESTHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ))
		STHLLOCK:=New Flat_Round_Switch_Type_1(x+=w+10 , y+=6 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="333437",State:=PHARR.STHLLOCK,Label:="STHLLOCK",Type:="ToggleHotkey")
		Gui,4:Add,Hotkey,x20 y278 w145 h22 hwndHideWin vHWINHK ,% PHARR.HWINHK
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=175, y:=274, w:=60, h:=30, window:="4", Label:="UPDATEHWINHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ))
		HWINLOCK:=New Flat_Round_Switch_Type_1(x+=w+10 , y+=6 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="333437",State:=PHARR.HWINLOCK,Label:="HWINLOCK",Type:="ToggleHotkey")
		Gui,4:Add,Hotkey,x20 y343 w145 h22 hwndtelePortWin vTPWINHK ,% PHARR.TPWINHK
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=175, y:=339, w:=60, h:=30, window:="4", Label:="UPDATETPHK", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ))
		TPWINLOCK:=New Flat_Round_Switch_Type_1(x+=w+10 , y+=6 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="333437",State:=PHARR.TPWINLOCK,Label:="TPWINLOCK",Type:="ToggleHotkey")
		Gui,4:Add,Hotkey,x20 y408 w145 h22 hwndOpenSlotHK vSaveToOpenSlotHK ,% PHARR.SaveToOpenSlotHK
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=175, y:=404, w:=60, h:=30, window:="4", Label:="UpdateSaveToFirstSlotHotkey", Text:="Update", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset,Type:="UpdateHotkey" ))
		SaveToOpenSlotLock:=New Flat_Round_Switch_Type_1(x+=w+10 , y+=6 ,w:=30,Text:="",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="333437",State:=PHARR.SaveToOpenSlotLock,Label:="SaveToOpenSlotLock",Type:="ToggleHotkey")
		EnableSettingsTips:=New Flat_Round_Switch_Type_1(x:=30 , y:=465 ,w:=110,Text:="Enable Tips",Font:="Segoe UI",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.EnableSettingsTips,Label:="Enable_Settings_Tips",Type:="")
		EnableSounds:=New Flat_Round_Switch_Type_1(x+=w+10 , y:=465 ,w:=110,Text:="Enable Sounds",Font:="Segoe UI",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.EnableSounds,Label:="",Type:="Enable Sounds")
		EnableClipView:=New Flat_Round_Switch_Type_1(x:=310 , y:=465 ,w:=190,Text:="Clip Preview - Duration (Sec)",Font:="Segoe UI",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="4",Background_Color:="38393C",State:=PHARR.EnableClipView,Label:="",Type:="")
		Gui,4:Add,Edit,x500 y463 w50 h22 Center Number hwndClipViewTimeHwnd vClipViewTime gSetClipViewDuration,% (PHARR.ClipViewTime!="")?(PHARR.ClipViewTime):(ClipViewTime)
		
		;*********************************************************

		;      <><><>  Free Button  <><><>
		
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x:=590, y:=458, w:=80, h:=30, window:="4", Label:="", Text:="Reserved", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="38393C", y_Offset,Type:="Unused Button" ))
		
		;*********************************************************
		
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x+=w, y:=458, w:=80, h:=30, window:="4", Label:="SaveSettingData", Text:="Save", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="38393C", y_Offset,Type:="Save Settings" ))
		HB_Button.Push(New Clipboard_Master_v2_Buttons(x+=w, y:=458, w:=80, h:=30, window:="4", Label:="ExitSettingsMenu", Text:="Exit", Font:="Segoe UI", Font_Size:="10 Bold", Font_Color_Top:=colorSet[1], Font_Color_Bottom:="000000", Background_Color:="38393C", y_Offset,Type:="Exit Settings Menu" ))
		Gui,4:Font,cWhite s10
		Gui,4:Add,Edit,x30 y515 w800 h65 -VScroll -E0x200 -Wrap Center vSettingsTipEdit,% SettingsTipEdit
		gui,4:Submit,NoHide
		return
	}
	SettingsWindow.Show_Window()
	if(EnableSettingsTips.State=1){
		SetTimer,Settings_Tips,500
		Gui,4:Show,w860 h590 NA
	}else	{
		Gui,4:Show,w860 h500 NA
	}
}

ActiveHKOnStartup:
	gosub,MasterHKLock
	gosub,ActivateSaveHKs
	gosub,ActivateClipHKs
	gosub,Update_ClipLock
	gosub,UpdateSaveHKLock
	gosub,ClipMasterHotkeyLock1
	gosub,ClipMasterHotkeyLock2
	gosub,STHLLOCK
	gosub,HWINLOCK
	gosub,TPWINLOCK
	gosub,SaveToOpenSlotLock
	return

Enable_Settings_Tips:
	if(EnableSettingsTips.State=1){
		Gui,4:Show,w860 h590 NA
		SetTimer,Settings_Tips,500
	}else	{
		Gui,4:Show,w860 h500 NA
		SetTimer,Settings_Tips,Off
	}
	return

Settings_Tips(){
	static LActive
	MouseGetPos,cmx,cmy,,ctrl,2
	WingetPos,wx,wy,,,% "ahk_Id" SettingsWindow.hwnd
	if(LActive!=ctrl){
		Loop,% HB_Button.Length()	{
			if(HB_Button[A_Index].Hwnd=ctrl){
				if(HB_Button[A_Index].Type="UpdateHotkey")
					GuiControl,4:,SettingsTipEdit,Press this button to set / update this hotkey
				else if(HB_Button[A_Index].Type="Unused Button")
					GuiControl,4:,SettingsTipEdit,This button is unassigned and can be used by you to add more functionality.
				else if(HB_Button[A_Index].Type="Save Settings")
					GuiControl,4:,SettingsTipEdit,Save your settings to file to be used whenever this script is ran.`nChanges can be made and used without saving, but will be lost once this script is closed.
				else if(HB_Button[A_Index].Type="Exit Settings Menu")
					GuiControl,4:,SettingsTipEdit,Close the settings page.`nBe sure to save your changes if you want them to be used the next time you run this script.
				LActive:=ctrl
				Return
			}	
		}
		Loop,% Save_Hotkeys_Locks.Length(){
			if(Save_Hotkeys_Locks[A_Index].Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Active / Disable this hotkey`nUsed in conjunction with`n"Enable Save Clip Hotkeys"  &  "Enable Hotkeys"
				LActive:=ctrl
				Return
			}
		}
		Loop,% Clip_Hotkeys_Locks.Length(){
			if(Clip_Hotkeys_Locks[A_Index].Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Active / Disable this hotkey`nUsed in conjunction with`n"Enable Clip Hotkeys"  &  "Enable Hotkeys"
				LActive:=ctrl
				Return
			}
		}
		Loop,10	{
			if(SHK%A_Index%=ctrl){
				GuiControl,4:,SettingsTipEdit,Hotkey to save clipboard to position %A_Index% in the current tab.`nType your hotkey and press update.`nClear to remove hotkey (None) and press update.
				LActive:=ctrl
				Return
			}
		}
		Loop,10	{
			if(CHK%A_Index%=ctrl){
				GuiControl,4:,SettingsTipEdit,Hotkey to add the clip saved at position %A_Index% in the current tab to your Clipboard.`nType your hotkey and press update.`nClear to remove hotkey (None) and press update.
				LActive:=ctrl
				Return
			}
		}
		if(ToggleSaveHotkeys.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Active / Disable all of the "Save Clip" Hotkeys`nUsed in conjunction with`n"Enable Hotkeys" and the 10 Save Clip locks below.
				LActive:=ctrl
				Return
		}else if(ToggleClipHotkeys.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Active / Disable all of the "Clip" Hotkeys`nUsed in conjunction with`n"Enable Hotkeys" and the 10 Clip locks below.
				LActive:=ctrl
				Return
		}else if(AllHotkeysLock.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,This is the master lock for all hotkeys (except teleport window and hide window)`n By default, hotkeys always start off suspended regardless of what you had saved it as. To have this use your saved settings,`nChange "Enable_Master_Hotkey_Lock_Saved_Data" to a value of 1 at the top of the script.
				LActive:=ctrl
				Return
		}else if(ClipMasterHotkeyLock1.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Active / Disable this hotkey`nUsed in conjunction with`n" Enable Hotkeys "
				LActive:=ctrl
				Return
		}else if(ClipMasterHotkeyLock2.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Active / Disable this hotkey`nUsed in conjunction with`n" Enable Hotkeys "
				LActive:=ctrl
				Return
		}else if(STHLLOCK.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Active / Disable this hotkey`nUsed in conjunction with`n" Enable Hotkeys "
				LActive:=ctrl
				Return
		}else if(SaveToOpenSlotLock.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Active / Disable this hotkey`nUsed in conjunction with`n" Enable Hotkeys "
				LActive:=ctrl
				Return
		}else if(HWINLOCK.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Active / Disable this hotkey`nThis Hotkey Ignores the`n"Enable Hotkeys" Switch state
				LActive:=ctrl
				Return
		}else if(TPWINLOCK.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Active / Disable this hotkey`nThis Hotkey Ignores the`n"Enable Hotkeys" Switch state
				LActive:=ctrl
				Return
		}else if(EnableSettingsTips.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Turn On / Off Tips
				LActive:=ctrl
				Return
		}else if(EnableSounds.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Turn On / Off SoundBeeps`n1 Beep = Success`n3 Beeps = Failure
				LActive:=ctrl
				Return
		}else if(EnableClipView.Hwnd=ctrl){
				GuiControl,4:,SettingsTipEdit,Enable / Disable the preview window when one of the`n"Enable Clip Hotkeys" are used.
				LActive:=ctrl
				Return
		}else if(ClipViewTimeHwnd=ctrl){
			GuiControl,4:,SettingsTipEdit,Set the amount of time the preview windows stays on screen before fading away.`nValue used for both the "View" button and when using any of the`n"Enable Clip Hotkeys" if "Clip Preview" is enabled.
			LActive:=ctrl
			Return
		}else if(CBM1=ctrl){
			GuiControl,4:,SettingsTipEdit,Set the hotkey to append the current contents of your clipboard to the CBM1 file.
			LActive:=ctrl
			Return
		}else if(CBM2=ctrl){
			GuiControl,4:,SettingsTipEdit,Set the hotkey to append the current contents of your clipboard to the CBM2 file.
			LActive:=ctrl
			Return
		}else if(switchTabs=ctrl){
			GuiControl,4:,SettingsTipEdit,Set the hotkey to switch between the different tabs (pages)
			LActive:=ctrl
			Return
		}else if(HideWin=ctrl){
			GuiControl,4:,SettingsTipEdit,Set the hotkey to Hide the main window
			LActive:=ctrl
			Return
		}else if(telePortWin=ctrl){
			GuiControl,4:,SettingsTipEdit,Set the hotkey to Move the main window to your cursor position.
			LActive:=ctrl
			Return
		}else if(OpenSlotHK=ctrl){
			GuiControl,4:,SettingsTipEdit,Set the hotkey to Save the contents of your`nClipboard to the first available slot.
			LActive:=ctrl
			Return
		}
	}
}

ExitSettingsMenu(){
	SetTimer,Settings_Tips,Off
	Gui,4:Hide
}

LoadSettingsData:
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,AllHotkeysLock
	PHARR.AllHotkeysLock:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,ToggleSaveHotkeys
	PHARR.ToggleSaveHotkeys:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,ToggleClipHotkeys
	PHARR.ToggleClipHotkeys:=temp
	loop 10	{
		IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,Save_Hotkeys_Locks%A_Index%
		PHARR.Save_Hotkeys_Locks[A_Index]:=temp
	}
	loop 10	{
		IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,Clip_Hotkeys_Locks%A_Index%
		PHARR.Clip_Hotkeys_Locks[A_Index]:=temp
	}	
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,ClipMasterHotkeyLock1
	PHARR.ClipMasterHotkeyLock1:=temp	
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,ClipMasterHotkeyLock2	
	PHARR.ClipMasterHotkeyLock2:=temp	
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,STHLLOCK
	PHARR.STHLLOCK:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,HWINLOCK
	PHARR.HWINLOCK:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,TPWINLOCK	
	PHARR.TPWINLOCK:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,SaveToOpenSlotLock	
	PHARR.SaveToOpenSlotLock:=temp	
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,EnableSounds	
	PHARR.EnableSounds:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,EnableClipView		
	PHARR.EnableClipView:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Switch Data,EnableSettingsTips
	PHARR.EnableSettingsTips:=temp
	PHARR.SaveHK:=[]
	Loop,10	{
		spot:="SaveHK" A_Index
		IniRead,temp,% A_WorkingDir "\Settings Data.ini",Hotkey Data,%Spot%
		PHARR.SaveHK[A_Index]:=temp
	}
	Loop,10	{
		IniRead,temp,% A_WorkingDir "\Settings Data.ini",Hotkey Data,ClipHK%A_Index%
		PHARR.ClipHK[A_Index]:=temp
	}	
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Hotkey Data,CBM1HK
	PHARR.CBM1HK:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Hotkey Data,CBM2HK	
	PHARR.CBM2HK:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Hotkey Data,STHK
	PHARR.STHK:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Hotkey Data,HWINHK
	PHARR.HWINHK:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Hotkey Data,TPWINHK
	PHARR.TPWINHK:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Hotkey Data,SaveToOpenSlotHK
	PHARR.SaveToOpenSlotHK:=temp
	IniRead,temp,% A_WorkingDir "\Settings Data.ini",Edits,ClipViewTime
	PHARR.ClipViewTime:=temp
	return
	
SaveSettingData:
	temp:=AllHotkeysLock.State
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,AllHotkeysLock
	temp:=ToggleSaveHotkeys.State
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,ToggleSaveHotkeys
	temp:=ToggleClipHotkeys.State	
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,ToggleClipHotkeys
	loop 10	{
		temp:=Save_Hotkeys_Locks[A_Index].state
		IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,Save_Hotkeys_Locks%A_Index%
	}
	loop 10	{
		temp:=Clip_Hotkeys_Locks[A_Index].state
		IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,Clip_Hotkeys_Locks%A_Index%
	}
	temp:=ClipMasterHotkeyLock1.State	
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,ClipMasterHotkeyLock1
	temp:=ClipMasterHotkeyLock2.State	
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,ClipMasterHotkeyLock2
	temp:=STHLLOCK.State	
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,STHLLOCK	
	temp:=HWINLOCK.State	
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,HWINLOCK
	temp:=TPWINLOCK.State	
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,TPWINLOCK	
	temp:=SaveToOpenSlotLock.State	
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,SaveToOpenSlotLock	
	temp:=EnableSounds.State	
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,EnableSounds	
	temp:=EnableClipView.State	
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,EnableClipView
	temp:=EnableSettingsTips.State
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Switch Data,EnableSettingsTips
	Loop,10	{
		temp:=SaveHK%A_Index%
		IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Hotkey Data,SaveHK%A_Index%
	}
	Loop,10	{
		temp:=ClipHK%A_Index%
		IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Hotkey Data,ClipHK%A_Index%
	}	
	temp:=CBM1HK
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Hotkey Data,CBM1HK
	temp:=CBM2HK
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Hotkey Data,CBM2HK	
	temp:=STHK
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Hotkey Data,STHK
	temp:=HWINHK
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Hotkey Data,HWINHK
	temp:=TPWINHK
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Hotkey Data,TPWINHK
	temp:=SaveToOpenSlotHK
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Hotkey Data,SaveToOpenSlotHK
	temp:=ClipViewTime
	IniWrite,%temp%,% A_WorkingDir "\Settings Data.ini",Edits,ClipViewTime
	if(EnableSounds.State)
		SoundBeep,500
	return

APPENDCBM1PREP:
	if(!GetKeyState("Shift")){
		if(EnableSounds.State)
			Loop,3
				SoundBeep,777
			return
	}else	
		goto,APPENDCBM1
	return

APPENDCBM1:
	FileAppend,% Clipboard "`r`n`r`n`r`n" ,% A_WorkingDir "\Clip Master File 1.txt"
	if(EnableSounds.State)
		SoundBeep,500
	return

ClipMasterHotkeyLock1:
	if(ClipMasterHotkeyLock1.State&&CBM1HK!="")
		Hotkey,% CBM1HK,APPENDCBM1,On
	else if(CBM1HK!="")
		Hotkey,% CBM1HK,APPENDCBM1,Off
	return

UPDATECBM1HK:
	GuiControlGet,NewKey,4:,CBM1HK
	if(NewKey=""&&CBM1HK!=""){
		Hotkey,% CBM1HK,APPENDCBM1,Off
		CBM1HK:=NewKey
	}else if(NewKey "" != CBM1HK "" &&CBM1HK!=""){
		Hotkey,% CBM1HK,APPENDCBM1,Off
		Hotkey,% NewKey,APPENDCBM1,On
		CBM1HK:=NewKey
		if(!ClipMasterHotkeyLock1.State)
			Hotkey,% CBM1HK,APPENDCBM1,Off
	}else if(NewKey!=CBM1HK){
		Hotkey,% NewKey,APPENDCBM1,On
		CBM1HK:=NewKey
		if(!ClipMasterHotkeyLock1.State)
			Hotkey,% CBM1HK,APPENDCBM1,Off
	}
	gosub,MasterHKLock
	return

APPENDCBM2PREP:
	if(!GetKeyState("Shift")){
		if(EnableSounds.State)
			Loop,3
				SoundBeep,777
			return
	}else	
		goto,APPENDCBM2
	return
	
APPENDCBM2:
	Padding:=";" A_Tab "==============================================================`r`n;" A_Tab A_Tab A_MMMM " - " A_DD " - " A_YYYY A_Tab "[ " A_Hour " : " A_Min " : " A_Sec " ]`r`n;" A_Tab "==============================================================`r`n`r`n"
	FileAppend,% Padding Clipboard "`r`n`r`n`r`n" ,% A_WorkingDir "\Clip Master File 2.txt"
	if(EnableSounds.State)
		SoundBeep,500
	return

ClipMasterHotkeyLock2:
	if(ClipMasterHotkeyLock2.State&&CBM2HK!="")
		Hotkey,% CBM2HK,APPENDCBM2,On
	else if(CBM2HK!="")
		Hotkey,% CBM2HK,APPENDCBM2,Off
	return

UPDATECBM2HK:
	GuiControlGet,NewKey,4:,CBM2HK
	if(NewKey=""&&CBM2HK!=""){
		Hotkey,% CBM2HK,APPENDCBM2,Off
		CBM2HK:=NewKey
	}else if(NewKey "" != CBM2HK "" && CBM2HK!=""){
		Hotkey,% CBM2HK,APPENDCBM2,Off
		Hotkey,% NewKey,APPENDCBM2,On
		CBM2HK:=NewKey
		if(!ClipMasterHotkeyLock2.State)
			Hotkey,% CBM2HK,APPENDCBM2,Off
	}else if(NewKey!=CBM2HK){
		Hotkey,% NewKey,APPENDCBM2,On
		CBM2HK:=NewKey
		if(!ClipMasterHotkeyLock2.State)
			Hotkey,% CBM2HK,APPENDCBM2,Off
	}
	gosub,MasterHKLock
	return

TeleportWindow(){
	Suspend,Permit  
	MouseGetPos,cx,cy
	Gui,1:Show,% "x" cx-75 " y" cy-25
}

TPWINLOCK: 
	if(TPWINLOCK.State&&TPWINHK!="")
		Hotkey,% TPWINHK,TeleportWindow,On
	else if(TPWINHK!="")
		Hotkey,% TPWINHK,TeleportWindow,Off
	return
	
UPDATETPHK: 
	GuiControlGet,NewKey,4:,TPWINHK
	if(NewKey=""&&TPWINHK!=""){
		Hotkey,% TPWINHK,TeleportWindow,Off
		TPWINHK:=NewKey
	}else if(NewKey "" != TPWINHK "" &&TPWINHK!=""){
		Hotkey,% TPWINHK,TeleportWindow,Off
		Hotkey,% NewKey,TeleportWindow,On
		TPWINHK:=NewKey
		if(!TPWINLOCK.State)
			Hotkey,% TPWINHK,TeleportWindow,Off
	}else if(NewKey!=TPWINHK){
		Hotkey,% NewKey,TeleportWindow,On
		TPWINHK:=NewKey
		if(!TPWINLOCK.State)
			Hotkey,% TPWINHK,TeleportWindow,Off
	}
	return
	
HideWindow(){
	Suspend,Permit  
	;~ static HWIN
	;~ if(HWIN:=!HWIN)
		Gui,1:Hide
	;~ else
		;~ Gui,1:Show,NA
}

HWINLOCK:  
	if(HWINLOCK.State&&HWINHK!="")
		Hotkey,% HWINHK,HideWindow,On
	else if(HWINHK!="")	
		Hotkey,% HWINHK,HideWindow,Off
	return

UPDATEHWINHK:
	GuiControlGet,NewKey,4:,HWINHK
	if(NewKey=""&&HWINHK!=""){
		Hotkey,% HWINHK,HideWindow,Off
		HWINHK:=NewKey
	}else if(NewKey "" != HWINHK "" &&HWINHK!=""){
		Hotkey,% HWINHK,HideWindow,Off
		Hotkey,% NewKey,HideWindow,On
		HWINHK:=NewKey
		if(!HWINLOCK.State)
			Hotkey,% HWINHK,HideWindow,Off
	}else if(NewKey!=HWINHK){
		Hotkey,% NewKey,HideWindow,On
		HWINHK:=NewKey
		if(!HWINLOCK.State)
			Hotkey,% HWINHK,HideWindow,Off
	}
	return

Switch_TABS(){
	static ctab
	if(ctab=null)
		ctab:=Tab.Tab,ctab++
	(cTab=1)?(ctab:=null,Tab._Switch_Tab1()):(ctab=2)?(ctab:=null,Tab._Switch_Tab2()):(ctab=3)?(ctab:=null,Tab._Switch_Tab3()):(ctab=4)?(ctab:=null,Tab._Switch_Tab1())
	TrayTip,,% "Tab: " Tab.Tab
}
	
STHLLOCK:
	if(STHLLOCK.State&&STHK!="")
		Hotkey,% STHK,Switch_TABS,On
	else if(STHK!="")	
		Hotkey,% STHK,Switch_TABS,Off
	return

UPDATESTHK:
	GuiControlGet,NewKey,4:,STHK
	if(NewKey=""&&STHK!=""){
		Hotkey,% STHK,Switch_TABS,Off
		STHK:=NewKey
	}else if(NewKey "" != STHK "" &&STHK!=""){
		Hotkey,% STHK,Switch_TABS,Off
		Hotkey,% NewKey,Switch_TABS,On
		STHK:=NewKey
		if(!STHLLOCK.State)
			Hotkey,% STHK,Switch_TABS,Off
	}else if(NewKey!=STHK){
		Hotkey,% NewKey,Switch_TABS,On
		STHK:=NewKey
		if(!STHLLOCK.State)
			Hotkey,% STHK,Switch_TABS,Off
	}
	gosub,MasterHKLock
	return

SaveToFirstSlot:
	Success:=0
	Loop,30	{
		if(!ClipArray[A_Index]){
			if(A_Index<11&&!HotkeyLocks[A_Index].Tab1_Value){
				FileDelete,% A_WorkingDir "\Saved Clip " A_Index ".txt"
				FileAppend,%Clipboard%,% A_WorkingDir "\Saved Clip " A_Index ".txt"
				ClipArray[A_Index]:=Clipboard,Indicators[A_Index].Tab1_Value:=1
				(Tab.Tab=1)?(Indicators[A_Index].Draw_On())
				Success:=1
				break
			}else if(A_Index>10&&A_Index<21&&!HotkeyLocks[A_Index-10].Tab2_Value){
				FileDelete,% A_WorkingDir "\Saved Clip " A_Index ".txt"
				FileAppend,%Clipboard%,% A_WorkingDir "\Saved Clip " A_Index ".txt"
				ClipArray[A_Index]:=Clipboard,Indicators[A_Index-10].Tab2_Value:=1
				(Tab.Tab=2)?(Indicators[A_Index-10].Draw_On())
				Success:=1	
				break
			}else if(A_Index>20&&!HotkeyLocks[A_Index-20].Tab3_Value){
				FileDelete,% A_WorkingDir "\Saved Clip " A_Index ".txt"
				FileAppend,%Clipboard%,% A_WorkingDir "\Saved Clip " A_Index ".txt"
				ClipArray[A_Index]:=Clipboard,Indicators[A_Index-20].Tab3_Value:=1
				(Tab.Tab=3)?(Indicators[A_Index-20].Draw_On())
				Success:=1
				break
			}
		}
	}
	if(EnableSounds.State){
		if(Success)
			SoundBeep,500
		else
			Loop 3
				SoundBeep,777
	}
	return

SaveToOpenSlotLock: 
	if(SaveToOpenSlotLock.State&&SaveToOpenSlotHK!="")
		Hotkey,% SaveToOpenSlotHK,SaveToFirstSlot,On
	else if(SaveToOpenSlotHK!="")	
		Hotkey,% SaveToOpenSlotHK,SaveToFirstSlot,Off
	return

UpdateSaveToFirstSlotHotkey:
	GuiControlGet,NewKey,4:,SaveToOpenSlotHK
	if(NewKey=""&&SaveToOpenSlotHK!=""){
		Hotkey,% SaveToOpenSlotHK,SaveToFirstSlot,Off
		SaveToOpenSlotHK:=NewKey
	}else if(NewKey "" != SaveToOpenSlotHK "" &&SaveToOpenSlotHK!=""){
		Hotkey,% SaveToOpenSlotHK,SaveToFirstSlot,Off
		Hotkey,% NewKey,SaveToFirstSlot,On
		SaveToOpenSlotHK:=NewKey
		if(!SaveToOpenSlotLock.State)
			Hotkey,% SaveToOpenSlotHK,SaveToFirstSlot,Off
	}else if(NewKey!=SaveToOpenSlotHK){
		Hotkey,% NewKey,SaveToFirstSlot,On
		SaveToOpenSlotHK:=NewKey
		if(!SaveToOpenSlotLock.State)
			Hotkey,% SaveToOpenSlotHK,SaveToFirstSlot,Off
	}
	gosub,MasterHKLock
	return

SetClipViewDuration:
	GuiControlGet,ClipViewTime
	ToolTip, % ClipViewTime
	SetTimer,TooltipsOff,-1000
	return
	
MasterHKLock:
	if(!AllHotkeysLock.State){
		Suspend,On
	}else	{
		Suspend,Off
	}
	return
	
ActivateClipHKs:   
	if(ToggleClipHotkeys.State){
		Loop 10	{
			if(Clip_Hotkeys_Locks[A_Index].State&&ClipHK%A_Index%!=""){
				Hotkey,% ClipHK%A_Index%,ClipHK,On
			}
		}
	}else	{
		Loop 10	{
			if(Clip_Hotkeys_Locks[A_Index].State&&ClipHK%A_Index%!=""){
				Hotkey,% ClipHK%A_Index%,ClipHK,Off
			}
		}
	}
	return
	
Update_ClipLock:
	MouseGetPos,,,,ctrl,2
	Loop 10	{
		if(Clip_Hotkeys_Locks[A_Index].Hwnd=ctrl&&ClipHK%A_Index%!=null){
			if(Clip_Hotkeys_Locks[A_Index].State&&ToggleClipHotkeys.State){
				Hotkey,% ClipHK%A_Index%,ClipHK,On
			}else {
				Hotkey,% ClipHK%A_Index%,ClipHK,Off
			}
			break
		}
	}
	return
	
Update_Clipkey(){
	MouseGetPos,,,,ctrl,2
	Loop,% HB_Button.Length()	{
		if(HB_Button[A_Index].Hwnd=ctrl){
			GuiControlGet,NewKey,4:,% HB_Button[A_Index].Name
			kName:=HB_Button[A_Index].Name
			if(NewKey=""&&%kName%!=""){  
				Hotkey,% %kName%,ClipHK,Off
				%kName%:=NewKey
			}else if(NewKey "" != %kName% "" &&%kName%!=""){
				Hotkey,% %kName%,ClipHK,Off    
				Hotkey,% NewKey,ClipHK,On
				%kName%:=NewKey
				if(!Clip_Hotkeys_Locks[SubStr(HB_Button[A_Index].Name,7,2)].State||!ToggleClipHotkeys.State)
					Hotkey,% NewKey,ClipHK,Off
			}else if(NewKey "" != %kName% "" &&%kName%=null){
				Hotkey,% NewKey,ClipHK,On
				%kName%:=NewKey
				if(!Clip_Hotkeys_Locks[SubStr(HB_Button[A_Index].Name,7,2)].State||!ToggleClipHotkeys.State)
					Hotkey,% NewKey,ClipHK,Off
			}
		}
	}
	gosub,MasterHKLock
}

ActivateSaveHKs:
	if(ToggleSaveHotkeys.State){
		Loop 10	{
			if(Save_Hotkeys_Locks[A_Index].State&&SaveHK%A_Index%!="")
				Hotkey,% SaveHK%A_Index%,SaveHK,On
		}
	}else	{
		Loop 10	{
			if(Save_Hotkeys_Locks[A_Index].State&&SaveHK%A_Index%!="")
				Hotkey,% SaveHK%A_Index%,SaveHK,Off
		}
	}
	return

Update_SaveHK(){
	MouseGetPos,,,,ctrl,2
	Loop,% HB_Button.Length()	{
		if(HB_Button[A_Index].Hwnd=ctrl){
			GuiControlGet,NewKey,4:,% HB_Button[A_Index].Name
			kName:=HB_Button[A_Index].Name
			if(NewKey=""&&%kName%!=""){
				Hotkey,% %kName%,SaveHK,Off
				%kName%:=NewKey
			}else if(NewKey "" != %kName% "" &&%kName%!=""){
				Hotkey,% %kName%,SaveHK,Off
				Hotkey,% NewKey,SaveHK,On
				%kName%:=NewKey
				if(!Save_Hotkeys_Locks[SubStr(HB_Button[A_Index].Name,7,2)].State||!ToggleSaveHotkeys.State)
					Hotkey,% NewKey,SaveHK,Off
			}else if(NewKey "" != %kName% "" &&%kName%=null){
				Hotkey,% NewKey,SaveHK,On
				%kName%:=NewKey
				if(!Save_Hotkeys_Locks[SubStr(HB_Button[A_Index].Name,7,2)].State||!ToggleSaveHotkeys.State)
					Hotkey,% NewKey,SaveHK,Off
			}
		}
	}
	gosub,MasterHKLock
}

UpdateSaveHKLock:  
	MouseGetPos,,,,ctrl,2
	Loop 10	{
		if(Save_Hotkeys_Locks[A_Index].Hwnd=ctrl&&SaveHK%A_Index%!=null){
			if(Save_Hotkeys_Locks[A_Index].State&&ToggleSaveHotkeys.State){
				Hotkey,% SaveHK%A_Index%,SaveHK,On
			}else {
				Hotkey,% SaveHK%A_Index%,SaveHK,Off
			}
			break
		}
	}
	return

SaveHK:
	Loop 10	
		if(SaveHK%A_Index%=A_ThisHotkey)
			index:=A_Index,break
	if(!HotkeyLocks[Index,"Tab" Tab.Tab "_Value"]&&Save_Hotkeys_Locks[Index].State){
		FileDelete,% A_WorkingDir "\Saved Clip " Index + (Tab.Tab*10-10) ".txt"
		FileAppend,%Clipboard%,% A_WorkingDir "\Saved Clip " Index + (Tab.Tab*10-10) ".txt"
		ClipArray[Index + (Tab.Tab*10-10)]:=Clipboard
		(Tab.Tab=1)?(Indicators[Index].Tab1_Value:=1,Indicators[Index].Draw_On()):(Tab.Tab=2)?(Indicators[Index].Tab2_Value:=1,Indicators[Index].Draw_On()):(Tab.Tab=3)?(Indicators[Index].Tab3_Value:=1,Indicators[Index].Draw_On())
		if(EnableSounds.State)
			Soundbeep,500
	}else if(EnableSounds.State) {
		Loop 3
			SoundBeep,777
	}
	SetTimer,TooltipsOff,-1000
	return

ClipHK:
	Loop 10	
		if(ClipHK%A_Index%=A_ThisHotkey)
			index:=A_Index,break
	if(Clip_Hotkeys_Locks[Index].State&&ClipArray[Index + (Tab.Tab*10-10)]){
		Clipboard:=ClipArray[Index + (Tab.Tab*10-10)]
		ClipWait
		if(EnableSounds.State)
			SoundBeep,500
		if(EnableClipView.State)
			Show_Preview(ClipArray[Index + (Tab.Tab*10-10)])
	}else if(EnableSounds.State) {
		Loop 3
			SoundBeep,777
	}
	SetTimer,TooltipsOff,-1000
	return

TooltipsOff:
	ToolTip,
	return

class Indicator	{
	__New(x:=10,y:=10,Window:="1",Tab1_Value:=0,Tab2_Value:=0,Tab3_Value:=0,Indicator_Color:="0066cc"){
		This.X:=x,This.Y:=y,This.W:=28,This.H:=28,This.Window:=window,This.Color:="0xFF" Indicator_Color,This.HalfColor:=Indicator_Color
		This.Tab1_Value:=Tab1_Value,This.Tab2_Value:=Tab2_Value,This.Tab3_Value:=Tab3_Value,This._Create_Trigger(),This._Create_On_Bitmap(),This._Create_Off_Bitmap()
		(This.Tab1_Value)?(This.Draw_On()):(This.Draw_Off())
	}
	_Create_Trigger(){
		local hwnd
		Gui,% This.Window ":Add",Picture,% "x" This.X " y" This.Y " w" This.W " h" This.H " hwndhwnd 0xE"
		This.Hwnd:=hwnd
	}
	_Create_On_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 28 , 28 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 2 )
		Brush := Gdip_BrushCreateSolid( "0xFF333333" )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 32 , 32 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 3 , 5 , 22 , 22 , "0xFF333437" , "0xFF000000" , 1 , 1 )
		Gdip_FillEllipse( G , Brush , 4 , 4 , 20 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 1 , 1 , 26 , 25 , "0xFF333437" , "0xFF222222" , 1 , 1 )
		Gdip_FillEllipse( G , Brush , 5 , 5 , 18 , 18 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 1 , -1 , 20 , 22 , This.Color , "0xFF333437" , 1 , 1 )
		Gdip_FillEllipse( G , Brush , 7 , 7 , 14 , 14 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x33" This.HalfColor )
		Gdip_FillEllipse( G , Brush , 8 , 8 , 11 , 11 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x11" This.HalfColor )
		Gdip_FillEllipse( G , Brush , 10 , 10 , 8 , 8 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x11" This.HalfColor )
		Gdip_FillEllipse( G , Brush , 11 , 11 , 6 , 6 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x11" This.HalfColor )
		Gdip_FillEllipse( G , Brush , 12 , 12 , 4 , 4 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.On_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_Off_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 28 , 28 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 2 )
		Brush := Gdip_BrushCreateSolid( "0xFF333333" )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 32 , 32 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 3 , 5 , 22 , 22 , "0xFF333437" , "0xFF000000" , 1 , 1 )
		Gdip_FillEllipse( G , Brush , 4 , 4 , 20 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 1 , 1 , 26 , 25 , "0xFF333437" , "0xFF222222" , 1 , 1 )
		Gdip_FillEllipse( G , Brush , 5 , 5 , 18 , 18 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 1 , -1 , 20 , 22 , "0xFF666869" , "0xFF333437" , 1 , 1 )
		Gdip_FillEllipse( G , Brush , 7 , 7 , 14 , 14 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x33666869" )
		Gdip_FillEllipse( G , Brush , 8 , 8 , 11 , 11 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x11666869" )
		Gdip_FillEllipse( G , Brush , 10 , 10 , 8 , 8 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x11666869" )
		Gdip_FillEllipse( G , Brush , 11 , 11 , 6 , 6 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x11666869" )
		Gdip_FillEllipse( G , Brush , 12 , 12 , 4 , 4 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Off_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	Draw_On(){
		SetImage(This.Hwnd,This.On_Bitmap)
	}
	Draw_Off(){
		SetImage(This.Hwnd,This.Off_Bitmap)
	}
}

class NumClass	{
	__New(x:=10,y:=10,window:="1",Font_Color:="ff0000"){
		This.X:=x,This.Y:=y,This.W:=28,This.H:=198,This.Window:=window,This.Font_Color:= "0xFF" Font_Color
		This._Create_Trigger(),This._Create_Num1(),This._Create_Num2(),This._Create_Num3(),This._Create_Num4(),This._Create_Num5(),This._Create_Num6()
		Sleep,20
	}
	_Create_Trigger(){
		local hwnd
		Gui,% This.Window ":Add",Picture,% "x" This.X " y" This.Y " w" This.W " h" This.H " hwndhwnd 0xE"
		This.Hwnd:=hwnd
	}
	_Create_Num1(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 28 , 198 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 4 )
		Brush := Gdip_BrushCreateSolid( "0xFF333437" )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 32 , 201 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "1" , "s16 Center Bold c" Brush " x-1 y6" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "1" , "s16 Center Bold c" Brush " x0 y7" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "2" , "s16 Center Bold c" Brush " x-1 y47" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "2" , "s16 Center Bold c" Brush " x0 y48" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "3" , "s16 Center Bold c" Brush " x-1 y88" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "3" , "s16 Center Bold c" Brush " x0 y89" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "4" , "s16 Center Bold c" Brush " x-1 y129" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "4" , "s16 Center Bold c" Brush " x0 y130" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "5" , "s16 Center Bold c" Brush " x-1 y170" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "5" , "s16 Center Bold c" Brush " x0 y171" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Num1_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_Num2(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 28 , 198 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 4 )
		Brush := Gdip_BrushCreateSolid( "0xFF333437" )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 32 , 201 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "6" , "s16 Center Bold c" Brush " x-1 y6" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "6" , "s16 Center Bold c" Brush " x0 y7" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "7" , "s16 Center Bold c" Brush " x-1 y47" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "7" , "s16 Center Bold c" Brush " x0 y48" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "8" , "s16 Center Bold c" Brush " x-1 y88" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "8" , "s16 Center Bold c" Brush " x0 y89" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "9" , "s16 Center Bold c" Brush " x-1 y129" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "9" , "s16 Center Bold c" Brush " x0 y130" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "10" , "s16 Center Bold c" Brush " x-1 y170" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "10" , "s16 Center Bold c" Brush " x0 y171" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Num2_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_Num3(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 28 , 198 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 4 )
		Brush := Gdip_BrushCreateSolid( "0xFF333437" )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 32 , 201 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "11" , "s16 Center Bold c" Brush " x-1 y6" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "11" , "s16 Center Bold c" Brush " x0 y7" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "12" , "s16 Center Bold c" Brush " x-1 y47" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "12" , "s16 Center Bold c" Brush " x0 y48" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "13" , "s16 Center Bold c" Brush " x-1 y88" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "13" , "s16 Center Bold c" Brush " x0 y89" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "14" , "s16 Center Bold c" Brush " x-1 y129" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "14" , "s16 Center Bold c" Brush " x0 y130" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "15" , "s16 Center Bold c" Brush " x-1 y170" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "15" , "s16 Center Bold c" Brush " x0 y171" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Num3_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_Num4(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 28 , 198 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 4 )
		Brush := Gdip_BrushCreateSolid( "0xFF333437" )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 32 , 201 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "16" , "s16 Center Bold c" Brush " x-1 y6" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "16" , "s16 Center Bold c" Brush " x0 y7" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "17" , "s16 Center Bold c" Brush " x-1 y47" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "17" , "s16 Center Bold c" Brush " x0 y48" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "18" , "s16 Center Bold c" Brush " x-1 y88" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "18" , "s16 Center Bold c" Brush " x0 y89" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "19" , "s16 Center Bold c" Brush " x-1 y129" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "19" , "s16 Center Bold c" Brush " x0 y130" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "20" , "s16 Center Bold c" Brush " x-1 y170" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "20" , "s16 Center Bold c" Brush " x0 y171" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Num4_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_Num5(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 28 , 198 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 4 )
		Brush := Gdip_BrushCreateSolid( "0xFF333437" )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 32 , 201 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "21" , "s16 Center Bold c" Brush " x-1 y6" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "21" , "s16 Center Bold c" Brush " x0 y7" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "22" , "s16 Center Bold c" Brush " x-1 y47" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "22" , "s16 Center Bold c" Brush " x0 y48" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "23" , "s16 Center Bold c" Brush " x-1 y88" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "23" , "s16 Center Bold c" Brush " x0 y89" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "24" , "s16 Center Bold c" Brush " x-1 y129" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "24" , "s16 Center Bold c" Brush " x0 y130" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "25" , "s16 Center Bold c" Brush " x-1 y170" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "25" , "s16 Center Bold c" Brush " x0 y171" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Num5_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_Num6(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 28 , 198 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 4 )
		Brush := Gdip_BrushCreateSolid( "0xFF333437" )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 32 , 201 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "26" , "s16 Center Bold c" Brush " x-1 y6" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "26" , "s16 Center Bold c" Brush " x0 y7" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "27" , "s16 Center Bold c" Brush " x-1 y47" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "27" , "s16 Center Bold c" Brush " x0 y48" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "28" , "s16 Center Bold c" Brush " x-1 y88" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "28" , "s16 Center Bold c" Brush " x0 y89" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "29" , "s16 Center Bold c" Brush " x-1 y129" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "29" , "s16 Center Bold c" Brush " x0 y130" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "30" , "s16 Center Bold c" Brush " x-1 y170" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "30" , "s16 Center Bold c" Brush " x0 y171" , "Segoe Ui" , 28 , 20 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Num6_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	Draw_1(){
		SetImage(This.Hwnd,This.Num1_Bitmap)
	}
	Draw_2(){
		SetImage(This.Hwnd,This.Num2_Bitmap)
	}
	Draw_3(){
		SetImage(This.Hwnd,This.Num3_Bitmap)
	}
	Draw_4(){
		SetImage(This.Hwnd,This.Num4_Bitmap)
	}
	Draw_5(){
		SetImage(This.Hwnd,This.Num5_Bitmap)
	}
	Draw_6(){
		SetImage(This.Hwnd,This.Num6_Bitmap)
	}
}

HB_Button_Hover(){
	static Hover_On,Index
	MouseGetPos,,,,ctrl,2
	if(!Hover_On&&ctrl){
		Loop,% HB_Button.Length()	{
			if(ctrl=HB_Button[A_Index].Hwnd)
				HB_Button[A_Index].Draw_Hover(),Index:=A_Index,Hover_On:=1,break
		}
	}else if(Hover_On){
		if(HB_Button[Index].Hwnd!=ctrl)
			HB_Button[Index].Draw_Default(),Hover_On:=0
	}
}

class Clipboard_Master_v2_Buttons	{
	__New(x:=10, y:=10, w:=100, h:=30, window:="1", Label:="", Text:="Button", Font:="Arial", Font_Size:="10 Bold", Font_Color_Top:="FFFFFF", Font_Color_Bottom:="000000", Background_Color:="333437", y_Offset:=0, Typek:="",Name:="" ){
		This.X:=x,This.Y:=y,This.W:=w,This.H:=h,This.Window:=window,This.Label:=Label,This.Background_Color:="0xFF" Background_Color
		This.Text:=Text,This.Font:=Font,This.Font_Color_Top:="0xFF" Font_Color_Top,This.Font_Color_Bottom:="0xFF" Font_Color_Bottom
		This.Font_Size:=Font_Size,This.Y_Offset:=y_Offset,This.Type:=Typek,This.Name:=Name
		This._Create_Trigger(),This._Create_Default_Bitmap(),This._Create_Hover_Bitmap(),This._Create_Pressed_Bitmap()
		Sleep, 20
		This.Draw_Default()
		GuiControl,% This.Window ":Focus",% This.Hwnd
	}
	_Create_Trigger(){
		local hwnd,bbp
		Gui,% This.Window ":Add",Picture,% "x" This.X " y" This.Y " w" This.W " h" This.H " hwndhwnd 0xE"
		This.Hwnd:=hwnd
		bbp:=This._Draw_Pressed.Bind(This)
		GuiControl,% This.Window ":+G",% This.Hwnd,% bbp
		if(This.Label)
			(isFunc(This.Label))?(This.Function:=Func(This.Label))
	}
	_Create_Default_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( This.W , This.H ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 1 )
		Brush := Gdip_BrushCreateSolid( This.Background_Color )
		Gdip_FillRectangle( G , Brush , -2 , 0 , This.W+3 , This.H+3 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF252627" )   
		Gdip_FillRectangle( G , Brush , 3 , 3 , This.W-6 , This.H-6 ) 
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 3 , This.W-9 , This.H-7 , "0xFF363C45" , "0xFF2B2C2E" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 4 , 4 , This.W-8 , This.H-8 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF4D535B" , 1 )
		Gdip_DrawLine( G , Pen , 4 , 4 , This.W-5 , 4 )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( This.Font_Color_Bottom )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x0 y" 1+This.Y_Offset , This.Font , This.W , This.H )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color_Top )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x1 y" 2+This.Y_Offset , This.Font , This.W , This.H )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Default_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_Hover_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( This.W , This.H ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 1 )
		Brush := Gdip_BrushCreateSolid( This.Background_Color )
		Gdip_FillRectangle( G , Brush , -2 , 0 , This.W+3 , This.H+3 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )  
		Gdip_FillRectangle( G , Brush , 3 , 3 , This.W-6 , This.H-6 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 3 , This.W-9 , This.H-7 , "0xFF464C55" , "0xFF3B3C3E" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 4 , 4 , This.W-8 , This.H-8 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF4D535B" , 1 )
		Gdip_DrawLine( G , Pen , 4 , 4 , This.W-5 , 4 )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( This.Font_Color_Bottom )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x0 y" 1+This.Y_Offset , This.Font , This.W , This.H )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color_Top )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x1 y" 2+This.Y_Offset , This.Font , This.W , This.H )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Hover_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_Pressed_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( This.W , This.H ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 1 )
		Brush := Gdip_BrushCreateSolid( This.Background_Color )
		Gdip_FillRectangle( G , Brush , -2 , 0 , This.W+3 , This.H+3 )
		Gdip_DeleteBrush( Brush )
		;----------------------------------------------------------------
		;credit jeeswg   -  https://www.autohotkey.com/boards/viewtopic.php?f=76&t=65764
		cc:="0xFF" ColorSet[1]
		Match := StrSplit(RegExReplace(cc, "^0x(..)(..)(..)(..)$", "0x$1 0x$2 0x$3 0x$4"), " ")
		cc := Format("0x{:02X}{:02X}{:02X}{:02X}", Match.1, Max(Match.2-0x33,0), Max(Match.3-0x33,0), Max(Match.4-0x33,0))
		Brush := Gdip_BrushCreateSolid( cc ) 
		;----------------------------------------------------------------
		Gdip_FillRectangle( G , Brush , 3 , 3 , This.W-6 , This.H-6 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 4 , 3 , This.W-9 , This.H-7 , "0xFF2B2C2E" , "0xFF363C45" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 4 , 4 , This.W-8 , This.H-8 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0x881D232B" , 1 )
		if(HB_Button.Length()+1=884) 
		Gdip_DrawLine( G , Pen , 4 , This.H-5 , This.W-5 , This.H-5 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0x881D232B" , 1 )
		Gdip_DrawLine( G , Pen , 4 , 4 , This.W-5 , 4 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0x881D232B" , 1 )
		Gdip_DrawLine( G , Pen , 4 , 4 , 4 , This.H-6 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0x881D232B" , 1 ) 
		Gdip_DrawLine( G , Pen , This.W-5 , 4 , This.W-5 , This.H-6 ) 
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( This.Font_Color_Bottom )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x0 y" 2+This.Y_Offset , This.Font , This.W , This.H )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color_Top )
		Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x1 y" 3+This.Y_Offset , This.Font , This.W , This.H )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Pressed_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Draw_Pressed(){
		local ctrl
		GuiControl,% This.Window ":Focus",% This.Hwnd
		SetTimer,HB_Button_Hover,Off
		SetImage(This.Hwnd,This.Pressed_Bitmap)
		While(GetKeyState("LButton"))
			Sleep,10
		SetTimer,HB_Button_Hover,On
		MouseGetPos,,,,ctrl,2
		if(ctrl=This.Hwnd){
			This.Draw_Hover()
			if(This.Function)
				This.Function.Call()
			else if(This.Label)
				gosub,% This.Label
		}else	{
			This.Draw_Default()
		}
	}
	Draw_Hover(){
		SetImage(This.Hwnd,This.Hover_Bitmap)
	}
	Draw_Default(){
		SetImage(This.Hwnd,This.Default_Bitmap)
	}
}

class Dark_3_Tabs_1 {
	__New(x:=10, y:=10, window:="1", label:="", Selected_Tab:=1, Background_Color:="333437",Font_Color:="F0F0F0"){
		This.X:=x,This.Y:=y,This.W:=311,This.H:=36,This.Window:=window,This.Label:=Label,This.Tab:=Selected_Tab,This.Background_Color:="0xFF" Background_Color,This.Font_Color:="0xFF" Font_Color
		This._Create_Trigger(),This._Create_Tab1_Bitmap(),This._Create_Tab2_Bitmap(),This._Create_Tab3_Bitmap()
		sleep 20
		(This.Tab=1)?(SetImage(This.Hwnd,This.Tab1_Bitmap)):(This.Tab=2)?(SetImage(This.Hwnd,This.Tab2_Bitmap)):(This.Tab=3)?(SetImage(This.Hwnd,This.Tab3_Bitmap))
	}
	_Create_Trigger(){
		local hwnd
		Gui,% This.Window ":Add",Picture,% "x" This.X " y" This.Y " w" This.W " h" This.H " hwndhwnd 0xE"
		This.hwnd:=hwnd
		Gui,% This.Window ":Add",Text,% "x" This.X+3 " y" This.Y+6 " w99 h28 BackgroundTrans hwndhwnd"
		This.Tab1_Hwnd:=hwnd
		Gui,% This.Window ":Add",Text,% "x" This.X+104 " y" This.Y+5 " w100 h30 BackgroundTrans hwndhwnd"
		This.Tab2_Hwnd:=hwnd
		Gui,% This.Window ":Add",Text,% "x" This.X+206 " y" This.Y+5 " w100 h30 BackgroundTrans hwndhwnd"
		This.Tab3_Hwnd:=hwnd
		TabBind:=This._Switch_Tab1.Bind(This)
		GuiControl,% This.Window ":+G",% This.Tab1_Hwnd,% TabBind
		TabBind:=This._Switch_Tab2.Bind(This)
		GuiControl,% This.Window ":+G",% This.Tab2_Hwnd,% TabBind
		TabBind:=This._Switch_Tab3.Bind(This)
		GuiControl,% This.Window ":+G",% This.Tab3_Hwnd,% TabBind
		if(This.Label)
			(isFunc(This.Label))?(This.Function:=Func(This.Label))
	}
	_Create_Tab1_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 311 , 36 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 1 )
		Brush := Gdip_BrushCreateSolid( This.Background_Color )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 317 , 42 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF141416" )
		Gdip_FillRectangle( G , Brush , 3 , 2 , 305 , 32 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 207 , 4 , 98 , 29 , "0xFF363C45" , "0xFF2B2C2E" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 207 , 3 , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 207 , 4 , 98 , 29 , "0xFF363C45" , "0xFF2B2C2E" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 105 , 3 , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF242527" , "0xFF45474a" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 4 , 4 , 99 , 29 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "Page 1" , "s12 Center vCenter Bold c" Brush " x3 y6" , "Arial" , 99 , 28 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "Page 1" , "s12 Center vCenter Bold c" Brush " x4 y7" , "Arial" , 99 , 28 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "Page 2" , "s12 Center vCenter Bold c" Brush " x104 y5" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "Page 2" , "s12 Center vCenter Bold c" Brush " x105 y6" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF4D535B" , 1 )
		Gdip_DrawLine( G , Pen , 106 , 3 , 204 , 3 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xFF4D535B" , 1 )
		Gdip_DrawLine( G , Pen , 208 , 3 , 306 , 3 )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "Page 3" , "s12 Center vCenter Bold c" Brush " x206 y5" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "Page 3" , "s12 Center vCenter Bold c" Brush " x207 y6" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Tab1_Bitmap:= Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_Tab2_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 311 , 36 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 1 )
		Brush := Gdip_BrushCreateSolid( This.Background_Color )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 317 , 42 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF141416" )
		Gdip_FillRectangle( G , Brush , 3 , 2 , 305 , 32 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 207 , 4 , 98 , 29 , "0xFF363C45" , "0xFF2B2C2E" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 207 , 3 , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 207 , 4 , 98 , 29 , "0xFF363C45" , "0xFF2B2C2E" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 4 , 3 , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF242527" , "0xFF45474a" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 106 , 4 , 99 , 29 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "Page 1" , "s12 Center vCenter Bold c" Brush " x3 y5" , "Arial" , 99 , 28 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "Page 1" , "s12 Center vCenter Bold c" Brush " x4 y6" , "Arial" , 99 , 28 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "Page 2" , "s12 Center vCenter Bold c" Brush " x104 y6" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "Page 2" , "s12 Center vCenter Bold c" Brush " x105 y7" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF4D535B" , 1 )
		Gdip_DrawLine( G , Pen , 5 , 3 , 103 , 3 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xFF4D535B" , 1 )
		Gdip_DrawLine( G , Pen , 208 , 3 , 306 , 3 )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "Page 3" , "s12 Center vCenter Bold c" Brush " x206 y5" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "Page 3" , "s12 Center vCenter Bold c" Brush " x207 y6" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Tab2_Bitmap:= Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Create_Tab3_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( 311 , 36 ) 
		G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 1 )
		Brush := Gdip_BrushCreateSolid( This.Background_Color )
		Gdip_FillRectangle( G , Brush , -2 , -2 , 317 , 42 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF141416" )
		Gdip_FillRectangle( G , Brush , 3 , 2 , 305 , 32 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 207 , 4 , 98 , 29 , "0xFF363C45" , "0xFF2B2C2E" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 106 , 3 , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 207 , 4 , 98 , 29 , "0xFF363C45" , "0xFF2B2C2E" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 4 , 3 , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF242527" , "0xFF45474a" , 1 , 1 )
		Gdip_FillRectangle( G , Brush , 208 , 4 , 99 , 29 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "Page 1" , "s12 Center vCenter Bold c" Brush " x3 y5" , "Arial" , 99 , 28 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "Page 1" , "s12 Center vCenter Bold c" Brush " x4 y6" , "Arial" , 99 , 28 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "Page 2" , "s12 Center vCenter Bold c" Brush " x104 y5" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "Page 2" , "s12 Center vCenter Bold c" Brush " x105 y6" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF4D535B" , 1 )
		Gdip_DrawLine( G , Pen , 5 , 3 , 103 , 3 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xFF4D535B" , 1 )
		Gdip_DrawLine( G , Pen , 107 , 3 , 205 , 3 )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( "0xFF000000" )
		Gdip_TextToGraphics( G , "Page 3" , "s12 Center vCenter Bold c" Brush " x206 y6" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.Font_Color )
		Gdip_TextToGraphics( G , "Page 3" , "s12 Center vCenter Bold c" Brush " x207 y7" , "Arial" , 100 , 30 )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Tab3_Bitmap:= Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	_Switch_Tab1(){
		GuiControl,% This.Window ":Focus",% This.Hwnd
		if(This.Tab!=1){
			SetImage(This.Hwnd,This.Tab1_Bitmap)
			This.Tab:=1
			This._Sub_Redirect()
		}
	}
	_Switch_Tab2(){
		GuiControl,% This.Window ":Focus",% This.Hwnd
		if(This.Tab!=2){
			SetImage(This.Hwnd,This.Tab2_Bitmap)
			This.Tab:=2
			This._Sub_Redirect()
		}
	}
	_Switch_Tab3(){
		GuiControl,% This.Window ":Focus",% This.Hwnd
		if(This.Tab!=3){
			SetImage(This.Hwnd,This.Tab3_Bitmap)
			This.Tab:=3
			This._Sub_Redirect()
		}
	}
	_Sub_Redirect(){
		if(This.Function){
			This.Function.Call()
		}else if(This.Label){
			gosub,% This.Label
		}
	}
}

class Flat_Round_Switch_Type_1	{
	__New(x,y,w:=19,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",State:=0,Label:="",Type:="",Tab1_Value:="",Tab2_Value:="",Tab3_Value:=""){
		This.State:=State,This.X:=x,This.Y:=y,This.W:=w,This.H:=21,This.Text:=Text,This.Font:=Font,This.FontSize:=FontSize,This.FontColor:= "0xFF" FontColor,This.Background_Color:= "0xFF" Background_Color
		This.Window:=Window,This.Create_Off_Bitmap(),This.Create_On_Bitmap(),This.Create_Trigger(),This.Label:=Label,This.Type:=Type,This.Tab1_Value:=Tab1_Value,This.Tab2_Value:=Tab2_Value,This.Tab3_Value:=Tab3_Value
		sleep,20
		(This.State)?(This.Draw_On()):(This.Draw_Off())
	}
	Create_Trigger(){
		Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " 0xE hwndhwnd"
		This.Hwnd:=hwnd
		BD := THIS.Switch_State.BIND( THIS ) 
		GUICONTROL +G , % This.Hwnd , % BD
	}
	Create_Off_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
		 G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 2 )
		Brush := Gdip_BrushCreateSolid( This.Background_Color )
		Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF44474A" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xFF1B1D1E" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
		Gdip_DeletePen( Pen )
		Brush := Gdip_BrushCreateSolid( "0xFF262827" )
		Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , 26 , 13 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF303334" )
		Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 24 , 11 , 5 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x8827282B" )
		Gdip_FillEllipse( G , Brush , 0 , 0 , 18 , 18 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" )
		Gdip_FillEllipse( G , Brush , 0 , 0 , 17 , 17 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFF60646A" , "0xFF393B3F" , 1 , 1 )
		Gdip_FillEllipse( G , Brush , 1 , 1 , 15 , 15 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFF4D5055" , "0xFF36383B" , 1 , 1 )
		Gdip_FillEllipse( G , Brush , 2 , 2 , 13 , 13 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.FontColor )
		Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter cFF000000 x32 y-1" , This.Font , This.W-33, This.H )
		Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.Off_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	Create_On_Bitmap(){
		;Bitmap Created Using: HB Bitmap Maker
		pBitmap:=Gdip_CreateBitmap( This.W , 21 ) 
		 G := Gdip_GraphicsFromImage( pBitmap )
		Gdip_SetSmoothingMode( G , 2 )
		Brush := Gdip_BrushCreateSolid( This.Background_Color )
		Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
		Gdip_DeleteBrush( Brush )
		Pen := Gdip_CreatePen( "0xFF44474A" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
		Gdip_DeletePen( Pen )
		Pen := Gdip_CreatePen( "0xFF1B1D1E" , 1 )
		Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
		Gdip_DeletePen( Pen )
		if(Classic=1){
			Brush := Gdip_BrushCreateSolid( "0xFF1a4168" )  ;inner top
		}else if(Classic=0){
			;----------------------------------------------------------------
			;credit jeeswg   -  https://www.autohotkey.com/boards/viewtopic.php?f=76&t=65764
			cc:="0xFF" ColorSet[5]
			Match := StrSplit(RegExReplace(cc, "^0x(..)(..)(..)(..)$", "0x$1 0x$2 0x$3 0x$4"), " ")
			cc := Format("0x{:02X}{:02X}{:02X}{:02X}", Match.1, Max(Match.2-0x22,0), Max(Match.3-0x22,0), Max(Match.4-0x22,0))
			Brush := Gdip_BrushCreateSolid( cc ) 
			;----------------------------------------------------------------
		}
		Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 25 , 11 , 5 )
		Gdip_DeleteBrush( Brush )
		if(Classic=1){
			Brush := Gdip_BrushCreateSolid( "0xFF174F88" )
		}else if(Classic=0){
			Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[5] )
		}
		Gdip_FillRoundedRectangle( G , Brush , 2 , 5 , 23 , 9 , 4 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0x8827282B" )
		Gdip_FillEllipse( G , Brush , 11 , 0 , 18 , 18 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" )
		Gdip_FillEllipse( G , Brush , 11 , 0 , 17 , 17 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFF60646A" , "0xFF393B3F" , 1 , 1 )
		Gdip_FillEllipse( G , Brush , 12 , 1 , 15 , 15 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFF4D5055" , "0xFF36383B" , 1 , 1 )
		Gdip_FillEllipse( G , Brush , 13 , 2 , 13 , 13 )
		Gdip_DeleteBrush( Brush )
		Brush := Gdip_BrushCreateSolid( This.FontColor )
		Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter cFF000000 x32 y-1" , This.Font , This.W-33, This.H )
		Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
		Gdip_DeleteBrush( Brush )
		Gdip_DeleteGraphics( G )
		This.On_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}
	Switch_State(){
		GuiControl,% This.Window ":Focus",% This.Hwnd
		(This.State:=!This.State)?(This.Draw_On()):(This.Draw_Off())
		if(This.Label)	
			gosub,% This.Label
	}
	Draw_Off(){
		SetImage( This.Hwnd , This.Off_Bitmap )
	}
	Draw_On(){
		SetImage( This.Hwnd , This.On_Bitmap )
	}
}

Class Custom_Window	{
	__New(x:="",y:="",w:=300,h:=200,Name:=1,Options:="+AlwaysOnTop -Caption -DPIScale",Title:="",Background_Bitmap:=""){
		This.X:=x,This.Y:=y,This.W:=w,This.H:=h,This.Name:=Name,This.Title:=Title,This.Options:=Options,This.Background_Bitmap:=Background_Bitmap
		This.Create_Window()
	}
	Create_Window(){
		Gui,% This.Name ":New",%  This.Options " +LastFound"
		This.Hwnd:=WinExist()
		if(This.Background_Bitmap)
			This.Draw_Background_Bitmap()
	}
	Draw_Background_Bitmap(){
		This.Bitmap:=Gdip_CreateHBITMAPFromBitmap(This.Background_Bitmap)
		Gdip_DisposeImage(This.Background_Bitmap)
		Gui,% This.Name ":Add",Picture,% "x0 y0 w" This.W " h" This.H " 0xE hwndhwnd"
		This.Background_Hwnd:=hwnd
		SetImage(This.Background_Hwnd,This.Bitmap)
	}
	Show_Window(){
		if(This.X&&This.Y)
			Gui,% This.Name ":Show",% "x" This.X " y" This.Y " w" This.W " h" This.H,% This.Title
		else if(This.X&&!This.Y)
			Gui,% This.Name ":Show",% "x" This.X  " w" This.W " h" This.H,% This.Title
		else if(!This.X&&This.Y)
			Gui,% This.Name ":Show",% "y" This.Y  " w" This.W " h" This.H,% This.Title
		else
			Gui,% This.Name ":Show",% " w" This.W " h" This.H,% This.Title
	}
}

Main_Window(){
	;Bitmap Created Using: HB Bitmap Maker
	pBitmap:=Gdip_CreateBitmap( 740 , 400 ) 
	G := Gdip_GraphicsFromImage( pBitmap )
	Gdip_SetSmoothingMode( G , 2 )
	Brush := Gdip_BrushCreateSolid( "0xFF38393C" )
	Gdip_FillRectangle( G , Brush , -2 , -2 , 746 , 406 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 6 , 6 , 147 , 41 , "0xFF434447" , "0xFF232427" , 1 , 1 )
	Gdip_FillRectangle( G , Brush , 5 , 5 , 150 , 40 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 5 , 5 , 149 , 39 , "0xaa" colorSet[1] , "0xFF111111" , 2 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 5 , 5 , 150 , 40 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_TextToGraphics( G , "HB Clipboard Master" , "s10 Center vCenter Bold c" Brush " x5 y5" , "Segoe UI" , 150 , 40 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" colorSet[1] )
	Gdip_TextToGraphics( G , "HB Clipboard Master" , "s10 Center vCenter Bold c" Brush " x6 y6" , "Segoe UI" , 150 , 40 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , -1 , 740 , 401 , "0xFF" colorSet[1] , "0xFF000000" , 1 , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 405 , 5 , 330 , 80 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 406 , 6 , 328 , 80 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , -1 , 740 , 401 , "0xFF" colorSet[1], "0xFF000000" , 1 , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 55 , 730 , 220 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 56 , 728 , 218 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 406 , 20 , 328 , 50 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 2 , 324 , 738 , 100 , "0xFF" colorSet[1], "0xFF000000" , 1 , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 323 , 730 , 72 , 25 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 324 , 728 , 70 , 25 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 22 , 99 , 81 , 159 , "0xFF" colorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 14 , 62 , 352 , 206 , 10 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF36373A" )
	Gdip_FillRoundedRectangle( G , Brush , 15 , 63 , 350 , 204 , 10 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 374 , 62 , 352 , 206 , 10 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF36373A" )
	Gdip_FillRoundedRectangle( G , Brush , 375 , 63 , 350 , 204 , 10 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 25 , 65 , 30 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1], "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 25 , 65 , 29 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 60 , 65 , 30 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 60 , 65 , 29 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 95 , 65 , 40 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 95 , 65 , 39 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 140 , 65 , 40 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 140 , 65 , 39 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 185 , 65 , 60 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 185 , 65 , 59 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 250 , 65 , 60 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 250 , 65 , 59 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 385 , 65 , 30 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 385 , 65 , 29 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 420 , 65 , 30 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 420 , 65 , 29 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 455 , 65 , 40 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 455 , 65 , 39 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 500 , 65 , 40 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 500 , 65 , 39 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 545 , 65 , 60 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 545 , 65 , 59 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 609 , 65 , 60 , 200 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" colorSet[1] , "0xFF222222" , 1 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 610 , 65 , 59 , 199 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_CreateLineBrush( 74 , 280 , 99 , 310 , "0xFF" colorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 15 , 279 , 230 , 40 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 16 , 280 , 228 , 38 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 419 , 283 , 370 , 302 , "0xFF" colorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 255 , 279 , 230 , 40 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 256 , 280 , 228 , 38 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 544 , 284 , 557 , 306 , "0xFF" colorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 495 , 279 , 230 , 40 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 496 , 280 , 228 , 38 , 15 )
	Gdip_DeleteBrush( Brush )
	Gdip_DeleteGraphics( G )
	return pBitmap
}

PreviewWindow(){
	;Bitmap Created Using: HB Bitmap Maker
	pBitmap:=Gdip_CreateBitmap( 700 , 175 ) 
	G := Gdip_GraphicsFromImage( pBitmap )
	Gdip_SetSmoothingMode( G , 2 )
	Brush := Gdip_BrushCreateSolid( "0xFF38393C" )
	Gdip_FillRectangle( G , Brush , -2 , -2 , 704 , 180 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 56 , 30 , 50 , 68 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 0 , 0 , 699 , 174 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_CreateLineBrush( 69 , 13 , 151 , 98 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 5 , 690 , 130 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 6 , 688 , 128 , 15 )
	Gdip_DeleteBrush( Brush )
	Gdip_DeleteGraphics( G )
	return pBitmap
}



Settings_Window(){ 
	;Bitmap Created Using: HB Bitmap Maker
	pBitmap:=Gdip_CreateBitmap( 860 , 590 ) 
	G := Gdip_GraphicsFromImage( pBitmap )
	Gdip_SetSmoothingMode( G , 2 )
	Brush := Gdip_BrushCreateSolid( "0xFF38393C" )
	Gdip_FillRectangle( G , Brush , -2 , -2 , 864 , 595 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 6 , 6 , 147 , 41 , "0xFF434447" , "0xFF232427" , 1 , 1 )
	Gdip_FillRectangle( G , Brush , 5 , 5 , 150 , 40 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 5 , 6 , 151 , 39 , "0xFF" ColorSet[1] , "0xFF000000" , 2 , 1 )
	Pen := Gdip_CreatePenFromBrush( Brush , 1 )
	Gdip_DeleteBrush( Brush )
	Gdip_DrawRectangle( G , Pen , 5 , 5 , 150 , 40 )
	Gdip_DeletePen( Pen )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "Hotkeys & Settings" , "s10 Center vCenter Bold c" Brush " x5 y6" , "Segoe UI" , 150 , 40 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 290 , 10 , 280 , 430 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 291 , 11 , 278 , 428 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 575 , 10 , 280 , 430 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 576 , 11 , 278 , 428 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 324 , 16 , 362 , 57 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 300 , 15 , 260 , 50 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF38393C" )
	Gdip_FillRoundedRectangle( G , Brush , 301 , 16 , 258 , 48 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 324 , 16 , 362 , 57 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 295 , 75 , 270 , 360 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF38393C" )
	Gdip_FillRoundedRectangle( G , Brush , 296 , 76 , 268 , 358 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 324 , 16 , 362 , 57 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 585 , 15 , 260 , 50 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF38393C" )
	Gdip_FillRoundedRectangle( G , Brush , 586 , 16 , 258 , 48 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 324 , 16 , 362 , 57 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 580 , 75 , 270 , 360 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF38393C" )
	Gdip_FillRoundedRectangle( G , Brush , 581 , 76 , 268 , 358 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 301 , 111 , 321 , 155 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRectangle( G , Brush , 300 , 90 , 30 , 330 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 301 , 91 , 28 , 328 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 588 , 182 , 611 , 225 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRectangle( G , Brush , 585 , 90 , 30 , 330 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 586 , 91 , 28 , 328 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "1" , "s16 Center  Bold c" Brush " x299 y109" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "1" , "s16 Center  Bold c" Brush " x300 y110" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "2" , "s16 Center  Bold c" Brush " x299 y139" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "2" , "s16 Center  Bold c" Brush " x300 y140" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "3" , "s16 Center  Bold c" Brush " x299 y169" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "3" , "s16 Center  Bold c" Brush " x300 y170" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "4" , "s16 Center  Bold c" Brush " x299 y199" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "4" , "s16 Center  Bold c" Brush " x300 y200" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "5" , "s16 Center  Bold c" Brush " x299 y229" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "5" , "s16 Center  Bold c" Brush " x300 y230" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "6" , "s16 Center  Bold c" Brush " x299 y259" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "6" , "s16 Center  Bold c" Brush " x300 y260" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "7" , "s16 Center  Bold c" Brush " x299 y289" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "7" , "s16 Center  Bold c" Brush " x300 y290" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "8" , "s16 Center  Bold c" Brush " x299 y319" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "8" , "s16 Center  Bold c" Brush " x300 y320" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "9" , "s16 Center  Bold c" Brush " x299 y349" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "9" , "s16 Center  Bold c" Brush " x300 y350" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "10" , "s16 Center  Bold c" Brush " x299 y379" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "10" , "s16 Center  Bold c" Brush " x300 y380" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "1" , "s16 Center  Bold c" Brush " x584 y109" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "1" , "s16 Center  Bold c" Brush " x585 y110" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "2" , "s16 Center  Bold c" Brush " x584 y139" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "2" , "s16 Center  Bold c" Brush " x585 y140" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "3" , "s16 Center  Bold c" Brush " x584 y169" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "3" , "s16 Center  Bold c" Brush " x585 y170" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "4" , "s16 Center  Bold c" Brush " x584 y199" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "4" , "s16 Center  Bold c" Brush " x585 y200" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "5" , "s16 Center  Bold c" Brush " x584 y229" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "5" , "s16 Center  Bold c" Brush " x585 y230" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "6" , "s16 Center  Bold c" Brush " x584 y259" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "6" , "s16 Center  Bold c" Brush " x585 y260" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "7" , "s16 Center  Bold c" Brush " x584 y289" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "7" , "s16 Center  Bold c" Brush " x585 y290" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "8" , "s16 Center  Bold c" Brush " x584 y319" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "8" , "s16 Center  Bold c" Brush " x585 y320" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "9" , "s16 Center  Bold c" Brush " x584 y349" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "9" , "s16 Center  Bold c" Brush " x585 y350" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "10" , "s16 Center  Bold c" Brush " x584 y379" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF" ColorSet[1] )
	Gdip_TextToGraphics( G , "10" , "s16 Center  Bold c" Brush " x585 y380" , "Arial" , 30 , 30 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRectangle( G , Brush , 335 , 90 , 105 , 330 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 336 , 91 , 103 , 328 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRectangle( G , Brush , 620 , 90 , 105 , 330 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 621 , 91 , 103 , 328 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRectangle( G , Brush , 445 , 90 , 70 , 330 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 446 , 91 , 68 , 328 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRectangle( G , Brush , 730 , 90 , 70 , 330 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRectangle( G , Brush , 731 , 91 , 68 , 328 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 56 , 280 , 60 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 57 , 278 , 58 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 121 , 280 , 60 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 122 , 278 , 58 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 186 , 280 , 60 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 187 , 278 , 58 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 251 , 280 , 60 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 252 , 278 , 58 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 316 , 280 , 60 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 317 , 278 , 58 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 381 , 280 , 60 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 382 , 278 , 58 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "Save Clipboard Master 1 Clip" , "s10 Center vCenter Bold c" Brush " x4 y60" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFFffffff" )
	Gdip_TextToGraphics( G , "Save Clipboard Master 1 Clip" , "s10 Center vCenter Bold c" Brush " x5 y61" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "Save Clipboard Master 2 Clip" , "s10 Center vCenter Bold c" Brush " x4 y125" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFFffffff" )
	Gdip_TextToGraphics( G , "Save Clipboard Master 2 Clip" , "s10 Center vCenter Bold c" Brush " x5 y126" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "Switch Tabs" , "s10 Center vCenter Bold c" Brush " x4 y190" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFFffffff" )
	Gdip_TextToGraphics( G , "Switch Tabs" , "s10 Center vCenter Bold c" Brush " x5 y191" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "Hide Window" , "s10 Center vCenter Bold c" Brush " x4 y255" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFFffffff" )
	Gdip_TextToGraphics( G , "Hide Window" , "s10 Center vCenter Bold c" Brush " x5 y256" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "Teleport Window" , "s10 Center vCenter Bold c" Brush " x4 y320" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFFffffff" )
	Gdip_TextToGraphics( G , "Teleport Window" , "s10 Center vCenter Bold c" Brush " x5 y321" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF000000" )
	Gdip_TextToGraphics( G , "Save To First Available Slot" , "s10 Center vCenter Bold c" Brush " x4 y385" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFFffffff" )
	Gdip_TextToGraphics( G , "Save To First Available Slot" , "s10 Center vCenter Bold c" Brush " x5 y386" , "Arial" , 280 , 20 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 447 , 850 , 49 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 448 , 848 , 47 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 15 , 452 , 270 , 40 , 10 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF38393C" )
	Gdip_FillRoundedRectangle( G , Brush , 16 , 453 , 268 , 38 , 10 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 295 , 452 , 270 , 40 , 10 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF38393C" )
	Gdip_FillRoundedRectangle( G , Brush , 296 , 453 , 268 , 38 , 10 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrush( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 575 , 452 , 270 , 40 , 10 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF38393C" )
	Gdip_FillRoundedRectangle( G , Brush , 576 , 453 , 268 , 38 , 10 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 100 , 100 , "0xFF" ColorSet[1] , "0xFF000000" , 1 , 1 )
	Gdip_FillRoundedRectangle( G , Brush , 5 , 507 , 850 , 79 , 15 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF333437" )
	Gdip_FillRoundedRectangle( G , Brush , 6 , 508 , 848 , 77 , 15 )
	Gdip_DeleteBrush( Brush )
	Gdip_DeleteGraphics( G )
	return pBitmap
}

;######################################################################################################################################
;#####################################################   					    #######################################################
;#####################################################  	  Gdip LITE		    #######################################################
;#####################################################  					    #######################################################
;######################################################################################################################################
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster=""){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdi32\BitBlt", Ptr, dDC, "int", dx, "int", dy, "int", dw, "int", dh, Ptr, sDC, "int", sx, "int", sy, "uint", Raster ? Raster : 0x00CC0020)
}
Gdip_DrawImage(pGraphics, pBitmap, dx="", dy="", dw="", dh="", sx="", sy="", sw="", sh="", Matrix=1){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
	if(sx = "" && sy = "" && sw = "" && sh = ""){
		if(dx = "" && dy = "" && dw = "" && dh = ""){
			sx := dx := 0, sy := dy := 0
			sw := dw := Gdip_GetImageWidth(pBitmap)
			sh := dh := Gdip_GetImageHeight(pBitmap)
		}else	{
			sx := sy := 0,sw := Gdip_GetImageWidth(pBitmap),sh := Gdip_GetImageHeight(pBitmap)
		}
	}
	E := DllCall("gdiplus\GdipDrawImageRectRect", Ptr, pGraphics, Ptr, pBitmap, "float", dx, "float", dy, "float", dw, "float", dh, "float", sx, "float", sy, "float", sw, "float", sh, "int", 2, Ptr, ImageAttr, Ptr, 0, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}
Gdip_SetImageAttributesColorMatrix(Matrix){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	VarSetCapacity(ColourMatrix, 100, 0)
	Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", "", 1), "[^\d-\.]+", "|")
	StringSplit, Matrix, Matrix, |
	Loop, 25
	{
		Matrix := (Matrix%A_Index% != "") ? Matrix%A_Index% : Mod(A_Index-1, 6) ? 0 : 1
		NumPut(Matrix, ColourMatrix, (A_Index-1)*4, "float")
	}
	DllCall("gdiplus\GdipCreateImageAttributes", A_PtrSize ? "UPtr*" : "uint*", ImageAttr)
	DllCall("gdiplus\GdipSetImageAttributesColorMatrix", Ptr, ImageAttr, "int", 1, "int", 1, Ptr, &ColourMatrix, Ptr, 0, "int", 0)
	return ImageAttr
}
Gdip_GetImageWidth(pBitmap){
   DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
   return Width
}
Gdip_GetImageHeight(pBitmap){
   DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
   return Height
}
Gdip_DeletePen(pPen){
   return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
}
Gdip_DeleteBrush(pBrush){
   return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
}
Gdip_DisposeImage(pBitmap){
   return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}
Gdip_DeleteGraphics(pGraphics){
   return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}
Gdip_DisposeImageAttributes(ImageAttr){
	return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
}
Gdip_DeleteFont(hFont){
   return DllCall("gdiplus\GdipDeleteFont", A_PtrSize ? "UPtr" : "UInt", hFont)
}
Gdip_DeleteStringFormat(hFormat){
   return DllCall("gdiplus\GdipDeleteStringFormat", A_PtrSize ? "UPtr" : "UInt", hFormat)
}
Gdip_DeleteFontFamily(hFamily){
   return DllCall("gdiplus\GdipDeleteFontFamily", A_PtrSize ? "UPtr" : "UInt", hFamily)
}
CreateCompatibleDC(hdc=0){
   return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
SelectObject(hdc, hgdiobj){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}
DeleteObject(hObject){
   return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}
GetDC(hwnd=0){
	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}
GetDCEx(hwnd, flags=0, hrgnClip=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
}
ReleaseDC(hdc, hwnd=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}
DeleteDC(hdc){
   return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
Gdip_SetClipRegion(pGraphics, Region, CombineMode=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipSetClipRegion", Ptr, pGraphics, Ptr, Region, "int", CombineMode)
}
CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)
	NumPut(w, bi, 4, "uint"), NumPut(h, bi, 8, "uint"), NumPut(40, bi, 0, "uint"), NumPut(1, bi, 12, "ushort"), NumPut(0, bi, 16, "uInt"), NumPut(bpp, bi, 14, "ushort")
	hbm := DllCall("CreateDIBSection", Ptr, hdc2, Ptr, &bi, "uint", 0, A_PtrSize ? "UPtr*" : "uint*", ppvBits, Ptr, 0, "uint", 0, Ptr)
	if !hdc
		ReleaseDC(hdc2)
	return hbm
}
Gdip_GraphicsFromImage(pBitmap){
	DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
	return pGraphics
}
Gdip_GraphicsFromHDC(hdc){
    DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
    return pGraphics
}
Gdip_GetDC(pGraphics){
	DllCall("gdiplus\GdipGetDC", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", hdc)
	return hdc
}


Gdip_Startup(){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}
Gdip_TextToGraphics(pGraphics, Text, Options, Font="Arial", Width="", Height="", Measure=0){
	IWidth := Width, IHeight:= Height
	RegExMatch(Options, "i)X([\-\d\.]+)(p*)", xpos)
	RegExMatch(Options, "i)Y([\-\d\.]+)(p*)", ypos)
	RegExMatch(Options, "i)W([\-\d\.]+)(p*)", Width)
	RegExMatch(Options, "i)H([\-\d\.]+)(p*)", Height)
	RegExMatch(Options, "i)C(?!(entre|enter))([a-f\d]+)", Colour)
	RegExMatch(Options, "i)Top|Up|Bottom|Down|vCentre|vCenter", vPos)
	RegExMatch(Options, "i)NoWrap", NoWrap)
	RegExMatch(Options, "i)R(\d)", Rendering)
	RegExMatch(Options, "i)S(\d+)(p*)", Size)
	if !Gdip_DeleteBrush(Gdip_CloneBrush(Colour2))
		PassBrush := 1, pBrush := Colour2
	if !(IWidth && IHeight) && (xpos2 || ypos2 || Width2 || Height2 || Size2)
		return -1
	Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
	Loop, Parse, Styles, |
	{
		if RegExMatch(Options, "\b" A_loopField)
		Style |= (A_LoopField != "StrikeOut") ? (A_Index-1) : 8
	}
	Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
	Loop, Parse, Alignments, |
	{
		if RegExMatch(Options, "\b" A_loopField)
			Align |= A_Index//2.1      ; 0|0|1|1|2|2
	}
	xpos := (xpos1 != "") ? xpos2 ? IWidth*(xpos1/100) : xpos1 : 0
	ypos := (ypos1 != "") ? ypos2 ? IHeight*(ypos1/100) : ypos1 : 0
	Width := Width1 ? Width2 ? IWidth*(Width1/100) : Width1 : IWidth
	Height := Height1 ? Height2 ? IHeight*(Height1/100) : Height1 : IHeight
	if !PassBrush
		Colour := "0x" (Colour2 ? Colour2 : "ff000000")
	Rendering := ((Rendering1 >= 0) && (Rendering1 <= 5)) ? Rendering1 : 4
	Size := (Size1 > 0) ? Size2 ? IHeight*(Size1/100) : Size1 : 12
	hFamily := Gdip_FontFamilyCreate(Font)
	hFont := Gdip_FontCreate(hFamily, Size, Style)
	FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
	hFormat := Gdip_StringFormatCreate(FormatStyle)
	pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
	if !(hFamily && hFont && hFormat && pBrush && pGraphics)
		return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0
	CreateRectF(RC, xpos, ypos, Width, Height)
	Gdip_SetStringFormatAlign(hFormat, Align)
	Gdip_SetTextRenderingHint(pGraphics, Rendering)
	ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
	if vPos
	{
		StringSplit, ReturnRC, ReturnRC, |
		if (vPos = "vCentre") || (vPos = "vCenter")
			ypos += (Height-ReturnRC4)//2
		else if (vPos = "Top") || (vPos = "Up")
			ypos := 0
		else if (vPos = "Bottom") || (vPos = "Down")
			ypos := Height-ReturnRC4
		CreateRectF(RC, xpos, ypos, Width, ReturnRC4)
		ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
	}
	if !Measure
		E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)
	if !PassBrush
		Gdip_DeleteBrush(pBrush)
	Gdip_DeleteStringFormat(hFormat)
	Gdip_DeleteFont(hFont)
	Gdip_DeleteFontFamily(hFamily)
	return E ? E : ReturnRC
}
Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}
	return DllCall("gdiplus\GdipDrawString", Ptr, pGraphics, Ptr, A_IsUnicode ? &sString : &wString, "int", -1, Ptr, hFont, Ptr, &RectF, Ptr, hFormat, Ptr, pBrush)
}
Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode=1){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
	DllCall("gdiplus\GdipCreateLineBrush", Ptr, &PointF1, Ptr, &PointF2, "Uint", ARGB1, "Uint", ARGB2, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}
Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode=1, WrapMode=1){
	CreateRectF(RectF, x, y, w, h)
	DllCall("gdiplus\GdipCreateLineBrushFromRect", A_PtrSize ? "UPtr" : "UInt", &RectF, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}
Gdip_CloneBrush(pBrush){
	DllCall("gdiplus\GdipCloneBrush", A_PtrSize ? "UPtr" : "UInt", pBrush, A_PtrSize ? "UPtr*" : "UInt*", pBrushClone)
	return pBrushClone
}
Gdip_FontFamilyCreate(Font){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wFont, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, Ptr, &wFont, "int", nSize)
	}
	DllCall("gdiplus\GdipCreateFontFamilyFromName", Ptr, A_IsUnicode ? &Font : &wFont, "uint", 0, A_PtrSize ? "UPtr*" : "UInt*", hFamily)
	return hFamily
}
Gdip_SetStringFormatAlign(hFormat, Align){
   return DllCall("gdiplus\GdipSetStringFormatAlign", A_PtrSize ? "UPtr" : "UInt", hFormat, "int", Align)
}
Gdip_StringFormatCreate(Format=0, Lang=0){
   DllCall("gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, A_PtrSize ? "UPtr*" : "UInt*", hFormat)
   return hFormat
}
Gdip_FontCreate(hFamily, Size, Style=0){
   DllCall("gdiplus\GdipCreateFont", A_PtrSize ? "UPtr" : "UInt", hFamily, "float", Size, "int", Style, "int", 0, A_PtrSize ? "UPtr*" : "UInt*", hFont)
   return hFont
}
Gdip_CreatePen(ARGB, w){
   DllCall("gdiplus\GdipCreatePen1", "UInt", ARGB, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
   return pPen
}
Gdip_CreatePenFromBrush(pBrush, w){
	DllCall("gdiplus\GdipCreatePen2", A_PtrSize ? "UPtr" : "UInt", pBrush, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
	return pPen
}
Gdip_BrushCreateSolid(ARGB=0xff000000){
	DllCall("gdiplus\GdipCreateSolidFill", "UInt", ARGB, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}
Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle=0){
	DllCall("gdiplus\GdipCreateHatchBrush", "int", HatchStyle, "UInt", ARGBfront, "UInt", ARGBback, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}
CreateRectF(ByRef RectF, x, y, w, h){
   VarSetCapacity(RectF, 16)
   NumPut(x, RectF, 0, "float"), NumPut(y, RectF, 4, "float"), NumPut(w, RectF, 8, "float"), NumPut(h, RectF, 12, "float")
}
Gdip_SetTextRenderingHint(pGraphics, RenderingHint){
	return DllCall("gdiplus\GdipSetTextRenderingHint", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", RenderingHint)
}
Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	VarSetCapacity(RC, 16)
	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}
	DllCall("gdiplus\GdipMeasureString", Ptr, pGraphics, Ptr, A_IsUnicode ? &sString : &wString, "int", -1, Ptr, hFont, Ptr, &RectF, Ptr, hFormat, Ptr, &RC, "uint*", Chars, "uint*", Lines)
	return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
}
CreateRect(ByRef Rect, x, y, w, h){
	VarSetCapacity(Rect, 16)
	NumPut(x, Rect, 0, "uint"), NumPut(y, Rect, 4, "uint"), NumPut(w, Rect, 8, "uint"), NumPut(h, Rect, 12, "uint")
}
CreateSizeF(ByRef SizeF, w, h){
   VarSetCapacity(SizeF, 8)
   NumPut(w, SizeF, 0, "float"), NumPut(h, SizeF, 4, "float")
}
CreatePointF(ByRef PointF, x, y){
   VarSetCapacity(PointF, 8)
   NumPut(x, PointF, 0, "float"), NumPut(y, PointF, 4, "float")
}
Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawArc", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}
Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawPie", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}
Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawLine", Ptr, pGraphics, Ptr, pPen, "float", x1, "float", y1, "float", x2, "float", y2)
}
Gdip_DrawLines(pGraphics, pPen, Points){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}
	return DllCall("gdiplus\GdipDrawLines", Ptr, pGraphics, Ptr, pPen, Ptr, &PointF, "int", Points0)
}
Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillRectangle", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}
Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r){
	Region := Gdip_GetClipRegion(pGraphics)
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	E := Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_FillEllipse(pGraphics, pBrush, x, y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x, y+h-(2*r), 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_DeleteRegion(Region)
	return E
}
Gdip_GetClipRegion(pGraphics){
	Region := Gdip_CreateRegion()
	DllCall("gdiplus\GdipGetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics, "UInt*", Region)
	return Region
}
Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode=0){
   return DllCall("gdiplus\GdipSetClipRect",  A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode)
}
Gdip_SetClipPath(pGraphics, Path, CombineMode=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipSetClipPath", Ptr, pGraphics, Ptr, Path, "int", CombineMode)
}
Gdip_ResetClip(pGraphics){
   return DllCall("gdiplus\GdipResetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}
Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillEllipse", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}
Gdip_FillRegion(pGraphics, pBrush, Region){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillRegion", Ptr, pGraphics, Ptr, pBrush, Ptr, Region)
}
Gdip_FillPath(pGraphics, pBrush, Path){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipFillPath", Ptr, pGraphics, Ptr, pBrush, Ptr, Path)
}
Gdip_CreateRegion(){
	DllCall("gdiplus\GdipCreateRegion", "UInt*", Region)
	return Region
}
Gdip_DeleteRegion(Region){
	return DllCall("gdiplus\GdipDeleteRegion", A_PtrSize ? "UPtr" : "UInt", Region)
}
Gdip_CreateBitmap(Width, Height, Format=0x26200A){
    DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
    Return pBitmap
}
Gdip_SetSmoothingMode(pGraphics, SmoothingMode){
   return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", SmoothingMode)
}
Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawRectangle", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}
Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r){
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	E := Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
	Gdip_ResetClip(pGraphics)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_DrawEllipse(pGraphics, pPen, x, y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x, y+h-(2*r), 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_ResetClip(pGraphics)
	return E
}
Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipDrawEllipse", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}
Gdip_CreateHBITMAPFromBitmap(pBitmap, Background=0xffffffff){
	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hbm, "int", Background)
	return hbm
}
SetImage(hwnd, hBitmap){
	SendMessage, 0x172, 0x0, hBitmap,, ahk_id %hwnd%
	E := ErrorLevel
	DeleteObject(E)
	return E
}
Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}
	return DllCall("gdiplus\GdipFillPolygon", Ptr, pGraphics, Ptr, pBrush, Ptr, &PointF, "int", Points0, "int", FillMode)
}