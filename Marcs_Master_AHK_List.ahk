;====================================================
;		Marc's Work AHK Master File
;====================================================
; Cheat Sheet
; -----------------------------------------------------------------------------
; Hotkeys: ^ = Control; ! = Alt; + = Shift; # = Windows key; * = Wildcard;
;          & = Combo keys; Others include ~, $, UP (see "Hotkeys" in Help)
; -----------------------------------------------------------------------------
; WinActivate [, WinTitle, WinText, ExcludeTitle, ExcludeText]
; IfWinActive [, WinTitle, WinText,  ExcludeTitle, ExcludeText]
; WinGet, OutputVar [, Cmd, WinTitle, WinText, ExcludeTitle, ExcludeText]
; WinMove, X, Y
; WinMove, WinTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]
; 
; SetTitleMatchMode, MatchMode
; SetTitleMatchMode, Fast|Slow
; 	1: A window's title must start with the specified WinTitle to be a match.
;	2: A window's title can contain WinTitle anywhere inside it to be a match.
;	3: A window's title must exactly match WinTitle to be a match.
; 

; Reload Script
!#^r::
Reload
return



; Rearrange all Commonly used Applications
; -----------------------------------------------------------------------------

!#Numpad1::
SetWinDelay, -1		;Set Delay between window actions to non-existant

;Firefox - Minimize, resize, then maximize
WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe vivaldi.exe
WinRestore, ahk_class Chrome_WidgetWin_1 ahk_exe vivaldi.exe
WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe vivaldi.exe
WinMove, A,, 20, 40, 1277, 820
Sleep 100
WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe vivaldi.exe
#IfWinActive, ahk_class Chrome_WidgetWin_1 ahk_exe vivaldi.exe
	Sleep 500
	WinMaximize, ahk_class Chrome_WidgetWin_1 ahk_exe vivaldi.exe
	Sleep 500
#IfWinActive

;File Explorer
WinActivate, File Explorer ahk_class CabinetWClass
#IfWinActive, File Explorer ahk_class CabinetWClass
	WinMove, File Explorer ahk_class CabinetWClass,, -1082, -375, 1080, 960
#IfWinActive 

;Outlook
WinActivate, ahk_class rctrl_renwnd32 ahk_exe OUTLOOK.EXE
#IfWinActive, ahk_class rctrl_renwnd32 ahk_exe OUTLOOK.EXE
	WinMove, ahk_class rctrl_renwnd32 ahk_exe OUTLOOK.EXE,, -1082, -375, 1080, 960
#IfWinActive 

SetTimer, MoveMsgBox, -50
MsgBox, 0, Move Windows, ----==== COMPLETE ====----, .9
Return

MoveMsgBox:
WinWait, Move Windows ahk_class #32770
WinMove, 825, 72
Return



!#Numpad3::
SetWinDelay, -1		;Set Delay between window actions to non-existant
SetTitleMatchMode, 2

;Steam Main Window
WinActivate, Steam ahk_exe Steam.exe
#IfWinActive, Steam ahk_exe Steam.exe
	WinMove, Steam ahk_exe Steam.exe,, -1920, 0, 1038, 872
#IfWinActive 
Sleep 200
;Steam Chat Window
WinActivate,- Chat ahk_exe Steam.exe
#IfWinActive,- Chat ahk_exe Steam.exe
	WinMove,- Chat ahk_exe Steam.exe,, -882, 0, 599, 872
#IfWinActive
Sleep 100 
;Steam Friends Window
WinActivate, Friends ahk_exe Steam.exe
#IfWinActive, Friends ahk_exe Steam.exe
	WinMove, Friends ahk_exe Steam.exe,, -284, 0, 284, 872
#IfWinActive 

;Discord - Minimize, resize, then maximize
WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
WinRestore, ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
WinMove, A,, 1997, 14, 973, 868
Sleep 100
WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
#IfWinActive, ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
	Sleep 500
	WinMaximize, ahk_class Chrome_WidgetWin_1 ahk_exe Discord.exe
	Sleep 500
#IfWinActive

SetTimer, MoveMsgBox, -20
MsgBox, 0, Move Windows, ----==== COMPLETE ====----, .9
Return


Return

;
;  Change Audio Script with Scroll Lock. 
; -----------------------------------------------------------------------------
ScrollLock::
   toggle:=!toggle ;toggles up and down states. 
   Run, mmsys.cpl 
   WinWait,Sound ; Change "Sound" to the name of the window in your local language 
   if toggle
     ControlSend,SysListView321,{Down 1} ; This number selects the matching audio device in the list, change it accordingly 
   Else
     ControlSend,SysListView321,{Down 2} ; This number selects the matching audio device in the list, change it accordingly 
   sleep 40
   ControlClick,&Set Default,Sound,,,,na ; Change "&Set Default" to the name of the button in your local language 
   sleep 40
   ControlClick,OK,Sound,,,,na
return
+ScrollLock::   ;;;; Shift + ScrollLock - Switch Audio Device to one of the 2 monitors
   toggle:=!toggle ;toggles up and down states. 
   Run, mmsys.cpl 
   WinWait,Sound ; Change "Sound" to the name of the window in your local language 
   if toggle
      ControlSend,SysListView321,{Down 3} ; This number selects the matching audio device in the list, change it accordingly 
   Else
      ControlSend,SysListView321,{Down 4} ; This number selects the matching audio device in the list, change it accordingly 
   sleep 40
   ControlClick,&Set Default,Sound,,,,na ; Change "&Set Default" to the name of the button in your local language 
   sleep 40
   ControlClick,OK,Sound,,,,na
return


