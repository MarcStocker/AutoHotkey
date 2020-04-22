;=====================================================================================
;=====================================================================================
;=======	 __  __                   _       __  __              _              	=======
;=======	|  \/  |                 ( )     |  \/  |            | |             	=======
;=======	| \  / |  __ _  _ __  ___|/ ___  | \  / |  __ _  ___ | |_  ___  _ __ 	=======
;=======	| |\/| | / _` || '__|/ __| / __| | |\/| | / _` |/ __|| __|/ _ \| '__|	=======
;=======	| |  | || (_| || |  | (__  \__ \ | |  | || (_| |\__ \| |_|  __/| |   	=======
;=======	|_|  |_| \__,_||_|   \___| |___/ |_|  |_| \__,_||___/ \__|\___||_|   	=======
;=======	                   _    _  _  __  _       _       _                  	=======
;=======	            /\    | |  | || |/ / | |     (_)     | |                 	=======
;=======	           /  \   | |__| || ' /  | |      _  ___ | |_                	=======
;=======	          / /\ \  |  __  ||  <   | |     | |/ __|| __|               	=======
;=======	         / ____ \ | |  | || . \  | |____ | |\__ \| |_                	=======
;=======	        /_/    \_\|_|  |_||_|\_\ |______||_||___/ \__|               	=======
;=====================================================================================
;=====================================================================================
;==	Quick Cheat Sheet 																=======
;==	-----------------------------------------------------------------------------	=======
;==	Hotkeys: ^ = Control; ! = Alt; + = Shift; # = Windows key; * = Wildcard;		=======
;==	         & = Combo keys; Others include ~, $, UP (see "Hotkeys" in Help)		=======
;==	-----------------------------------------------------------------------------	=======
;==	SetTitleMatchMode, Fast|Slow 													=======
;==		1: A window's title must start with the specified WinTitle to be a match.	=======
;==		2: A window's title can contain WinTitle anywhere inside it to be a match.	=======
;==		3: A window's title must exactly match WinTitle to be a match.				=======
;==========================================================================================
;==========================================================================================

;------------------------------------------------------------------------------------------
; Starting Script SplashImage (Displays AHK 3 key logo with "Starting Master Script" on the keys)
; This assumes all monitors are 1920x1080
;------------------------------------------------------------------------------------------
SplashImage, 8:C:\Dropbox\AHK Scripts\SplashImages\ahk keyboard logo.png, b Hide y0
SplashImage, 9:C:\Dropbox\AHK Scripts\SplashImages\ahk keyboard logo.png, b Hide y0 x2758
SplashImage, 10:C:\Dropbox\AHK Scripts\SplashImages\ahk keyboard logo.png, b Hide y0 x-1082
SplashImage, 8:Show
WinSet, TransColor, FFFFFF 150, %A_ScriptName%
SplashImage, 9:Show
WinSet, TransColor, FFFFFF 150, %A_ScriptName%
SplashImage, 10:Show
WinSet, TransColor, FFFFFF 150, %A_ScriptName%
WinSet, AlwaysOnTop, On, %A_ScriptName%
WinSet, ExStyle, +0x20, %A_ScriptName%
SetTimer, ScriptStartingGui, -800
SetTimer, DesktopIsOnline, 30000, -9999


;------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------

; ==============================================================================
;	Release Keys in case perminantely pressed 
; ==============================================================================

; Reset some common things that might get messed up when starting/restarting the script in the middle of an action
BlockInput, Off					; Release blocked input, just in case a script was stopped halfway through
WinShow ahk_class Shell_TrayWnd ; Show Task Bar 
WinShow Start ahk_class Button	; Show Start Menu Button
Send {Shift Up}
Send {Ctrl Up}
Send {Alt Up}
Send {LWin Up}
Send {RWin Up}
Send {Esc Up}

;==========================================================================================
; Set Script #Directives and Defaults
;==========================================================================================
	#Persistent
	#SingleInstance Force
	#NoEnv  		; Recommended for performance and compatibility with future AutoHotkey releases.
	SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
	BlockInput, Off ; In case there was an issue and the mouse is locked out

;==========================================================================================
; Load/Save Images such as the Tray Button Icon and SplashScreens
;==========================================================================================
	Global tempFolder
	tempFolder = C:\Users\%A_UserName%\AppData\Local\AHK\.temp
	IfNotExist, tempFolder
		FileCreateDir, C:\Users\%A_UserName%\AppData\Local\AHK\.temp
	IfNotExist, AHK Cust Icon 2.ico
	{
		FileInstall, C:\Dropbox\AHK Scripts\~Icons\AHK Cust Icon 2.ico, %tempFolder%\AHK Cust Icon 2.ico
		Menu, Tray, Icon, %tempFolder%\AHK Cust Icon 2.ico
	}
	Menu, Tray, Tip, Marc's_Master_AHK_List
;==========================================================================================

;===================================================================================================
;==    _  _   _____               _             _          _____              _         _         ==
;==  _| || |_|_   _|             | |           | |        / ____|            (_)       | |        ==
;== |_  __  _| | |   _ __    ___ | | _   _   __| |  ___  | (___    ___  _ __  _  _ __  | |_  ___  ==
;==  _| || |_  | |  | '_ \  / __|| || | | | / _` | / _ \  \___ \  / __|| '__|| || '_ \ | __|/ __| ==
;== |_  __  _|_| |_ | | | || (__ | || |_| || (_| ||  __/  ____) || (__ | |   | || |_) || |_ \__ \ ==
;==   |_||_| |_____||_| |_| \___||_| \__,_| \__,_| \___| |_____/  \___||_|   |_|| .__/  \__||___/ ==
;==                                                                             | |               ==
;==                                                                             |_|               ==
;===================================================================================================

;===================================================================================================
; Timers. "Always Running" Scripts. (Must come before any script with a "return" in it)
;===================================================================================================
	#include C:\Dropbox\AHK Scripts\IFTTTComputerCommands.ahk
;===================================================================================================
; Window Setup and Moving Hotkeys
;===================================================================================================
	#include C:\Dropbox\AHK Scripts\~~Master Scripts Collection\Pushbullet Setup.ahk
	#include C:\Dropbox\AHK Scripts\~~Master Scripts Collection\Hotstrings.ahk
	#include C:\Dropbox\AHK Scripts\~~Master Scripts Collection\Arrange Specific Setups.ahk
	#include C:\Dropbox\AHK Scripts\App Killer Scripts\Game mode Kill Unnecessary apps.ahk
	#include C:\Dropbox\AHK Scripts\~~Master Scripts Collection\Move_Windows_General.ahk
;	#include C:\Dropbox\AHK Scripts\Window Moving-Setup.ahk
;===================================================================================================
; Gaming Scripts
;===================================================================================================
;	#include C:\Dropbox\AHK Scripts\Gaming Scripts\RL Audio Toggle Adjustment.ahk
;===================================================================================================
; Audio Manipulation
;===================================================================================================
	;#include C:\Dropbox\AHK Scripts\~~Master Scripts Collection\Change Audio Devices.ahk
;===================================================================================================
; Functions
;===================================================================================================
	#include C:\Dropbox\AHK Scripts\Functions\CustomProgramVolume.ahk
	#include C:\Dropbox\AHK Scripts\Functions\Change Audio Devices.ahk
	#include C:\Dropbox\AHK Scripts\Functions\ProjectMonitor.ahk
	#include C:\Dropbox\AHK Scripts\Functions\Save all Open Window Locations.ahk
	#include C:\Dropbox\AHK Scripts\Functions\LeClick.ahk
	#include C:\Dropbox\AHK Scripts\Functions\ProgressBarTheme.ahk
;=================================================================================================== - End Include Scripts Section

;===============================================================================
; Global Variables/Settings
;===============================================================================
	
	#Persistent					; Keeps a script permanently running (that is, until the user closes it or ExitApp is encountered).
	#NoEnv  					; Recommended for performance and compatibility with future AutoHotkey releases.
	SetWinDelay, -1				; Set Delay between window actions to non-existant
	SendMode Input  			; Recommended for new scripts due to its superior speed and reliability.
	CoordMode, Mouse, Screen 	; Sets all mouse commands to be relative to the Desktop (Entire Screen)
	SetTitleMatchMode, 2		; A window's title can contain WinTitle anywhere inside it to be a match. 
	;SetTitleMatchMode, 1		; A window's title must start with the specified WinTitle to be a match.
	;SetTitleMatchMode, 3		; A window's title must exactly match WinTitle to be a match.
	;#Warn	 					; Enable warnings to assist with detecting common errors.

;===============================================================================
;===============================================================================
;===============================================================================
; Reset Keys/Values in case a script was stopped halfway through
;===============================================================================
BlockInput, Off
Send {Shift Up}
Send {Ctrl Up}
Send {Alt Up}
Send {RWin Up}
Send {LWin Up}


;======================================================================================================================
;======================================================================================================================
;==  _    _   ____  _______  _  __ ______ __     __ _____  ==  _    _   ____  _______  _  __ ______ __     __ _____  ==
;== | |  | | / __ \|__   __|| |/ /|  ____|\ \   / // ____| == | |  | | / __ \|__   __|| |/ /|  ____|\ \   / // ____| ==
;== | |__| || |  | |  | |   | ' / | |__    \ \_/ /| (___   == | |__| || |  | |  | |   | ' / | |__    \ \_/ /| (___   ==
;== |  __  || |  | |  | |   |  <  |  __|    \   /  \___ \  == |  __  || |  | |  | |   |  <  |  __|    \   /  \___ \  ==
;== | |  | || |__| |  | |   | . \ | |____    | |   ____) | == | |  | || |__| |  | |   | . \ | |____    | |   ____) | ==
;== |_|  |_| \____/   |_|   |_|\_\|______|   |_|  |_____/  == |_|  |_| \____/   |_|   |_|\_\|______|   |_|  |_____/  ==
;======================================================================================================================
;======================================================================================================================
                                                       
                                                       

;===============================================================================
; Reload Script
;===============================================================================
!#^r::
	Reload
return
;===============================================================================
;
;!#^LButton::
;	togglemouseclicker:=!togglemouseclicker
;	if togglemouseclicker
;	{
;		Sleep 3000
;		SetTimer, autoclicker, 50
;	}
;	else
;		SetTimer, autoclicker, Off
;Return
;
;autoclicker:
;	MouseClick, Left,,,20,0
;	Sleep 10
;Return

;=================================================================================
;=================================================================================
;==   _  __            __  __                   _                               ==
;==  | |/ /           |  \/  |                 (_)                              ==
;==  | ' / ___ _   _  | \  / | __ _ _ __  _ __  _ _ __   __ _ ___               ==
;==  |  < / _ \ | | | | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|              ==
;==  | . \  __/ |_| | | |  | | (_| | |_) | |_) | | | | | (_| \__ \              ==
;==  |_|\_\___|\__, | |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/              ==
;==             __/ |              | |   | |             __/ |                  ==
;==            |___/               |_|   |_|            |___/                   ==
;=================================================================================
;=================================================================================

;=================================================================================
; Remapped - Switch Between Virtual Desktops
;=================================================================================

^#j::   ; Switch to the Right
	loop 5
		Send #^{Left}
return
^#l::   ; Switch to the Right
	Send #^{Right}
return
^#k::   ; Switch to the Left
	Send #^{Left}
return
^#;::   ; Switch to the Right
	loop 5
		Send #^{Right}
return

;=================================================================================
;=================================================================================
;==   _____  _                                                      _  _        ==
;==  / ____|| |                                    /\              | |(_)       ==
;== | |     | |__    __ _  _ __    __ _   ___     /  \   _   _   __| | _   ___  ==
;== | |     | '_ \  / _` || '_ \  / _` | / _ \   / /\ \ | | | | / _` || | / _ \ ==
;== | |____ | | | || (_| || | | || (_| ||  __/  / ____ \| |_| || (_| || || (_) |==
;==  \_____||_| |_| \__,_||_| |_| \__, | \___| /_/    \_\\__,_| \__,_||_| \___/ ==
;==                  _____         __/ |  _                                     ==
;==                 |  __ \       |___/  (_)                                    ==
;==                 | |  | |  ___ __   __ _   ___  ___  ___                     ==
;==                 | |  | | / _ \\ \ / /| | / __|/ _ \/ __|                    ==
;==                 | |__| ||  __/ \ V / | || (__|  __/\__ \                    ==
;==                 |_____/  \___|  \_/  |_| \___|\___||___/                    ==
;=================================================================================
;=================================================================================
; -----------------------------------------------------------------------------
;  Change Audio Script with Scroll Lock - No Pop up windows - Uses nircmd 
;  	Nircmd webpage: https://www.nirsoft.net/utils/nircmd.html
;  	Direct Download: https://www.nirsoft.net/utils/nircmd-x64.zip
; -----------------------------------------------------------------------------
; 'AudDev' and 'MicDev' must be the actual names of the "Playback" and "Recording" 
; devices found in the Sound selection window
;=================================================================================
; Toggle between mulitple primary Audio Devices and Microphones
;	- G933 Headset
;	- Onkyo Sound System
;	- G930 Headset
;	- VoiceMeter Banana
;=================================================================================
ScrollLock:: ;ScrollLock default hotkey
^!#+t::      ;Hotkey to emulate Printscreen for the TV Remote
^!9::		 ;Hotkey for Harmony Remote
	KeyWait, ScrollLock, T0.40
	If ErrorLevel
	{
		ToolTip, Opening Sound Menu
		Run, mmsys.cpl
		Sleep 750
		ToolTip
		Return
	}

	audionum:=mod(audionum++, DevArray.len)
	
	If (audiotoggle == null)
		audiotoggle:=0
	audiotoggle:=mod(audiotoggle, DevArray.Length())
	audiotoggle++

	; --- Primary Audio Device, this device will always be selected first when the script starts/re-starts ---
	DevArray := [{	 Speaker 	 : "G533 Headset"
					,Microphone  : "G533 Mic"
					,SplashImage : "C:\Dropbox\AHK Scripts\SplashImages\Audio Selected G533.png" }]
	;---------------------------------------------------------------------------------------------------------------
	;------------------------------------ Add additional devices below, as such... --------------------------------- 
	;---------------------------------------------------------------------------------------------------------------
	;---------------------------------------------------------------------------------------------------------------
	DevArray.push({	 Speaker 	 : "Vizio Sound Bar"
					,Microphone  : "WebCam Mic"
					,SplashImage : "C:\Dropbox\AHK Scripts\SplashImages\Vizio.png" })
	;---------------------------------------------------------------------------------------------------------------
;;	DevArray.push({	 Speaker 	 : "VoiceMeeter Input"
;;					,Microphone  : "VoiceMeeter Output"
;;					,SplashImage : "C:\Dropbox\AHK Scripts\SplashImages\SplashImages\Audio Selected VoiceMeeter Output.png" })
;;	;---------------------------------------------------------------------------------------------------------------
;;	DevArray.push({	 Speaker 	 : "Onkyo Sound System"
;;					,Microphone  : "WebCam Mic"
;;					,SplashImage : "C:\Dropbox\AHK Scripts\SplashImages\SplashImages\Audio Selected Stereo transparent 3d.png" })
	;---------------------------------------------------------------------------------------------------------------
	DevArray.push({	 Speaker 	 : "Index HMD"
					,Microphone  : "Valve Index Mic"
					,SplashImage : "C:\Dropbox\AHK Scripts\SplashImages\SplashImages\Valve Index VR Headset.png" })
	;---------------------------------------------------------------------------------------------------------------
;;	DevArray.push({	 Speaker 	 : "G930 Headset"
;;					,Microphone  : "G930 Mic"
;;					,SplashImage : "C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Headset 3d.png" })
	;---------------------------------------------------------------------------------------------------------------
	;---------------------------------------------------------------------------------------------------------------
	aDevice 	:= DevArray[audiotoggle]
	theSpeaker  := aDevice["Speaker"]
	theMic 		:= aDevice["Microphone"]
	theImage	:= aDevice["SplashImage"]
	;---------------------------------------------------------------------------------------------------------------
	;---------------------------------------------------------------------------------------------------------------

	SetDefaultAudioDevice(theSpeaker, theMic, theImage)	;Set Audio and Mic Devices (And spawn a SplashImage)




Return
;---------------------------------------------------------------------------------

;=================================================================================
; Change Directly to the Monitor Speakers
;=================================================================================
+ScrollLock::   ;;;; Shift + ScrollLock - Switch Audio Device to one of the 2 monitors

	;theSpeaker=Asus Monitor
	;theMic=WebCam Mic
	;theImage=C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Asus Monitor.png

	;---------------------------------------------------------------------------------------------------------------
	shiftaudionum:=mod(shiftaudionum++, shiftDevArray.len)
	;---------------------------------------------------------------------------------------------------------------
	If (shiftaudiotoggle == null)
		shiftaudiotoggle:=0
	shiftaudiotoggle:=mod(shiftaudiotoggle, shiftDevArray.Length())
	shiftaudiotoggle++
	;---------------------------------------------------------------------------------------------------------------
	; --- Primary Audio Device, this device will always be selected first when the script starts/re-starts ---
	shiftDevArray := [{	 Speaker 	 : "Asus Monitor"
					,Microphone  : "WebCam Mic"
					,SplashImage : "C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Asus Monitor.png" }]
	;---------------------------------------------------------------------------------------------------------------
	;------------------------------------ Add additional devices below, as such... --------------------------------- 
	;---------------------------------------------------------------------------------------------------------------
	shiftDevArray.push({	Speaker 	 : "G933 Headset"
					,Microphone  : "G933 Mic"
					,SplashImage : "C:\Dropbox\AHK Scripts\SplashImages\Audio Selected G933.png" })
	;---------------------------------------------------------------------------------------------------------------
	shiftDevArray.push({	Speaker 	 : "G930 Headset"
					,Microphone  : "G930 Mic"
					,SplashImage : "C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Headset 3d.png" })
	;---------------------------------------------------------------------------------------------------------------
	;---------------------------------------------------------------------------------------------------------------
	aDevice 	:= shiftDevArray[shiftaudiotoggle]
	theSpeaker  := aDevice["Speaker"]
	theMic 		:= aDevice["Microphone"]
	theImage	:= aDevice["SplashImage"]
	;---------------------------------------------------------------------------------------------------------------
	;---------------------------------------------------------------------------------------------------------------
	SetDefaultAudioDevice(theSpeaker, theMic, theImage)	;Set Audio and Mic Devices (And spawn a SplashImage)
	
return
;---------------------------------------------------------------------------------

;=================================================================================
; OLD VERSION - Toggle Audio by navigating the Sound selection window
;=================================================================================
; Old Version
;+ScrollLock::   ;;;; Shift + ScrollLock - Switch Audio Device to one of the 2 monitors
;	toggle:=!toggle ;toggles up and down states. 
;	Run, mmsys.cpl 
;	WinWait,Sound ; Change "Sound" to the name of the window in your local language 
;	if toggle
;		ControlSend,SysListView321,{Down 3} ; This number selects the matching audio device in the list, change it accordingly 
;	Else
;		ControlSend,SysListView321,{Down 4} ; This number selects the matching audio device in the list, change it accordingly 
;	sleep 40
;	ControlClick,&Set Default,Sound,,,,na ; Change "&Set Default" to the name of the button in your local language 
;	sleep 40
;	ControlClick,OK,Sound,,,,na
;return
;---------------------------------------------------------------------------------
;================================================================================= - End Change Audio Hotkeys

^!6::		 ;Hotkey for Harmony Remote
	SendEvent !^{Tab}
return
;=================================================================================
; Edit Program Volume Levels
;=================================================================================
; Adjust Minimum Volume Level using Ctrl+MouseWheel Up/Down
;====================================================
;Volume Up
#!^WheelUp:: 
	ChangeCurProgramVolume("Up")
return 
;Volume Down
#!^WheelDown:: 
	ChangeCurProgramVolume("Down")
return 
;Volume Max
#!^WheelRight::	;SrollWheelRight
	SetCurProgramMaxVolume()
Return
; Custom Set Volume
#!^WheelLeft::	;SrollWheelLeft
	SetCurProgramLastCustomVolume()
Return
; Custom Set Volume
#!^MButton::	;SrollWheelLeft 
	SetCurProgramVolumeMute()

;	sleep, 750
;	loop, 15
;	{
;		If !GetKeyState("MButton" & #!^, p)
;		{
;			msgbox, Not holding it
;			break
;		}
;		Sleep 100
;	}
;	If GetKeyState("MButton" & #!^, p)
;	{
;		SaveCurProgramCustomVolumeLevel()
;		Msgbox, SAVING IT
;	}
;	Else
;		SetCurProgramVolumeMute()
Return

;CustProgramVolumes:= Array
;
;
;; Set Volume to Custom, or Max
;;====================================================
;WheelLeft::		;ScrollWheelRight 		
;	Progress, by75 p%CustGameVol%, Volume Set to: %CustGameVol%`%
;	run nircmd.exe setappvolume focused %CustGameVol%
;	SetTimer, ChangeAudioLevelTimer, -1600
;return
;
;WheelRight::	;ScrollWheelRight 			
;	Progress, by75 p100,  Volume Set to: 100`%
;	run nircmd.exe setappvolume focused 1
;	SetTimer, ChangeAudioLevelTimer, -1600
;return




;=================================================================================
; Dim Screen - For use with Flux. 
; 	Raise brightness all the way, then decrease to just before red.
;=================================================================================
>!>^>+d::
^!8:: 		;Hotkey for Harmony Remote
	ThisText=Dimming the Screen
	TrayTip, AHK - F.lux (Dimming), %ThisText%,, 1
	HideTrayTip()
	Send {Alt Down}
	loop, 20
	{
		SendInput {PgDn}
		Sleep 50
	}
	Send {Alt Up}
return

>!>#>^>+d::
^!7::
	ThisText=Brighting up Screen
	TrayTip, AHK - F.lux (Brighting), %ThisText%,, 1
	HideTrayTip()
	Send {Alt Down}
	Loop, 20 
	{
		SendInput {PgUp}
		Sleep 150
	}
	Send {Alt Up}
return

HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}
;---------------------------------------------------------------------------------

;=================================================================================
; Toggle Between rainmeter Layouts
;=================================================================================
#!r::
	if RainmeterSelector = 
		RainmeterSelector = -1
	RainMeterSelector := Mod((RainMeterSelector+1), 3)
	if RainMeterSelector = 0
	{
		msgbox, 0, Toggle Rainmeter Layouts,No Audio Visualizers, .8
		Run, C:\Program Files\Rainmeter\Rainmeter.exe !LoadLayout "Win 10 Tri Screen all 1080 - Gaming noVA"
	}
	else if RainMeterSelector = 1
	{
		Run, C:\Program Files\Rainmeter\Rainmeter.exe !LoadLayout "Win 10 Tri Screen all 1080 - Gaming"
		msgbox, 0, Toggle Rainmeter Layouts,Taskbar Audio Visualizers, .8
	}
	else if RainMeterSelector = 2
	
	{
		Run, C:\Program Files\Rainmeter\Rainmeter.exe !LoadLayout "Win 10 Tri Screen all 1080 - VATree"
		msgbox, 0, Toggle Rainmeter Layouts,Desktop Audio Visualizers, .8
	}
	else
		return
Return
;---------------------------------------------------------------------------------


;=====================================================================================================
; Watch Media - Run Kodi
;=====================================================================================================
+!m::
	Send, {#}{right 2}
	IfWinNotActive
	{
		;run, kodi
	}
	Send, {LWin Down}{Tab}{L#Win Up}
	Progress, 10, Hi
	loop
	{
		ImageSearch, OutputVarX, OutputVarY, X1, Y1, X2, Y2, C:\Users\Marc\Pictures\AHK Kodi Symble.png
		if ErrorLevel = 2
		{
			MsgBox, 0, File not found
		}
		else if Errorlevel = 1
		{
			;#MsgBox, 0, Img not found yet...
		}
		else
		{
			MsgBox, 0, We found it!
			break
		}
	} 
	Progress, Off
return
;-----------------------------------------------------------------------------------------------------

;=====================================================================================================
; Listen to Spotify Only
;=====================================================================================================
!#^m::
	spotifytoggle:=!spotifytoggle
	if spotifytoggle
	{
		Send, #d
		IfWinNotExist, ahk_exe Spotify.exe
		{
			Run, C:\Users\Marc\AppData\Roaming\Spotify\Spotify.exe
			WinWait, ahk_exe Spotify.exe,, 7
			WinActivate, ahk_exe Spotify.exe
			Send {Space}
		}
		Sleep 3000
		WinActivate, ahk_exe Spotify.exe
		WinMove, ahk_exe Spotify.exe,, 400, 180, 1408, 792
		WinRestore, ahk_exe Spotify.exe
		WinMaximize, ahk_exe Spotify.exe
		WinSet, Transparent, 185, ahk_exe Spotify.exe
	}
	else
	{
		WinActivate, ahk_exe Spotify.exe
		WinSet, Transparent, Off, ahk_exe Spotify.exe
		WinMove, ahk_exe Spotify,, 200, 400, 
	}
return
;-----------------------------------------------------------------------------------------------------

;=====================================================================================================
; Get Window Name - My personal 'WindowSpy'. For fun and extra info.
;=====================================================================================================
#Numpad5::
	Gui, Destroy

	WinGetTitle, title, A
	WinGetClass, class, A
	WinGet, process, ProcessName, A
	;--------------
	; Create Gui
	;--------------
	Gui, New, AlwaysOnTop, Marcs WindowSpy

	Gui, Add, Text, Section, Window Title, Class and Process:
	Gui, Add, Edit, ReadOnly section -Wrap w350 r3 vmyTitleClassProcess
	TitleClassProcess=%title%`nahk_class %class%`nahk_exe %process%
	GuiControl,, myTitleClassProcess, %TitleClassProcess%

	WinGet, ID, ID, A
	WinGet, PID, PID, A
	Gui, Add, Text, Section, Window ID and PID:
	Gui, Add, Edit, ReadOnly section -Wrap w350 r2 vmyIdPid
	IdPid=%ID%`n%PID%
	GuiControl,, myIdPid, %IdPid%

	Gui, Show

	;Loop
	;{
	;	WinGetTitle, title, A
	;	WinGetClass, class, A
	;	WinGet, process, ProcessName,A
	;	
	;	GuiControl,, WindowTitle, 
	;	GuiControl,, WindowClass, 
	;	GuiControl,, WindowProcess, 
	;}

	;MsgBox, The active window's class is "%class%".
return
;-----------------------------------------------------------------------------------------------------

;=====================================================================================================
; Move Pushbullet
;=====================================================================================================

AdjustPushbullet(xRow, yColumn, xAdd, yAdd, HorVert:="Vertical", ReverseDirection:="TRUE", NewRowColAfterNumBubbles:=0, DistBetweenNewRowCol:=70)

!#^Right::
	AdjustPushbullet(0, 0, 70, 0, "h", "FALSE", "FALSE", 6, 75)
	;AdjustPushbullet(800, 20, 70, 0, "h", "FALSE", "FALSE", 3, 75)
Return
!#^Left::
	AdjustPushbullet(-800, 883, 70, 0, "h", "FALSE", "FALSE", 5, 70)
Return
!#^Up::
	AdjustPushbullet(1833, 950, 0, 70, "v", "TRUE", "TRUE", 3, 75)
Return
!#^Down::
	AdjustPushbullet(1833, 0, 0, 80, "v", "FALSE", "TRUE", 8, 80)
Return

#!^NumPadDot::
	AdjustPushbullet(-772, 500, 0, 70, "V")
return
#!^NumPad0::
	AdjustPushbullet(-772, 500, 70, 0, "H")
return

;x: -772	y: 881	w: 340	h: 540
;Client:			w: 340	h: 540
;-----------------------------------------------------------------------------------------------------


;=====================================================================================================
; Save and Restore Window Locations
;=====================================================================================================
;Save all window locations
!#^[::
	SaveAllWindowLocations()
Return 

;Restore all window locations
!#^]::
	RestoreAllWindowLocations()
Return

;Selection Menu for Saving/Restoring Windows
!#^\::
	Msgbox, 2, Click one of the buttons
	IfMsgBox, Abort
		return
	IfMsgBox, Retry
	{
		InputBox, userValue, Load a Layout, Name of layout to load:,,,,,,, 20, Default
		Msgbox % userValue
		RestoreAllWindowLocations(userValue)
	}
	IfMsgBox, Ignore
	{
		InputBox, userValue, Save Layout, Save layout as:,,,,,,, 20, Default
		Msgbox % userValue
		SaveAllWindowLocations(userValue)
	}
		
		
Return
;----------------------------------------------

; Gaming
;=====================================================================================================
!#^g:: 
	IfWinActive, PLAYERUNKNOWN'S BATTLEGROUNDS 
	{
		IfWinNotExist, PUBG nircmd Audio Toggle.ahk
			GameExe="C:\Dropbox\AHK Scripts\Gaming Scripts\PUBG simple nircmd audio toggle.ahk"
			run, %GameExe%
	}

	IfWinActive, RocketLeague.exe
	{
		GameExe="C:\Dropbox\AHK Scripts\Gaming Scripts\Rocket League Hotkeys.exe"
		run, %GameExe%
	}
return

; Rocket League
;==============================================================
; 2 Player Full screen - Side by side. 
;#IfWinActive, Rocket League ahk_exe RocketLeague.exe
;	WheelRight::	;ScrollWheelRight
;		rlrmtoggle:=!rlrmtoggle 
;		if rlrmtoggle
;			WinMove, A,, 0, 0, 3840, 1080
;		else
;			WinMove, A,, 0, 0, 1920, 1080
;	return
;
;	WheelLeft::	;ScrollWheelRight
;		rllmtoggle:=!rllmtoggle 
;		if rllmtoggle
;		{
;			WinMove, A,, -1920, 0, 3840, 1080
;			sleep 500
;			WinMove, A,, -1920,,,
;		}
;		else
;			WinMove, A,, 0, 0, 1920, 1080
;	return
;
;	!#^Numpad6::
;
;#If
;return

;===================================================================================================== - End Hotkeys
;===================================================================================================== - End Hotkeys
;===================================================================================================== - End Hotkeys



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
; Testing	(Mostly garbage)
; ----------------------------------------------------------------------------------------------------

^#NumPad0::
>^>#m:: 
	;run nircmd.exe monitor async_off
	InputBox, numoftimesenterispressed, Hit enter how many time?

	loop % numoftimesenterispressed
	{
		Send {Enter}{Enter}
	}
return

;^Up::
;	;Gui, Add, Text, hi
;	;Gui, Show
;
;		ProjectMonitor(4)
;
;Return




;^!#Numpad1::
;	WinMove, A,, 0, 0, 1920, 1080
;return
;^!#Numpad2::
;	WinMove, A,, 1920, 0, 1920, 1080
;return
;^!#Numpad3::
;	WinMove, A,, -1920, 0, 1920, 1080
;return
;;!#NumpadDot::
;Return




; -- sleep for 15.6 - 1min = 3846 sleeps at 15.6 per sleep

;!#\:: ; 15 Min Break Timer
;ProBar = 0
;Mins   = 0
;Secs   = 0
;MilSec = 0.0
;SetFormat, float, 002
;Progress, B Y950 R0-19230 W1000 %ProBar%, ProBar is equal to %ProBar%, Screen Locked
;Sleep 500
;loop,
;{
;	Progress, %ProBar%, %Mins%:%Secs%:%MilSec%, Screen Locked
;	if (Probar mod 19230 = 0)
;		Mins := Mins + 1
;	if ( ProBar = 3600 )
;	{
;		Progress, Off
;		return
;	}
;	Sleep 15.6
;	ProBar := ProBar + 1
;	if (mod(ProBar, 64) = 0)
;		Secs := Secs + 1
;
;	MilSec := Milsec + 15.6
;	MilSec := Round(Mod(MilSec, 1000))
;
;}
;
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

;!#=::
;
;	Gui, New,, Audio Splash Gui
;	Gui, -MaximizeBox -MinimizeBox -SysMenu -Border
;	Gui, Margin, 0, 0
;	Gui, Color, 000000
;
;
;
;	WinSet, TransColor, 000000 150, Audio Splash Gui
;
;	Gui, Add, Picture,, C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Stereo transparent 3d.png
;	Gui, Show	
;	WinSet, Style, -0xC00000, Audio Splash Gui
;	WinSet, TransColor, 000000 150, Audio Splash Gui
;	WinSet, AlwaysOnTop, On, Audio Splash Gui
;	WinSet, ExStyle, +0x20, Audio Splash Gui
;	Sleep 1800
;	Gui, Destroy
;
;
;return
;



;===================================================================================================
; Timers
;===================================================================================================
DesktopIsOnline:
{
	Run, %comspec% /c curl -X POST https://hc-ping.com/7adba7b3-07d0-4898-b63d-6eb63b869cee,,hide ; --------- DESKTOP IS ONLINE
}

ScriptStartingGui:
{
	Sleep 1500
	SplashImage, 8:Off
	SplashImage, 9:Off
	SplashImage, 10:Off
}

