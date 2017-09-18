; Global Variables/Settings
; ==============================================================================
	
	#Persistent
	#NoEnv  		; Recommended for performance and compatibility with future AutoHotkey releases.
	; #Warn  		; Enable warnings to assist with detecting common errors.
	SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
	global PUBGIsRunning 	:= False
	global VolWasChanged 	:= False ; For PUBG
	global CustGameVol 		:= 20
; ==============================================================================
; ==============================================================================


; To activate, you must be in PUGB. (No random clicking/typing outside of PUGB)
; Hotkeys that will activate script:
; 	Alt+Win+NumpadAdd
;	MouseWheel Left/Right (Also works with most Shift, Alt, Ctrl Combos)

; 	Feel free to change or add additional hotkeys for the script. 
;	List of valid keys: https://www.autohotkey.com/docs/KeyList.htm
;	Lines 79-92 are all hotkeys that trigger the volume toggle. 

;=====================================================================================================
; PUBG - Lower in Game Volume

;=====================================================================================================
;		Notes for script
;=====================================================================================================

	; Assuming a default resolution of 1920x1080 	
	; Vol 0 	= x: 1009   or GameWidth * 0.5255208
	; Vol 99	= x: 1240   or GameWidth * 0.6458333
	; Total Pixels between 0 and 100 vol: 231  or 12.03125%
	; +/- 1 Vol	= 2.34444 pixels   or 0.00122104166666
;=====================================================================================================
;=====================================================================================================

; Only detect hotkey when PUBG is the currently active window
#IfWinActive, PLAYERUNKNOWN'S BATTLEGROUNDS 
	PUBGIsRunning := True
	;	Adjust Minimum Volume Level using Ctrl+MouseWheel Up/Down
	;====================================================
	;Volume Up
	^WheelUp:: 
	+^WheelUp:: 
		VolWasChanged = True
		if (CustGameVol < 10)
			CustGameVol := CustGameVol + 1
		else
			CustGameVol := CustGameVol + 5
		Progress, by75 n%CustGameVol% p%CustGameVol%, Lower Volume Set to: %CustGameVol%, Volume: %CurrentVol%`%
		SetTimer, PUBGVolTimer, -1000
	return 
	;Volume Down
	^WheelDown:: 
	+^WheelDown:: 
		if (CustGameVol < 11)
			CustGameVol := CustGameVol - 1
		else
			CustGameVol := CustGameVol - 5
		VolWasChanged = True
		if (CustGameVol < 0)
			CustGameVol = 0
		Progress, by75 n%CustGameVol% p%CustGameVol%, Lower Volume Set to: %CustGameVol%, Volume: %CurrentVol%`%
		SetTimer, PUBGVolTimer, -1000
	return 

	PUBGVolTimer:
		Progress, Off
	Return

	!+WheelRight::	;SrollWheelRight 			(While Running and Free Looking)
	!+WheelLeft::	;SrollWheelLeft 			(While Running and Free Looking)
	+WheelRight::	;Shift + ScrollWheelRight	(While Sprinting)
	+WheelLeft::	;Shift + ScrollWheelLeft    (While Sprinting)
	!^WheelRight::	;Ctrl  + ScrollWheelRight 	(While Sneaking and Free Looking)
	!^WheelLeft::	;Ctrl  + ScrollWheelLeft	(While Sneaking and Free Looking)
	^WheelRight::	;Ctrl  + ScrollWheelRight 	(While Sneaking)
	^WheelLeft::	;Ctrl  + ScrollWheelLeft	(While Sneaking)
	!WheelRight::	;SrollWheelRight 			(While Free Looking)
	!WheelLeft::	;SrollWheelLeft 			(While Free Looking)
	 WheelRight::	;SrollWheelRight 			(While Standing/Walking)
	 WheelLeft::	;SrollWheelLeft 			(While Standing/Walking)

	!#NumpadAdd::	;Alt+Win+NumpadPlus 		(For all you plebs without a mousewheel left/right)

	WinGetPos, gameX, gameY, GameWidth, GameHeight, A
	SettingsX	:= GameWidth  * .5000
	SettingsY	:= GameHeight * .5000
	SoundX		:= GameWidth  * .5599
	SoundY		:= GameHeight * .1800
	lowerVolX	:= GameWidth  * .5500
	lowerVolY	:= GameHeight * .3250
	MaxVolX		:= GameWidth  * .6464
	MaxVolY		:= GameHeight * .3222
	ApplyX		:= GameWidth  * .6911
	ApplyY		:= GameHeight * .8750

	toggle:=!toggle 
	If VolWasChanged = True
		Progress, by75 n%CustGameVol% p%CustGameVol%, Volume Set to: %CustGameVol%
	else If toggle
		Progress, by75 n%CustGameVol% p%CustGameVol%, Volume Set to: %CustGameVol%
	Else
		Progress, by75 n100 p100, Volume Set to: Max
	SetTimer, PUBGVolTimer, -1600

	
	VolStep	:= GameWidth * 0.00122104166666
	ZeroVol	:= GameWidth * 0.5255208
	CustVol	:= ZeroVol + (VolStep * CustGameVol)
