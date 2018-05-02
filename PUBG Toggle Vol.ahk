;=====================================================================================================
; PUBG - Lower in Game Volume
;=====================================================================================================
	
	global CustGameVol := .20
	SetTimer, PUBGstartingSplash, -250

;=====================================================================================================
;		README		README		README		README		README		README		README		README
;=====================================================================================================

	; PUBG must be focused. Otherwise it will not control the volume. 
	; How to use:
	; 	Use any Modifier key + ScrollWheel to change Volume
	;	 - Ctrl+ScrollUp = Raise Custom Volume
	;	 - Alt+ScrollDwn = Lower Custom Volume
	;    - MouseWheelLeft = Set Vol to Custom Volume
	;    - MouseWheelRght = Set Vol to Max
	;	MouseWheel Left/Right (Also works with most Shift, Alt, Ctrl Combos)

;=====================================================================================================
;=====================================================================================================

#IfWinActive, PLAYERUNKNOWN'S BATTLEGROUNDS 

	; Adjust Minimum Volume Level using Ctrl+MouseWheel Up/Down
	;====================================================
	;Volume Up
	^WheelUp:: 
	+WheelUp:: 
	!WheelUp:: 
	+^WheelUp:: 
	+!WheelUp:: 
		VolWasChanged = True
		if (CustGameVol < .10)
			CustGameVol := CustGameVol + .01
		else
			CustGameVol := CustGameVol + .05
		if CustGameVol > 1.00
			CustGameVol := 1.00
		run nircmd.exe setappvolume focused %CustGameVol%
		CustGameVolDisplay := Round((CustGameVol * 100), 0)
		Progress, by75 n%CustGameVolDisplay% p%CustGameVolDisplay%, Lower Volume Set to: %CustGameVolDisplay%`%, Volume: %CustGameVolDisplay%`%
		SetTimer, PUBGVolTimer, -1000
		WinSet, TransColor, 000000 110, %A_ScriptName%
	return 
	;Volume Down
	^WheelDown:: 
	!WheelDown:: 
	+WheelDown:: 
	+^WheelDown:: 
	!+WheelDown:: 
		if (CustGameVol < .10)
			CustGameVol := CustGameVol - .01
		else
			CustGameVol := CustGameVol - .05
		VolWasChanged = True
		if (CustGameVol < 0)
			CustGameVol = .01
		run nircmd.exe setappvolume focused %CustGameVol%
		CustGameVolDisplay := Round((CustGameVol * 100), 0)
		Progress, by75 n%CustGameVolDisplay% p%CustGameVolDisplay%, Lower Volume Set to: %CustGameVolDisplay%`%, Volume: %CustGameVolDisplay%`%
		SetTimer, PUBGVolTimer, -1000
		WinSet, TransColor, 000000 110, %A_ScriptName%
	return 


	; Set Volume to Custom, or Max
	;====================================================
	WheelLeft::		;ScrollWheelRight 		
		CustGameVolDisplay := Round((CustGameVol * 100), 0)
		Progress, by75 p%CustGameVolDisplay%, Volume Set to: %CustGameVolDisplay%`%, Volume: %CustGameVolDisplay%`%
		WinSet, TransColor, 000000 110, %A_ScriptName%
		run nircmd.exe setappvolume focused %CustGameVol%
		SetTimer, PUBGVolTimer, -1600
	return

	WheelRight::	;ScrollWheelRight 			
		Progress, by75 p100,  Volume Set to: 100`%, Volume: MAX
		WinSet, TransColor, 000000 110, %A_ScriptName%
		run nircmd.exe setappvolume focused 1
		SetTimer, PUBGVolTimer, -1600
	return
#If





; Timers
;=====================================================================================================
; Auto close script when game closes
IsGameShutDown:
	Loop
	{
	    Process, Exist, TslGame.exe ; Sets errorlevel to process PID
	    IfWinNotExist, % ahk_pid errorlevel ; Expression for ahk_pid
		{ 	
			ExitApp
			Break ; Stops loop if run or it will continue forever.
		}
		Sleep 250
	}

; Launch Activation SplashImage (OnTop, Transparent, Clickthrough)
PUBGstartingSplash:
	filename=C:\Dropbox\AHK Scripts\SplashImages\Roki's PUBG Hotkeys Activated.png
	SplashImage, %filename%, b Hide, , , ,
	SplashImage, Show
	WinSet, AlwaysOnTop, On, %A_ScriptName%
	WinSet, ExStyle, +0x20, %A_ScriptName%
	WinSet, TransColor, 000000 150, %A_ScriptName%
	SetTimer, disablePUBGSplashImage, -3200
return

; Turn off Initial SplashImage
disablePUBGSplashImage:
	Sleep 500
	SplashImage, Off
return

; Turn off Progress Bar for displaying Volume Level
PUBGVolTimer:
	Progress, Off
return