;Alt + ScrollLock - Switch Audio Device to the Sound System
; -----------------------------------------------------------------------------
!ScrollLock::
   SetWinDelay, -1		;Set Delay between window actions to non-existant
   
   Run, mmsys.cpl 
   WinWait,Sound 							; Change "Sound" to the name of the window in your local language 
   ControlSend,SysListView321,{Down 1} 		; This number selects the matching audio device in the list, change it accordingly 
   ControlClick,&Set Default,Sound,,,,na 	; Change "&Set Default" to the name of the button in your local language 
   ControlClick,OK,Sound,,,,na
return
;Shift + ScrollLock - Switch Audio Device to the HeadSet
+^ScrollLock::  
   Run, mmsys.cpl 
   WinWait,Sound 							; Change "Sound" to the name of the window in your local language 
   ControlSend,SysListView321,{Down 3} 		; This number selects the matching audio device in the list, change it accordingly 
   ControlClick,&Set Default,Sound,,,,na 	; Change "&Set Default" to the name of the button in your local language 
   ControlClick,OK,Sound,,,,na
return


;Arrange Single Windows
; -----------------------------------------------------------------------------
;Fullscreen on main Monitor
!#Numpad8::
WinMove, A,, 0, 0, 1408, 792
WinRestore, A
WinMaximize, A
return

;Small Window on main Monitor
!#Numpad2::
WinMove, A,, 400, 180, 1280, 720
WinRestore, A
return

; Move to Right Monitor
!#Numpad6::
WinMove, A,, 1980, 40, 1280, 720
WinRestore, A
return

; Get Window Name
!#Numpad5::
WinGetClass, class, A
MsgBox, The active window's class is "%class%".

; Hotstrings
; -----------------------------------------------------------------------------
:R*:w@mail::Workemail@work.com
:R*:p@mail::peronsalemail@mine.com
:R*:gbit@mail::GBiTemail@Gmail.com
:R*://shrug::\_(ツ)_/
:R*://tableflip::(）︵ ┻━┻
:R*://flippingtable::(ﾉಥ益ಥ）ﾉ ┻━┻
:R*://placetable::┬─┬ノ( º _ ºノ)
:R*://happy::(ﾟヮﾟ)
:R*://why::щ(ºДºщ)
; Testing
; -----------------------------------------------------------------------------
^!#Numpad1::
WinMove, A,, 0, 0, 1920, 1080
return
^!#Numpad2::
WinMove, A,, 1920, 0, 1920, 1080
return
^!#Numpad3::
WinMove, A,, -1920, 0, 1920, 1080
return
;!#NumpadDot::





;=====================================================================================================
;=====================================================================================================
;=====================================================================================================
;=====================================================================================================
;=====================================================================================================
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;=====================================================================================================
;=====================================================================================================
;=====================================================================================================
;=====================================================================================================
;=====================================================================================================





; ----------------------------------------------------------------------------------------------------
; Testing
; ----------------------------------------------------------------------------------------------------

; -- sleep for 15.6 - 1min = 3846 sleeps at 15.6 per sleep

!#\:: ; 15 Min Break Timer
ProBar = 0
Mins   = 0
Secs   = 0
MilSec = 0.0
SetFormat, float, 002
Progress, B Y950 R0-19230 W1000 %ProBar%, ProBar is equal to %ProBar%, Screen Locked
Sleep 500
loop,
{
	Progress, %ProBar%, %Mins%:%Secs%:%MilSec%, Screen Locked
	if (Probar mod 19230 = 0)
		Mins := Mins + 1
	if ( ProBar = 3600 )
	{
		Progress, Off
		return
	}
	Sleep 15.6
	ProBar := ProBar + 1
	if (mod(ProBar, 64) = 0)
		Secs := Secs + 1

	MilSec := Milsec + 15.6
	MilSec := Round(Mod(MilSec, 1000))

}

return
; ----------------------------------------------------------------------------------------------------
; ----------------------------------------------------------------------------------------------------


; ----------------------------------------------------------------------------------------------------
; ----------------------------------------------------------------------------------------------------

; Get Info For All Monitors
; ----------------------------------------------------------------------------------------------------
!#-::
SysGet, NumMonitors, MonitorCount
SysGet, TotWidth, 78
SysGet, TotHeight, 79

Gui, New, Border, Marc's Monitor Info Script
Gui -MaximizeBox -MinimizeBox +SysMenu +Border
Gui, Font, s20 w500
Gui, Add, Text, x5 y5, Monitor Info

Gui, Font, s14 w400
Gui, Add, Text, x5 y+0, Total Screen Realestate: 
Gui, Add, Text, x5 y+0 +Border,x: %TotWidth% `ty: %TotHeight% 
Gui, Add, Text, x5 y+0
Gui, Show

loop, % NumMonitors
{

	SysGet, Mon, Monitor, %a_index%

	WinX := MonRight - MonLeft
	WinY := MonBottom - MonTop

	if(a_index != 1)
	{
		if (Mod(a_index+1, 2) = 0)
			Gui, Add, Text,y109 x133*%a_index%, Monitor %a_index%:
		else
			Gui, Add, Text,y+5, Monitor %a_index%:
	}
	else
		Gui, Add, Text,y+0, Monitor %a_index%:
	Gui, Add, Text,y+0 +Border, x:`t%WinX%`ny:`t%WinY%

	Gui, Submit

}
;Gui, Add, Button, Default, X
Gui, Show, AutoSize Center

;MsgBox, 8192,Monitor Info, # Monitors:`t%NumMonitors%`nTotal Width:`t%TotWidth%`nTotal Height:`t%TotHeight%`n`nResolution:`tx: %TotWidth%`ty: %TotHeight%

return
; ----------------------------------------------------------------------------------------------------
; ----------------------------------------------------------------------------------------------------