;	MouseClick, left, CustVol, lowerVolY, 1, 2		;For testing Mouse Clicks

	AutoRunIsOn = False

		WKeyIsDown := GetKeyState("w" , "p") ; Should we toggle 'auto-run' to continue running while changing Vol? (Is user running?)
		if (WKeyIsDown) {
			SendInput {w Up}
			SendInput {a Up}
			SendInput {s Up}
			SendInput {d Up}
			SendInput {Shift Up}
			SendInput {=}
			AutoRunIsOn = True

			Sleep 20
		}

		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		; 			Begin Menu Selection
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		; We don't want the user messing up the script and causing miss clicks
		BlockInput, MouseMove
		Send {esc}

		Sleep 60
		MouseClick, left, SettingsX, SettingsY, 1, 2		;Mouse starts of centered on "Settings"
		Sleep 180
		MouseClick, left, SoundX, SoundY, 1, 2	; Click "Sound"
		Sleep 100
		If VolWasChanged = True
		{
			MouseClick, left, CustVol, lowerVolY, 1, 2	; Lower Volume to ~23?
			CurrentVol := CustGameVol
			toggle:=toggle 
		}
		else if toggle
		{
			MouseClick, left, CustVol, lowerVolY, 1, 2	; Lower Volume to ~23?
			CurrentVol := CustGameVol
		}
		Else
		{
			MouseClick, left, MaxVolX, MaxVolY, 1, 2	; Raise Volume to 99
			CurrentVol := 100
		}
		Sleep 50
		MouseClick, left, ApplyX, ApplyY, 1, 1	; Click "Apply"

		Send {esc} 	; Close Menu
		Sleep 30	; Pause for Menu closing

		; Mouse script finished. User can move again
		BlockInput, MouseMoveOff
		WKeyIsDown 		:= GetKeyState("w" , "p")
		AKeyIsDown 		:= GetKeyState("a" , "p")
		SKeyIsDown 		:= GetKeyState("s" , "p")
		DKeyIsDown 		:= GetKeyState("d" , "p")
		ShiftKeyIsDown 	:= GetKeyState("Shift" , "p")
		CtlKeyIsDown 	:= GetKeyState("Ctl" , "p")
		Send {Alt Up}
		Sleep 10
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		; 			End Menu Selection
		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		; Resume holding down any keys user has currently held down. (Ex. Running, sprinting, sneaking)
		; Otherwise user has to release and press down key again
		if (WKeyIsDown)
			Send {w Down}
		else
			Send {w Up}
		if (AKeyIsDown)
			Send {a Down}
		if (SKeyIsDown)
			Send {s Down}
		if (DKeyIsDown)
			Send {d Down}
		if (WKeyIsDown | AKeyIsDown | SKeyIsDown | DKeyIsDown | )
		{
			if(ShiftKeyIsDown)
				Send {Shift Down}
			if(CtlKeyIsDown)
				Send {Ctl Down}
		}
		if (AutoRunIsOn = True)
		{
			Send {=}
			MsgBox, 0 Autorun: %AutoRunIsOn%
		}
		VolWasChanged = False
		
	return
	Loop
	{
		IfWinNotExist, PLAYERUNKNOWN'S BATTLEGROUNDS
			Exit
	}
#If

; Force Close Script
; Alt+Ctrl+Win+q
!#^q::
	exit
Return
return
;=====================================================================================================