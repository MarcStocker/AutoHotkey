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
; 'AudDev' and 'MicDev' must be the actual names of the "Playback" and "Recording" 
; devices found in the Sound selection window. 
; 	Pass in "" to avoid changing one of the devices.
;
; 'splashfile' is the filepath to a supported image file (refer to AHK docs). Used
; to show the now active Audio Device, or some type of visual cue.
;	Black (#00000) is set to transparent by default (line 106)
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

		SplashImage, %splashNumber%:%splashfile%, b %splashOptions% Hide, , , ,		
		SplashImage, %splashNumber%:show				; Show Splashscreen Image (This helps to prevent the flash)
		WinSet, TransColor, 000000 150, %A_ScriptName%	; Set Background transparent and entire Image 58% transparent
		WinSet, AlwaysOnTop, On, %A_ScriptName%			; Set Image Always On Top 
		WinSet, ExStyle, +0x20, %A_ScriptName%			; Enable "Clickthrough" on Image so it does not interfer with user

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

turnOffAudioDeviceSplashImages:
	SplashImage, 1:Off
	SplashImage, 2:Off
	SplashImage, 3:Off
	SplashImage, 4:Off
	SplashImage, 9:Off
return
