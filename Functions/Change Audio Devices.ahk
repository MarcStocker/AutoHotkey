;==================================================================================
;==   _____  _                                                      _  _         ==
;==  / ____|| |                                    /\              | |(_)        ==
;== | |     | |__    __ _  _ __    __ _   ___     /  \   _   _   __| | _   ___   ==
;== | |     | '_ \  / _` || '_ \  / _` | / _ \   / /\ \ | | | | / _` || | / _ \  ==
;== | |____ | | | || (_| || | | || (_| ||  __/  / ____ \| |_| || (_| || || (_) | ==
;==  \_____||_| |_| \__,_||_| |_| \__, | \___| /_/    \_\\__,_| \__,_||_| \___/  ==
;==                  _____         __/ |  _                                      ==
;==                 |  __ \       |___/  (_)                                     ==
;==                 | |  | |  ___ __   __ _   ___  ___  ___                      ==
;==                 | |  | | / _ \\ \ / /| | / __|/ _ \/ __|                     ==
;==                 | |__| ||  __/ \ V / | || (__|  __/\__ \                     ==
;==                 |_____/  \___|  \_/  |_| \___|\___||___/                     ==
;==================================================================================
; --------------------------------------------------------------------------------
;  		Change Audio Script/Function - No Pop up windows - Uses NirCmd 
; --------------------------------------------------------------------------------
;
; 		SetDefaultAudioDevice(AudDevice, MicDevice [, splashfile:=""])
;
;==================================================================================
; REQUIREMENTS
;==================================================================================
; NirCmd
;  	NirCmd webpage: https://www.nirsoft.net/utils/nircmd.html     (Bottom of Page)
;  	Direct Download: https://www.nirsoft.net/utils/nircmd-x64.zip
;		Click the "Copy To Windows Directory" button.
;==================================================================================
;		README		README		README		README		README		README
;==================================================================================
; Changes the Primary Default Audio Device and/or Microphone, with Transparent Splashimage.
;
; All SplashImages are assumed to be of size 512x512. You can change this on line 97-98.
;
; Dont forget to check out the SetDefaultAudioDevice_SplashImage() function below.
; This function is used by SetDefaultAudioDevice() to display the SplashImage.
;
;
; 'AudDev' and 'MicDev' must be the actual names of the "Playback" and "Recording" 
; devices found in the Sound selection window. 
; 	Pass in "" to avoid changing one of the devices.
;
; 'splashfile' is the filepath to a supported image file (refer to AHK docs). Used
; to show the now active Audio Device, or some type of visual cue.
;	Black (#00000) is set to transparent by default (line 169)
;==================================================================================


	;A default Script for reference, or use, just remove the comments with 2 ';'
	;=================================================================================
	; Toggle Between 2 primary Audio Devices and Microphones
	;	- Onkyo Sound System
	;	- G930 Headset
	;=================================================================================
	;;ScrollLock:: ;ScrollLock default hotkey
	;;^!#+t::      ;Hotkey to emulate Printscreen for the TV Remote
	;;
	;;	audiotoggle:=!audiotoggle ;Toggle between 2 Primary Audio Sources (Headset and Stereo) 
	;;	if audiotoggle
	;;	{
	;;		AudDev=Onkyo Sound System
	;;		MicDev=WebCam Mic
	;;		audiosplashfile=C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Stereo transparent 3d.png
	;;	}
	;;	Else
	;;	{
	;;		AudDev=G930 Headset
	;;		MicDev=G930 Mic
	;;		audiosplashfile=C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Headset 3d.png
	;;	}
	;;
	;;	SetDefaultAudioDevice(AudDev, MicDev, audiosplashfile) 	;Set Audio and Mic Devices
	;;Return
	;;;---------------------------------------------------------------------------------
	;;
	;;;=================================================================================
	;;; Change Directly to the Monitor Speakers
	;;;=================================================================================
	;;+ScrollLock::   ;;;; Shift + ScrollLock - Switch Audio Device to one of the 2 monitors
	;;
	;;	MicDev=WebCam Mic
	;;	audiosplashfile=
	;;									
	;;	SetDefaultAudioDevice("Asus Monitor", "", "C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Asus Monitor.png")
	;;										; ^^ Don't change Microphone
	;;return
	;;;---------------------------------------------------------------------------------


;=============================================================================================
;=============================================================================================
;=============================================================================================
;=============================================================================================

SetDefaultAudioDevice(AudDevice, MicDevice, splashfile:="")
{
	defaultImageWidth:=512
	defaultImageHeight:=512

	; Deactivate SplashImages, and cancel the timer to turn them off
	SetTimer, turnOffAudioDeviceSplashImages, Off
	SplashImage, 1:Off
	SplashImage, 2:Off
	SplashImage, 3:Off
	SplashImage, 4:Off
	SplashImage, 9:Off

	; Build GUI to Display Current Audio Device (But Start Hidden to help prevent flashing black background)
	if FileExist(splashfile)
	{
		SysGet, NumMonitors, MonitorCount
		loop % NumMonitors
		{
			SysGet, Mon%A_Index%, Monitor, %A_Index%
			if (Mon%A_Index%Left = )
				Continue
			MonRight:= Mon%A_Index%Right
			MonLeft	:= Mon%A_Index%Left
			MonTop	:= Mon%A_Index%Top
			MonBot	:= Mon%A_Index%Bottom

			xCenter:=(MonLeft+((MonRight-MonLeft)/2))-(defaultImageWidth/2)
			yCenter:=(MonTop+((MonBot-MonTop)/2))-(defaultImageHeight/2)

			SetDefaultAudioDevice_SplashImage(A_Index, splashfile,  xCenter, yCenter )
		}
		SetTimer, turnOffAudioDeviceSplashImages, -1200				;'Deactivate Splash Images' Timer
	}
	else
		Msgbox, Audio SplashImage file does not exist. `n`nPlease check the file path again. 
	
	; Set Default Audio Device
	if AudDevice != ""
	{
		run nircmd.exe setdefaultsounddevice "%AudDevice%" 0 	;Set default audio device - Console
		run nircmd.exe setdefaultsounddevice "%AudDevice%" 1	;Set default audio device - Multimedia
		run nircmd.exe setdefaultsounddevice "%AudDevice%" 2	;Set default audio device - Communications
	}
	
	; Set Default Microphone
	if MicDevice != ""
	{
		run nircmd.exe setdefaultsounddevice "%MicDevice%" 0 	;Set default mic device - Console
		run nircmd.exe setdefaultsounddevice "%MicDevice%" 1	;Set default mic device - Multimedia
		run nircmd.exe setdefaultsounddevice "%MicDevice%" 2	;Set default mic device - Communications
	}
}

SetDefaultAudioDevice_SplashImage(splashNumber, splashfile, xOffset:="Null", yOffset:="Null") ;Will need to eventually figure out to center on any monitor, regardless of position.
{
	; Create X and Y Offsets to shift the image around the screen/monitors
	; If only 1 axis is provided, the Image will center on the opposite axis
	; If 0 axis are provided, the Image is centered on the Primary Monitor
	if xOffset != Null
	{
		if (xOffset >= 0)
			splashOptions = %splashOptions% x+%xOffset%
		if (xOffset < 0)
			splashOptions = %splashOptions% x%xOffset%
	}
	if yOffset != Null
	{
		if (yOffset > 0)
			splashOptions = %splashOptions% y+%yOffset%
		if (yOffset < 0)
			splashOptions = %splashOptions% y%yOffset%
	}

	SplashImage, %splashNumber%:%splashfile%, b %splashOptions% Hide, , , ,		
	SplashImage, %splashNumber%:show				; Show Splashscreen Image (This helps to prevent the flash)
	WinSet, TransColor, 000000 150, %A_ScriptName%	; Set Background transparent and entire Image 58% transparent
	WinSet, AlwaysOnTop, On, %A_ScriptName%			; Set Image Always On Top 
	WinSet, ExStyle, +0x20, %A_ScriptName%			; Enable "Clickthrough" on Image so it does not interfer with user
}

turnOffAudioDeviceSplashImages:
	SplashImage, 1:Off
	SplashImage, 2:Off
	SplashImage, 3:Off
	SplashImage, 4:Off
	SplashImage, 9:Off

	; Refresh Rainmeter Visualizers (so they pick up new default audio device)
	IfWinExist, ahk_exe Rainmeter.exe
	{
		Run, C:\Program Files\Rainmeter\Rainmeter.exe !Refresh "monstercat-visualizer"
		Run, C:\Program Files\Rainmeter\Rainmeter.exe !Refresh "monstercat-visualizer - Right Monitor"
		Run, C:\Program Files\Rainmeter\Rainmeter.exe !Refresh "monstercat-visualizer - Left Monitor"
	}
return




;;;;; Old Hardcoded Method of displaying SplashImages

		;if NumMonitors = 1
		;	SetDefaultAudioDevice_SplashImage(1, splashfile)		;Center Monitor (Primary)
		;if NumMonitors = 2
		;{
 		;	SetDefaultAudioDevice_SplashImage(1, splashfile)		;Center Monitor (Primary)
		;	SetDefaultAudioDevice_SplashImage(2, splashfile, -1270)	;Left Monitor
		;}
		;if NumMonitors = 3
		;{
		;	SetDefaultAudioDevice_SplashImage(1, splashfile)		;Center Monitor (Primary)
		;	SetDefaultAudioDevice_SplashImage(2, splashfile, -1270)	;Left Monitor
		;	SetDefaultAudioDevice_SplashImage(3, splashfile, 2570)	;Right Monitor
		;}
		;if NumMonitors = 4	;For work setup
		;{
		;	SetDefaultAudioDevice_SplashImage(1, splashfile)		;Center Monitor (Primary)
		;	SetDefaultAudioDevice_SplashImage(2, splashfile, -840)	;Left Monitor
		;	SetDefaultAudioDevice_SplashImage(3, splashfile, 2570)	;Right Monitor
		;}
