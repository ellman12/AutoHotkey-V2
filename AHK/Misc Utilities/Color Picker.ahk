;Source: https://www.autohotkey.com/boards/viewtopic.php?t=60942
#SingleInstance, Force
SetBatchLines,-1 
#NoEnv
SetWorkingDir,%A_ScriptDir%
pButton_StartUp()
global pButton:={} 
global Press_active:=0,Hover_On:=0,Active_Button
global Main_Window:={Y: 0 , W: 300 , H: 600 }
Main_Window.X:=(A_ScreenWidth-Main_Window.W)-100
global REDSLIDERVALUE := 0 , GREENSLIDERVALUE := 0 , BLUESLIDERVALUE := 0 , RGBCOLORBLOCK := "000000" , GREYSCALESLIDERVALUE := 0 , GREYSCALECOLORBLOCK := "000000"
global REDTRIGGER , GREENTRIGGER , BLUETRIGGER , GREYSCALETRIGGER , OUTPUTCOLOR
global REDHEXVALUE := "00" , GREENHEXVALUE := "00" , BLUEHEXVALUE := "00" , GREYSCALEHEXVALUE := "00"
global REDDECVALUE := "0" , GREENDECVALUE := "0" , BLUEDECVALUE := "0" , GREYSCALEDECVALUE := GREYSCALESLIDERVALUE
global REDMIN1:=0 , REDMAX1:=255 , REDMIN2:=0 , REDMAX2:=255
global GREENMIN1:=0 , GREENMAX1:=255 , GREENMIN2:=0 , GREENMAX2:=255
global BLUEMIN1:=0 , BLUEMAX1:=255 , BLUEMIN2:=0 , BLUEMAX2:=255
global Saved_Colors_List:= [] , SAVEDCOLOREDIT:="" , ALLOWNEWSAVEDVALUE:=0
IfExist, Color_Picker_v2_Saved_Colors_List.txt
{
	FileRead,svdcol,Color_Picker_v2_Saved_Colors_List.txt
	Loop, Parse, svdcol ,*		
		Saved_Colors_List[A_Index]:=A_LoopField
}
IfNotExist, Color_Picker_v2_Saved_Colors_List.txt
{	
	Loop, 150	{
		Saved_Colors_List[A_Index]:="777777",tempcollist:="777777*" 
		FileAppend,%tempcollist%,Color_Picker_v2_Saved_Colors_List.txt
	}
}
Create_Main_Window(),Create_SUB_Window(),CREATE_MIXER_WINDOW(),CREATE_SAVED_WINDOW(),CREATE_RANDOM_WINDOW()
SetTimer,SETPICKERONTOP,400
return
GuiClose:
	ExitApp
GuiContextMenu:
	(Tog:=!Tog)?(Main_Window.H:=40):(Main_Window.H:=600)
	Gui,1:Show,% "h" Main_Window.H " NA"
	return
CREATE_MIXER_WINDOW(){
	Gui, 3: +Parent2 -DPIScale -Caption
	Gui, 3: Color, 333333 , 333333
	DRAW_OUTLINE( 3 , 0 , 0 ,250  , 470 , "444444" , "black" ),DRAW_OUTLINE( 3 , 1 , 1 ,248  , 468 , "333333" , "111111" )
	ADD_COLOR_DISPLAYS(),ADD_RGB_SLIDERS(),ADD_GREYSCALE_SLIDERS(),ADD_MIXER_BUTTONS()
	Gui, 3: Show,x7 y10 w250 h470
}
CREATE_SAVED_WINDOW(){
	global
	Gui, 4: +Parent2 -DPIScale -Caption
	Gui, 4: Color,333333,222222
	x:=25
	Loop, 11	{
		Gui,4:Add,Progress,x%x% y40 w1 h300 BackgroundBlack
		x+=20
	}
	y:=40
	Loop, 16	{
		Gui,4:Add,Progress,x25 y%y% w200 h1 BackgroundBlack
		y+=20
	}	
	y:=41,i:=1
	Loop, 15	{
		x:=26
		Loop, 10	{
			Gui,4:Add,Text,x%x% y%y% w19 h19 BackgroundTrans vGUISavedColorTRIGGER_%i% gChange_Colors
			Gui,4:Add,Progress,% "x" x " y" y " w19 h19 Background" Saved_Colors_List[i] " vGUISavedColor_" i
			i++,x+=20
		}
		y+=20	
	}
	Gui,4:Font,caaaaaa s10 w500,Segoe ui
	Gui,4:add,Edit, x75 y355 w100 h20 Center Uppercase -E0x200 vSAVEDCOLOREDIT gSubmit_4,
	DRAW_OUTLINE( 4 , 74 , 354 ,102  , 22 , "777777" , "666666" )
	pButton.Push(New Progress_Button("4",pButton.Length()+1,"SETADDTOSAVEDLIST",10,390,110,20,"111111","777777","252525","880000","992222","ADD COLOR",1))
	pButton.Push(New Progress_Button("4",pButton.Length()+1,"SETREMOVEFROMSAVEDLIST",130,390,110,20,"111111","777777","252525","880000","992222","REMOVE COLOR",1))
	pButton.Push(New Progress_Button("4",pButton.Length()+1,"CLEARALLSAVEDCOLORS",50,420,150,30,"111111","777777","252525","880000","992222","CLEAR ALL COLORS",7))
	Gui, 4: Show,x7 y10 w250 h470
	Gui, 4: Hide
}
CLEARALLSAVEDCOLORS(){
	stime:=A_TickCount
	While(GETKEYSTATE("LBUTTON")){
		if(A_TickCount-stime>3000){
			Loop 150	{
				GuiControl,% "4:+Background777777", GUISavedColor_%A_Index%
				Saved_Colors_List[A_Index]:="777777"
			}
			SAVECOLORLISTTOFILE()
			return			
		}
	}
}
Change_Colors(){
	if(ALLOWNEWSAVEDVALUE=1){
		ALLOWNEWSAVEDVALUE:=0
		StringTrimLeft,tsop,A_GUICONTROL,21
		Saved_Colors_List[tsop]:=SAVEDCOLOREDIT
		GuiControl,% "4:+Background" Saved_Colors_List[tsop], GUISavedColor_%tsop%
		SAVECOLORLISTTOFILE()
	}else if(ALLOWNEWSAVEDVALUE=2){
		ALLOWNEWSAVEDVALUE:=0
		StringTrimLeft,tsop,A_GUICONTROL,21
		Saved_Colors_List[tsop]:="777777"
		GuiControl,% "4:+Background" Saved_Colors_List[tsop], GUISavedColor_%tsop%
		SAVECOLORLISTTOFILE()
	}
}
Submit_4(){
	Gui,4:Submit,NoHide
}
SETREMOVEFROMSAVEDLIST(){
	IF( !PBUTTON[ A_GUICONTROL ].BUTTON_PRESS() ) 
		RETURN
	ALLOWNEWSAVEDVALUE:=2
}
SETADDTOSAVEDLIST(){
	IF( !PBUTTON[ A_GUICONTROL ].BUTTON_PRESS() ) 
		RETURN
	ALLOWNEWSAVEDVALUE:=1
}
SAVECOLORLISTTOFILE(){
	FileDelete,Color_Picker_v2_Saved_Colors_List.txt
	Loop, 150	{
		tvtstf:=Saved_Colors_List[A_Index] "*"
		FileAppend,%tvtstf%,Color_Picker_v2_Saved_Colors_List.txt
	}
}
Move_Window(){
	POSTMESSAGE , 0XA1 , 2
	SETTIMER , WATCH_HOVER , OFF
	WHILE( GETKEYSTATE( "LBUTTON" ) )
		SLEEP , 10
	SETTIMER , WATCH_HOVER , ON
}
DRAW_OUTLINE( GUI_NAME , X , Y , W , H , COLOR1 :="BLACK", COLOR2 := "BLACK" , THICKNESS := 1 ) {
	GUI , % GUI_NAME ": ADD" , PROGRESS , % "X" X " Y" Y " W" W " H" THICKNESS " BACKGROUND" COLOR1 
	GUI , % GUI_NAME ": ADD" , PROGRESS , % "X" X " Y" Y " W" THICKNESS " H" H " BACKGROUND" COLOR1 
	GUI , % GUI_NAME ": ADD" , PROGRESS , % "X" X " Y" Y + H - THICKNESS " W" W " H" THICKNESS " BACKGROUND" COLOR2 
	GUI , % GUI_NAME ": ADD" , PROGRESS , % "X" X + W - THICKNESS " Y" Y " W" THICKNESS " H" H " BACKGROUND" COLOR2 	
}
DRAW_LINE( GUI_NAME , X , Y , W , H , COLOR ) {
	GUI , % GUI_NAME ": ADD" , PROGRESS , % "X" X " Y" Y " W" W " H" H " BACKGROUND" COLOR 
}
ADD_GREYSCALE_SLIDERS(){
	Gui, 3:Font,caaaaaa s10 w600 , Segoe UI
	Gui, 3:Add,Text,x190 y140 w20 h256 vGREYSCALETRIGGER gADJUST_SLIDER 
	Gui, 3:Add,Progress,x165 y110 w70 h316 Background111111 
	Gui, 3:Add,Edit,x170 y115 w60 h20 Center -E0x200 Disabled vGREYSCALEHEXVALUE ,% GREYSCALEHEXVALUE
	Gui, 3:Add,Progress,x190 y140 w20 h256 Background333333 c888888 Range0-255 Vertical vGREYSCALESLIDERVALUE ,% GREYSCALESLIDERVALUE
	Gui, 3:Add,Edit,x170 y401 w60 h20 Center -E0x200 Disabled vGREYSCALEDECVALUE ,% GREYSCALEDECVALUE
}
ADD_RGB_SLIDERS(){
	Gui, 3:Add,Text,x30 y140 w20 h256 vREDTRIGGER gADJUST_SLIDER
	Gui, 3:Add,Text,x73 y140 w20 h256 vGREENTRIGGER gADJUST_SLIDER
	Gui, 3:Add,Text,x115 y140 w20 h256 vBLUETRIGGER gADJUST_SLIDER
	Gui, 3:Add,Progress,x10 y110 w145 h316 Background111111 
	Gui, 3:Font,cffffff s10 w600 , Segoe UI
	Gui, 3:Add,Edit,x25 y115 w30 h20 Center -E0x200 Disabled vREDHEXVALUE ,% REDHEXVALUE
	Gui, 3:Add,Edit,x68 y115 w30 h20 Center -E0x200 Disabled vGREENHEXVALUE ,% GREENHEXVALUE
	Gui, 3:Add,Edit,x110 y115 w30 h20 Center -E0x200 Disabled vBLUEHEXVALUE ,% BLUEHEXVALUE
	Gui, 3:Add,Progress,x30 y140 w20 h256 Background330000 caa2222 Range0-255 Vertical vREDSLIDERVALUE,% REDSLIDERVALUE
	Gui, 3:Add,Progress,x73 y140 w20 h256 Background003300 c22aa22 Range0-255 Vertical vGREENSLIDERVALUE,% GREENSLIDERVALUE
	Gui, 3:Add,Progress,x115 y140 w20 h256 Background000033 c2222aa Range0-255 Vertical vBLUESLIDERVALUE,% BLUESLIDERVALUE
	Gui, 3:Add,Edit,x25 y401 w30 h20 Center -E0x200 Disabled vREDDECVALUE ,% REDDECVALUE
	Gui, 3:Add,Edit,x68 y401 w30 h20 Center -E0x200 Disabled vGREENDECVALUE ,% GREENDECVALUE
	Gui, 3:Add,Edit,x110 y401 w30 h20 Center -E0x200 Disabled vBLUEDECVALUE ,% BLUEDECVALUE
}
GETCOLORFROMSCREEN(){
	IF( !PBUTTON[ A_GUICONTROL ].BUTTON_PRESS() ) 
		RETURN
	While(!GetKeyState("Ctrl")){
		CoordMode,Mouse,Screen
		CoordMode,Pixel,Screen
		Tooltip, Press ""Ctrl"" to lock color. %OUTPUTCOLOR%
		MouseGetPos,tcx,tcy
		PixelGetColor,OUTPUTCOLOR,tcx,tcy,RGB
		UPDATECOLORDISPLAYS(OUTPUTCOLOR)
	}
	ToolTip,
	StringTrimLeft,OUTPUTCOLOR,OUTPUTCOLOR,2
	Clipboard:=OUTPUTCOLOR
	GuiControl,4:,SAVEDCOLOREDIT,% OUTPUTCOLOR
}
UPDATECOLORDISPLAYS(OUTPUTCOLOR){
	StringTrimLeft,OUTPUTCOLOR,OUTPUTCOLOR,2
	StringLeft , r ,  OUTPUTCOLOR , 2
	StringTrimLeft,OUTPUTCOLOR,OUTPUTCOLOR,2
	StringLeft , g ,  OUTPUTCOLOR , 2
	StringTrimLeft,OUTPUTCOLOR,OUTPUTCOLOR,2
	StringLeft , b ,  OUTPUTCOLOR , 2
	r:= "0x" r,g:="0x" g,b:="0x" b
	REDSLIDERVALUE:=r+0,GreenSLIDERVALUE:=g+0,BlueSLIDERVALUE:=b+0
	GreyScaleSLIDERVALUE:=Round((REDSLIDERVALUE+GreenSLIDERVALUE+BlueSLIDERVALUE)/3)
	GuiControl,3:,REDSLIDERVALUE,% REDSLIDERVALUE
	GuiControl,3:,GreenSLIDERVALUE,% GreenSLIDERVALUE
	GuiControl,3:,BlueSLIDERVALUE,% BlueSLIDERVALUE
	GuiControl,3:,GreyScaleSLIDERVALUE,% GreyScaleSLIDERVALUE
	UPDATERGBCOLORBLOCK(REDSLIDERVALUE,GreenSLIDERVALUE,BlueSLIDERVALUE,GreyScaleSLIDERVALUE)
}
ADJUST_SLIDER(){
	Coordmode,Mouse,Client
	SLIDERVALUE:=0
	While(GETKEYSTATE("LButton")){
		MouseGetPos,Rx,Ry
		if(GETKEYSTATE("UP")){
			if(ry-1>194)
				MouseMove,Rx,ry-1
			KeyWait,Up,Up
		}else if(GETKEYSTATE("Down")){
			if(ry+1<451)
				MouseMove,Rx,ry+1
			KeyWait,Down,Up
		}else if(GETKEYSTATE("Left")){
			if(ry+1<451)
				MouseMove,Rx,ry+1
		}else if(GETKEYSTATE("Right")){
			if(ry-1>194)
				MouseMove,Rx,ry-1
		}
		SLIDERVALUE:=(RY-195) * -1 
		(SLIDERVALUE < -255) ? (SLIDERVALUE:=-255) : (SLIDERVALUE > 0) ? (SLIDERVALUE:=0)
		if(A_GuiControl="REDTRIGGER"){
		REDSLIDERVALUE:=SLIDERVALUE+255
		GuiControl,3:,REDSLIDERVALUE,% REDSLIDERVALUE 
		ToolTip,% REDSLIDERVALUE
		}else if(A_GuiControl="GREENTRIGGER"){
		GREENSLIDERVALUE:=SLIDERVALUE+255
		GuiControl,3:,GREENSLIDERVALUE,% GREENSLIDERVALUE 
		ToolTip,% GREENSLIDERVALUE
		}else if(A_GuiControl="BLUETRIGGER"){
		BLUESLIDERVALUE:=SLIDERVALUE+255
		GuiControl,3:,BLUESLIDERVALUE,% BLUESLIDERVALUE 
		ToolTip,% BLUESLIDERVALUE
		}else if(A_GuiControl="GREYSCALETRIGGER"){
		GREYSCALESLIDERVALUE:=SLIDERVALUE+255
		GuiControl,3:,GREYSCALESLIDERVALUE,% GREYSCALESLIDERVALUE 
		ToolTip,% GREYSCALESLIDERVALUE
		}
		UPDATERGBCOLORBLOCK(REDSLIDERVALUE,GREENSLIDERVALUE,BLUESLIDERVALUE,GREYSCALESLIDERVALUE)
	}
	ToolTip,
}
Create_SUB_Window(){
	Gui, 2: +Parent1 -DPIScale -Caption
	Gui, 2: Color, 111111
	DRAW_OUTLINE( 2 , 0 , 0 ,260  , 575, "444444" , "black" ),DRAW_OUTLINE( 2 , 1 , 1 ,258  , 573, "333333" , "111111" )
	Gui, 2: Show,% "x30 y45 w" Main_Window.W-40 " h" Main_Window.H - 75
}
SETPICKERONTOP(){
	WINGETTITLE,CWIN,A
	IF(CWIN!="HB Color Picker v2.0.1")
		GUI,1:SHOW,NA
}
Create_Main_Window(){
	Gui, 1: +AlwaysOnTop -DPIScale -Caption +LastFound
	Winset,Transcolor,112343
	Gui, 1: Color,112343 
	Gui,1:Font,caaaaaa s10 w600 , Segoe UI
	pButton.Push(New Progress_Button("1",pButton.Length()+1,"Move_Window",floor((Main_Window.W-150)//2),10,150,30,"BLACK","777777","333333","003366","BLACK","HB Color Picker",5))
	pButton.Push(New Progress_Button("1",pButton.Length()+1,"RGBSUBWINDOW",6,60,23,120,"444444","777777","333333","003366","003388","M`nI`nX`nE`nR",15))
	pButton.Push(New Progress_Button("1",pButton.Length()+1,"SAVEDSUBWINDOW",6,190,23,120,"444444","777777","333333","003366","003388","S`nA`nV`nE`nD",15))
	pButton.Push(New Progress_Button("1",pButton.Length()+1,"RANDOMSUBWINDOW",6,320,23,120,"444444","777777","333333","003366","003388","R`nA`nN`nD`nO`nM",8))
	pButton.Push(New Progress_Button("1",pButton.Length()+1,"GETCOLORFROMSCREEN",75,530,170,30,"111111","777777","252525","008833","992222","GET COLOR",5))
	Gui, 1: Show,% "x" Main_Window.X " y" Main_Window.Y " w" Main_Window.W " h" Main_Window.H , HB Color Picker v2.0.1
}
CREATE_RANDOM_WINDOW(){
	Gui, 5: +Parent2 -DPIScale -Caption
	Gui, 5: Color, 222222,333333
	DRAW_OUTLINE( 5 , 0 , 0 ,250  , 470 , "444444" , "black" ),DRAW_OUTLINE( 5 , 1 , 1 ,248  , 468 , "333333" , "111111" )
	Gui,5:Font,cdddddd s10 ,Segoe Ui
	Gui,5:Add,Text,cRed x15 y5 w65 h18 BackgroundTrans Center ,RED
	Gui,5:Add,Text,cGreen x90 y5 w65 h18 BackgroundTrans Center ,GREEN
	Gui,5:Add,Text,c0055ff x165 y5 w65 h18 BackgroundTrans Center ,BLUE
	Gui,5:Add,Edit,x15 y25 w30 h18 -e0x200  Center Number Limit3 vREDMIN1 gSUBMIT_5 , % REDMIN1
	Gui,5:Add,Edit,x50 y25 w30 h18 -e0x200  Center Number Limit3 vREDMAX1 gSUBMIT_5 , % REDMAX1
	Gui,5:Add,Edit,x90 y25 w30 h18 -e0x200  Center Number Limit3 vGREENMIN1 gSUBMIT_5 , % GREENMIN1
	Gui,5:Add,Edit,x125 y25 w30 h18 -e0x200  Center Number Limit3 vGREENMAX1  gSUBMIT_5 , % GREENMAX1
	Gui,5:Add,Edit,x165 y25 w30 h18 -e0x200  Center Number Limit3 vBLUEMIN1 gSUBMIT_5 , % BLUEMIN1
	Gui,5:Add,Edit,x200 y25 w30 h18 -e0x200  Center Number Limit3 vBLUEMAX1 gSUBMIT_5 , % BLUEMAX1
	pButton.Push(New Progress_Button("5",pButton.Length()+1,"Create_RANDOM_SET",60,200,130,20,"BLACK","777777","333333","003366","BLACK","GENERATE",0))
	Gui,5:Add,Text,cRed x15 y225 w65 h18 BackgroundTrans Center ,RED
	Gui,5:Add,Text,cGreen x90 y225 w65 h18 BackgroundTrans Center ,GREEN
	Gui,5:Add,Text,c0055ff x165 y225 w65 h18 BackgroundTrans Center ,BLUE
	Gui,5:Add,Edit,x15 y245 w30 h18 -e0x200  Center Number Limit3 vREDMIN2 gSUBMIT_5 , % REDMIN2
	Gui,5:Add,Edit,x50 y245 w30 h18 -e0x200  Center Number Limit3 vREDMAX2 gSUBMIT_5 , % REDMAX2
	Gui,5:Add,Edit,x90 y245 w30 h18 -e0x200  Center Number Limit3 vGREENMIN2 gSUBMIT_5 , % GREENMIN2
	Gui,5:Add,Edit,x125 y245 w30 h18 -e0x200  Center Number Limit3 vGREENMAX2  gSUBMIT_5 , % GREENMAX2
	Gui,5:Add,Edit,x165 y245 w30 h18 -e0x200  Center Number Limit3 vBLUEMIN2 gSUBMIT_5 , % BLUEMIN2
	Gui,5:Add,Edit,x200 y245 w30 h18 -e0x200  Center Number Limit3 vBLUEMAX2 gSUBMIT_5 , % BLUEMAX2
	pButton.Push(New Progress_Button("5",pButton.Length()+1,"Create_RANDOM_SET",60,440,130,20,"BLACK","777777","333333","003366","BLACK","GENERATE",0))
	Gui, 5: Show,x7 y10 w250 h470
}
SUBMIT_5(){
	Gui,5:Submit,NoHide
}
Create_RANDOM_SET(){
	IF( !PBUTTON[ A_GUICONTROL ].BUTTON_PRESS() ) 
		RETURN
	(A_GuiControl=11)?(GENERATERANDOMCOLORWINDOWS(6,REDMIN1,REDMAX1,GREENMIN1,GREENMAX1,BLUEMIN1,BLUEMAX1,50,7))
	:(A_GuiControl=12)?(GENERATERANDOMCOLORWINDOWS(7,REDMIN2,REDMAX2,GREENMIN2,GREENMAX2,BLUEMIN2,BLUEMAX2,270,8))
}
GENERATERANDOMCOLORWINDOWS(genWindow,RMIN,RMAX,GMIN,GMAX,BMIN,BMAX,yttt,lc){
	Gui,% genWindow ": Destroy"
	Gui,% genWindow ": +Parent5 -Caption -DPISCALE"
	Gui,% genWindow ":Color" ,222222
	y:=0,tw:=20,th:=tw
	Loop, % LC	{
		x:=0
		Loop, 10	{
			RandomColor:=Random_Colour(RMIN,RMAX,GMIN,GMAX,BMIN,BMAX)
			Gui,% genWindow ": Add" ,Progress,x%x% y%y% w%tw% h%th% Background%RandomColor%
			x+=tw
		}
		y+=th	
	}
	Gui,% genWindow ": Show",x25 y%yttt% w200 h160
}
ADD_MIXER_BUTTONS(){
	pButton.Push(New Progress_Button("3",pButton.Length()+1,"CLIPRGB",20,438,100,20,"111111","777777","252525","880000","992222","CLIP RGB",1))
	pButton.Push(New Progress_Button("3",pButton.Length()+1,"CLIPGREYSCALE",130,438,100,20,"111111","777777","252525","880000","992222","CLIP GREY",1))
	DRAW_LINE( 3 , 21 , 458 , 100 , 1 , "222222" ),DRAW_LINE( 3 , 120 , 439 , 1 , 20 , "222222" ),DRAW_LINE( 3 , 131 , 458 , 100 , 1 , "222222" ),DRAW_LINE( 3 , 230 , 439 , 1 , 20 , "222222" )
}
RGBSUBWINDOW(){
	IF( !PBUTTON[ A_GUICONTROL ].BUTTON_PRESS() ) 
		RETURN
	GUI,3:Show
	Gui,4:Hide
	Gui,5:Hide
}
SAVEDSUBWINDOW(){
	IF( !PBUTTON[ A_GUICONTROL ].BUTTON_PRESS() ) 
		RETURN
	GUI,4:Show
	Gui,3:Hide
	Gui,5:Hide
}
RANDOMSUBWINDOW(){
	IF( !PBUTTON[ A_GUICONTROL ].BUTTON_PRESS() ) 
		RETURN
	GUI,5:Show
	Gui,3:Hide
	Gui,4:Hide
}
CLIPRGB(){
	IF( !PBUTTON[ A_GUICONTROL ].BUTTON_PRESS() ) 
		RETURN
	Clipboard := RGBCOLORBLOCK
	GuiControl,4:,SAVEDCOLOREDIT,% RGBCOLORBLOCK
}
CLIPGREYSCALE(){
	IF( !PBUTTON[ A_GUICONTROL ].BUTTON_PRESS() ) 
		RETURN
	Clipboard := GREYSCALECOLORBLOCK
	GuiControl,4:,SAVEDCOLOREDIT,% GREYSCALECOLORBLOCK
}
UPDATERGBCOLORBLOCK(REDSLIDERVALUEt,GREENSLIDERVALUEt,BLUESLIDERVALUEt,GREYSCALESLIDERVALUEt){
	GuiControl,3:,GREYSCALEDECVALUE,% GREYSCALESLIDERVALUEt
	GuiControl,3:,REDDECVALUE,% REDSLIDERVALUEt
	GuiControl,3:,GREENDECVALUE,% GREENSLIDERVALUEt
	GuiControl,3:,BLUEDECVALUE,% BLUESLIDERVALUEt
	SETFORMAT , INTEGER , HEX
	REDSLIDERVALUEt += 0 , GREENSLIDERVALUEt += 0 , BLUESLIDERVALUEt += 0 , GREYSCALESLIDERVALUEt += 0
	StringTrimLeft,GREYSCALESLIDERVALUEt,GREYSCALESLIDERVALUEt,2
	StringTrimLeft,REDSLIDERVALUEt,REDSLIDERVALUEt,2
	StringTrimLeft,GREENSLIDERVALUEt,GREENSLIDERVALUEt,2
	StringTrimLeft,BLUESLIDERVALUEt,BLUESLIDERVALUEt,2
	SETFORMAT , INTEGER , DECIMAL
	(strlen(GREYSCALESLIDERVALUEt)=1)?(GREYSCALESLIDERVALUEt:="0" GREYSCALESLIDERVALUEt)
	(strlen(REDSLIDERVALUEt)=1)?(REDSLIDERVALUEt:="0" REDSLIDERVALUEt)
	(strlen(GREENSLIDERVALUEt)=1)?(GREENSLIDERVALUEt:="0" GREENSLIDERVALUEt)
	(strlen(BLUESLIDERVALUEt)=1)?(BLUESLIDERVALUEt:="0" BLUESLIDERVALUEt)
	GuiControl,3:,GREYSCALEHEXVALUE,% GREYSCALESLIDERVALUEt
	GREYSCALESLIDERVALUEt.= GREYSCALESLIDERVALUEt GREYSCALESLIDERVALUEt
	GREYSCALECOLORBLOCK := GREYSCALESLIDERVALUEt
	GuiControl,3:,REDHEXVALUE,% REDSLIDERVALUEt
	GuiControl,3:,GREENHEXVALUE,% GREENSLIDERVALUEt
	GuiControl,3:,BLUEHEXVALUE,% BLUESLIDERVALUEt
	RGBCOLORBLOCK:= REDSLIDERVALUEt . GREENSLIDERVALUEt . BLUESLIDERVALUEt
	GuiControl, 3: +c%RGBCOLORBLOCK% , RGBCOLORBLOCK,
	GuiControl, 3: +c%GREYSCALECOLORBLOCK% , GREYSCALECOLORBLOCK,
}
ADD_COLOR_DISPLAYS(){
	Gui,3:Add,Progress,x7 y6 w235 h100 Background222222
	DRAW_OUTLINE( 3 , 6 , 5 , 237 , 102 , "444444" , "black" )
	Gui, 3:Add,Progress,x20 y15 w130 h80 BackgroundBlack c%RGBCOLORBLOCK% vRGBCOLORBLOCK, 100
	DRAW_OUTLINE( 3 , 19 , 14 , 132 , 82 , "111111" , "111111" )
	Gui, 3:Add,Progress,x160 y15 w70 h80 BackgroundBlack c%GREYSCALECOLORBLOCK% vGREYSCALECOLORBLOCK, 100
	DRAW_OUTLINE( 3 , 159 , 14 , 72 , 82 , "111111" , "111111" )
}
Random_Colour(Range_R_Min:=0,Range_R_Max:=255,Range_G_Min:=0,Range_G_Max:=255,Range_B_Min:=0,Range_B_Max:=255){
	 RGBCOLOR := { 1 : ( Random( Range_R_Min , Range_R_Max ) ) , 2 : Random( Range_G_Min , Range_G_Max ) , 3 : Random( Range_B_Min , Range_B_Max ) }
	FOR COLOR IN RGBCOLOR	{
		SETFORMAT , INTEGER , HEX
		RGBCOLOR[ A_INDEX ] += 0
		TEMP := RGBCOLOR[A_INDEX]
		STRINGREPLACE , TEMP , TEMP , 0x 
		RGBCOLOR[A_INDEX] := TEMP
		SETFORMAT , INTEGER , DECIMAL	
		IF( STRLEN( RGBCOLOR[ A_INDEX ] ) < 2 )
			RGBCOLOR[ A_INDEX ] := "0" RGBCOLOR[ A_INDEX ]
		TEMPCOLOR .= RGBCOLOR[ A_INDEX ]
	}
	RETURN TEMPCOLOR
}
Random(MIN,MAX){
	Random,OUTPUT,MIN,MAX
	return OUTPUT
}
pButton_StartUp(){
	SetTimer,Watch_Hover,10
}
Watch_Hover(){
	global
	if(Press_active=0){
		if(Hover_On=0){
			MouseGetPos,,,,ctrl,2
			loop,% pButton.Length()	{
				GuiControlGet,cName,% pButton[A_Index].Window_Name ":Name",% ctrl
				cut:=Strlen(cName)
				StringLeft,bName,cName,cut-2
					if(bname=pButton[A_Index].Button_Name){
						pButton[A_Index].Button_Hover_On()
						Hover_On:=1,Active_Button:=bname,win:=pButton[A_Index].Window_Name
						return
					}
			}
		}else if(Hover_On=1){
			MouseGetPos,,,,ctrl,2
			GuiControlGet,cName,%win%:Name,% ctrl
			cut:=Strlen(cName)
			StringLeft,nBName,cName,cut-2
			if(NbName!=Active_Button){
				pButton[Active_Button].Button_Hover_Off(),Hover_On:=0,Active_Button:=""
			}
		}
	}
}
Class Progress_Button	{
	__New(Window_Name,Button_Name,Label,x,y,w,h,BC,TRC,TC1,TC2,TC3,Button_Text,Text_Offset:=0){
		This.Text_Offset:=Text_Offset,This.Window_Name:=Window_Name,This.Button_Name:=Button_Name,This.Label:=Label
		This.Button_ID1:=Button_Name "_1",This.Button_ID2:=Button_Name "_2",This.Button_ID3:=Button_Name "_3",This.Button_ID4:=Button_Name "_4"
		This.Button_Text:=Button_Text,This.X:=x,This.Y:=y,This.W:=w,This.H:=h
		This.Bottom_Color:=BC,This.Trim_Color:=TRC,This.Top_Color_1:=TC1,This.Top_Color_2:=TC2,This.Top_Color_3:=TC3
		This.Add_Button()
	}
	Add_Button(){
		global
		Gui,% This.Window_Name ":Add",Text,% "x" This.X " y" This.Y " w" This.W " h" This.H " v" This.Button_Name " g" This.Label
		Gui,% This.Window_Name ":Add",Progress,% "x" This.X " y" This.Y " w" This.W " h" This.H " Background" This.Bottom_Color " v" This.Button_ID1
		Gui,% This.Window_Name ":Add",Progress,% "x" This.X " y" This.Y " w" This.W-1 " h" This.H-1 " Background" This.Trim_Color " v" This.Button_ID2
		Gui,% This.Window_Name ":Add",Progress,% "x" This.X+1 " y" This.Y+1 " w" This.W-2 " h" This.H-2 " Background" This.Top_Color_1 " v" This.Button_ID3
		Gui,% This.Window_Name ":Add",Text,% "x" This.X+1 " y" This.Y+This.Text_Offset " w" This.W-2 "  Center BackgroundTrans v" This.Button_ID4,% This.Button_Text
	}
	Button_Press(){
		global
		Press_Active:=1
		GuiControl,% This.Window_Name ":Move",% This.Button_ID4,% "x" This.X+1 " y" This.Y+1+This.Text_Offset
		sleep,-1
		GuiControl,% This.Window_Name ":Hide",This.Button_ID2
		GuiControl,% This.Window_Name ":+Background" This.Top_Color_3,% This.Button_ID3
		GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID1
		GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID3
		GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID4
		While(GetKeyState("LButton"))
			Sleep, 10
		MouseGetPos,,,,ctrl,2
		GuiControlGet,cName,% win ":Name",% ctrl
		cut:=Strlen(cName)
		StringLeft,bName,cName,cut-2
		if(bname=This.Button_Name){
			GuiControl,% This.Window_Name ":Show",This.Button_ID2
			GuiControl,% This.Window_Name ":+Background" This.Top_Color_1,% This.Button_ID3
			GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID1
			GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID2
			GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID3
			GuiControl,% This.Window_Name ":Move",% This.Button_ID4,% "x" This.X " y" This.Y+This.Text_Offset
			GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID4
			%bName%.Button_Hover_On(),Hover_On:=0,Active_Button:=bname,Press_Active:=0
			sleep,10
			return true
		}
		GuiControl,% This.Window_Name ":Show",This.Button_ID2
		GuiControl,% This.Window_Name ":Move",% This.Button_ID4,% "x" This.X " y" This.Y+This.Text_Offset
		GuiControl,% This.Window_Name ":+Background" This.Top_Color_1,% This.Button_ID3
		GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID1
		GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID2
		GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID3
		GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID4
		Hover_On:=0,Press_Active:=0
		sleep,10
		return False
	}
	Button_Hover_On(){
		global
		GuiControl,% This.Window_Name ":+Background" This.Top_Color_2,% This.Button_ID3
		GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID4
	}
	Button_Hover_Off(){
		global
		GuiControl,% This.Window_Name ":+Background" This.Top_Color_1,% This.Button_ID3
		GuiControl,% This.Window_Name ":+Redraw",% This.Button_ID4
	}
}