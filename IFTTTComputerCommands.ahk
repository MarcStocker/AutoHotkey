;=====================================================================================================
; Google Home Dropbox Computer Manipulation Script
;=====================================================================================================
	#Persistent
	#NoEnv  		; Recommended for performance and compatibility with future AutoHotkey releases.
	;#Warn  		; Enable warnings to assist with detecting common errors.
	SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

	Global fileToWatch:="C:\Dropbox\AHK Scripts\Watched Files\ComputerCommands.txt"
	Global fileToDelete:="C:\Dropbox\AHK Scripts\Watched Files\ComputerCommands*.txt"
	Global fileToLog:="C:\Dropbox\AHK Scripts\Watched Files\Logs.txt"
	Global IFTTTLogTime
	Global hour

;=====================================================================================================
;		Notes for script
;=====================================================================================================
; Uses the program NirCmd to turn off monitors. Though there is a DLL call for that as well I believe.
;  	Nircmd Webpage: https://www.nirsoft.net/utils/nircmd.html
;  	Direct Download: https://www.nirsoft.net/utils/nircmd-x64.zip
;
; Uses F.lux to dim the computer screen
;	F.lux Webpage: https://justgetflux.com
;
; Uses my function ProjectMonitor() and ChangeAudioDevices()

;=====================================================================================================
;		README		README		README		README		README		README		README		README
;=====================================================================================================
;
;	This script will watch for a specific file in dropbox ( ^ fileToWatch from above ^ ).
;	The file will be created and written to by IFTTT via Google Home commands and Dropbox. 
;	The file will contain a single line, a command, that this script will execute. 
;	After a command has been executed, the file is deleted. 
; 	This script then waits for the file to be created again. (loops forever looking for the file)
;
;	Possible commands:
;
;	 Function:	Puts Computer into sleep mode.
;	 Command1:	"Put my computer to sleep"
;	 Command2:	"Put my desktop to sleep"
;	 Command3:	"Shutdown my computer"
;	 Response:	"Putting your desktop to sleep"
;
;	 Function:	Turn the monitors off. (The same way they turn off after X minutes of inactivity. Activity will turn them back on)
;	 Command1:	"Turn off monitor"
;	 Command2:	"Turn off monitors"
;	 Command3:	"Turn monitor off"
;	 Response:	"Turning off Monitors"
;
;	 Function:	Keep the monitors off, in case a video program, or game, doesn't turn the monitors back on. (Sends Win+D to hide all apps, then sleeps the monitors)
;	 Command1:	"Keep the monitors off"
;	 Command2:	"Keep screens off"
;	 Command3:	"Keep monitors off"
;	 Response:	N/A
;
;	 Function:	Toggle between the (2) main audio devices.
;	 Command1:	"Toggle Audio"
;	 Command2:	"Swap Audio"
;	 Command3:	"Change Audio"
;	 Response:	"Changing the audio device."
;
;	 Function:	Launch Kodi, switch to sound system audio device and change display mode to 'Second Screen only' (the TV).
;	 Command1:	"Start Kodi"
;	 Command2:	"Prepare media"
;	 Command3:	"Launch Kodi"
;	 Response:	"Starting Kodi."
;
;	 Function:	Launch Plex, switch to sound system audio device and change display mode to 'Second Screen only' (the TV).
;	 Command1:	"Start Plex"
;	 Command2:	"Launch Plex"
;	 Command3:	""
;	 Response:	"Starting Plex."
;
;	 Function:	Shudown Kodi, turn off Kodi, switch to Primary Monitor, and turn off the screen, and brownoise?.
;	 Command1:	"Shutdown Kodi"
;	 Command3:	"Kill Kodi"
;	 Command2:	""
;	 Response:	""
;
;	 Function:	Toggle flux on/off using the alt+End command.
;	 Command1:	"Turn off Flux"
;	 Command2:	"Disable Flux"
;	 Command3:	"Toggle Flux"
;	 Response:	"Flux Toggled"
;
;	 Function:	Dims screen as far as flux will allow. 
;	 Command1:	"Dim the screen"
;	 Command2:	"Dim screen"
;	 Command3:	"Dim Flux"
;	 Response:	"Dimming screen"
;
;	 Function:	Switches to "PC Screen Only" display mode.
;	 Command1:	"Switch to primary monitor"
;	 Command2:	"Primary monitor only"
;	 Command3:	"Change to primary monitor"
;	 Response:	"Switching to primary monitor only"
;
;	 Function:	Switches to "Second Screen Only" display mode.
;	 Command1:	"Second screen only"
;	 Command2:	"Turn on the TV"
;	 Command3:	"Enable projector"
;	 Response:	"Turning on TV"
;
; 	 Function:	Switches to "Duplicate" display mode.
; 	 Command1:	"Duplicate mode"
; 	 Command2:	"Duplicate Monitors"
; 	 Command3:	"Switch to Duplicate mode"
;
; 	 Response:	"Duplicating Monitors"
;	 Function:	Switches to "Extend" display mode.
;	 Command1:	"Extended mode"
;	 Command2:	"Extend Monitors"
;	 Command3:	"Switch to Extended mode"
;	 Response:	"Extending Monitors"
;
;	 Function:	Pauses Kodi by focussing the Kodi window and sending a Spacebar key stroke (Pause). 
;	 Command1:	"Pause Kodi"
;	 Command2:	""
;	 Command3:	""
;	 Response:	"Pausing"
;
;	 Function:	Toggles Kodi fullscreen by focussing the window and sending the '\' key stroke. 
;	 Command1:	"Fullscreen Kodi"
;	 Command2:	"Full screen Kodi"
;	 Command3:	"Toggle Kodi fullscreen"
;	 Response:	"Toggling Kodi fullscreen"
;	
;	 Function:	Brown Noise - Stops Kodi and plays a Brown Noise track via VLC
;	 Command1:	"Enable Sleep Mode"
;	 Command2:	"Start Sleep Mode"
;	 Command3:	"Bed Time"
;	 Response:	"Sleep Mode"	
;
;	 Function:	Start Zelda
;	 Command1:	"Start Zelda"
;	 Command2:	""
;	 Command3:	""
;	 Response:	"Starting Zelda"
;
;	 Function:	Reboot PC 
;	 Command1:	"Please reboot My Computer"
;	 Command2:	"Turn My PC On and Off Again"
;	 Command3:	""
;	 Response:	"Restarting Desktop"
;
;    ========= Commands for testing the script =========
;
;	 Function:	Reloads this script. (Used for testing.)
;	 Command1:	"Reload"
;	 Command2:	"Reload script"
;	 Command3:	"Restart script"
;	 Response:	"Reloading If This Than That script"
;
;	 Function:	Test function. Used for testing different scripts and computer commands without having to assign a hotkey. 
;	 Command1:	"Test Script"
;	 Command2:	"Run test"
;	 Command3:	""
;	 Response:	"Running test"

;=====================================================================================================
;		README		README		README		README		README		README		README		README
;=====================================================================================================

FileDelete, %fileToDelete%
	if(A_Hour > 11)
	{
		if (A_Hour > 12)
		{
			hour := A_Hour - 12
			IFTTTLogTime = %hour%:%A_Min%:%A_Sec%.%A_MSec% PM %A_MM%/%A_DD%/%A_YYYY%
		}
		else
			hour = %A_Hour%
		if (hour < 10)
			IFTTTLogTime = 0%hour%:%A_Min%:%A_Sec%.%A_MSec% PM %A_MM%/%A_DD%/%A_YYYY%
		else
			IFTTTLogTime = %hour%:%A_Min%:%A_Sec%.%A_MSec% PM %A_MM%/%A_DD%/%A_YYYY%
	}
	else
		IFTTTLogTime = %A_Hour%:%A_Min%:%A_Sec%.%A_MSec% AM %A_MM%/%A_DD%/%A_YYYY%

FileAppend, `n|----- SCRIPT STARTED ------|---%IFTTTLogTime%---|, %fileToLog%

SetTimer, IFTTTwatchFile, 1000, -9999

; Add an else if to the list below to create a new command
; Just copy the first 3 lines and fill in a unique KEYWORD
;
;	else if (OutputVar = "KEYWORD")
;	{
;		COMMAND TO EXECUTE
;	}
IFTTTwatchFile:
	FileRead, OutputVar, %fileToWatch%
	if !FileExist(fileToWatch)
		return
	if FileExist(fileToWatch)
	{

		FileGetTime, fileAgeVar, %fileToWatch%
		FileAge:=A_Now
		FileAge -= fileAgeVar, Seconds

		if (FileAge > 5)
		{
			FileDelete, %fileToDelete%
			AddLogEntry("DELETE OLD COMMAND")
			return
		}
	}
	if OutputVar = "blank"
		FileDelete, %fileToWatch%
	; Function:	Puts Computer into sleep mode.
	; Command1:	"Put my computer to sleep"
	; Command2:	"Put my desktop to sleep"
	; Command3:	"Shutdown my computer"
	; Response:	"Putting your desktop to sleep"
	else if (OutputVar = "sleep")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Sleep")
		DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
	}
	; Function:	Turn the monitors off. (The same way they turn off after X minutes of inactivity. Activity will turn them back on)
	; Command1:	"Turn off monitor"
	; Command2:	"Turn off monitors"
	; Command3:	"Turn monitor off"
	; Response:	"Turning off Monitors"
	else if (OutputVar = "monitoroff")
	{
		FileDelete, %fileToDelete%
		Send {Win d}
		AddLogEntry("Monitor Off")
		run nircmd.exe monitor async_off
	}
	; Function:	Keep the monitors off, in case a video program, or game, doesn't turn the monitors back on. (Sends Win+D to hide all apps, then sleeps the monitors)
	; Command1:	"Keep the monitors off"
	; Command2:	"Keep screens off"
	; Command3:	"Keep monitors off"
	; Response:	N/A
	else if (OutputVar = "keepmonitorsoff")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Keep Monitors Off")
		kmotoggle=!kmotoggle
		if kmotoggle
			SetTimer, KeepMonitorOff, -100
		else
			SetTimer, KeepMonitorOff, Off
	}
	; Function:	Toggle between the (2) main audio devices.
	; Command1:	"Toggle Audio"
	; Command2:	"Swap Audio"
	; Command3:	"Change Audio"
	; Response:	"Changing the audio device."
	else if (OutputVar = "changeaudio")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Toggle Audio")
		GoSub, ScrollLock ;Call hotkey to toggle between my main 2 audio devices using ChangeAudioDevice() function
	}
	; Function:	Launch Kodi, switch to sound system audio device and change display mode to 'Second Screen only' (the TV).
	; Command1:	"Start Kodi"
	; Command2:	"Prepare media"
	; Command3:	"Launch Kodi"
	; Response:	"Starting Kodi."
	else if (OutputVar = "watchkodi")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Start Kodi")

		;Switch Audio Device to Sound System
		SetDefaultAudioDevice("Onkyo Sound System", "WebCam Mic", "C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Stereo transparent 3d.png")


		;Launch Kodi
		IfWinNotExist, Kodi
		{
			run, C:\Program Files (x86)\Kodi\kodi.exe
			WinWait, Kodi,, 5
		}

		; Change Monitors
		ProjectMonitor("secondscreenonly")
		
		; Move Pushbullet if necessary
		AdjustPushbullet(1912, 122, 0, 63, "Vertical")

		; Focus the Kodi Window
		WinActivate, Kodi
		IfWinNotActive, Kodi
		{
			WinWait, Kodi,, 5
		}
		IfWinActive, Kodi
		{
			WinGetPos, x,y, width, height, Kodi
			Sleep 1000
			if (width != 1920) && (height != 1080)
				Send {\}
				;     ^ Fullscreen kodi (if needed)
			Sleep 3000
		}
	}
	; Function:	Launch Plex, switch to sound system audio device and change display mode to 'Second Screen only' (the TV).
	; Command1:	"Start Plex"
	; Command2:	"Launch Plex"
	; Command3:	""
	; Response:	"Starting Plex."
	else if (OutputVar = "watchplex")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Start Plex")

		;Switch Audio Device to Sound System
		SetDefaultAudioDevice("Onkyo Sound System", "WebCam Mic", "C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Stereo transparent 3d.png")


		;Launch Kodi
		IfWinNotExist, PlexMediaPlayer.exe
		{
			run, C:\Program Files\Plex\Plex Media Player\PlexMediaPlayer.exe
			WinWait, PlexMediaPlayer.exe,, 5
		}

		; Change Monitors
		ProjectMonitor("secondscreenonly")
		
		; Move Pushbullet if necessary
		AdjustPushbullet(1999, 122, 0, 63, "Vertical")
		
		; Focus the Plex Window
		WinActivate, ahk_exe PlexMediaPlayer.exe
		IfWinNotActive, ahk_exe PlexMediaPlayer.exe
		{
			WinWait, ahk_exe PlexMediaPlayer.exe,, 5
		}
		IfWinActive, ahk_exe PlexMediaPlayer.exe
		{
			WinGetPos, x,y, width, height, ahk_exe PlexMediaPlayer.exe
			Sleep 1000
			if (width != 1920) && (height != 1080)
				Send {f11}
				;     ^ Fullscreen kodi (if needed)
			Sleep 3000
		}
	}
	; Function:	Shudown Kodi, turn off Kodi, switch to Primary Monitor, and turn off the screen, and brownoise?.
	; Command1:	"Shutdown Kodi"
	; Command3:	"Kill Kodi"
	; Command2:	""
	; Response:	""
	else if (OutputVar = "killkodi")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Start Kodi")



		ifwinexist, Kodi
		{
			WinActivate, Kodi
			WinWait, Kodi,, .5
			Send x
			Sleep 1120
			WinClose, Kodi
			Sleep 1200
		}
		Sleep 300
		run nircmd.exe monitor async_off
	}
	; Function:	Toggle flux on/off using the alt+End command.
	; Command1:	"Turn off Flux"
	; Command2:	"Disable Flux"
	; Command3:	"Toggle Flux"
	; Response:	"Flux Toggled"
	else if (OutputVar = "turnoffflux")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Flux - Toggle")
		Send !{End}
	}
	; Function:	Dims screen as far as flux will allow. 
	; Command1:	"Dim the screen"
	; Command2:	"Dim screen"
	; Command3:	"Dim Flux"
	; Response:	"Dimming screen"
	else if (OutputVar = "dimflux")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Flux - Dim")
		ThisText=Dimming the Screen
		TrayTip, AHK - F.lux (Dimming), %ThisText%,, 1
		HideTrayTipIFTTT()
		Sleep 800
		Send {Alt Down}
		Loop, 20 
		{
			SendInput {PgUp} 
			Sleep 100
		}
		Send {Alt Up}
		Sleep 800
		Send {Alt Down}
		loop, 11
		{
			SendInput {PgDn}
			Sleep 200
		}
		Send {Alt Up}
		Sleep 1000
	}
	; Function:	Switches to "PC Screen Only" display mode.
	; Command1:	"Switch to primary monitor"
	; Command2:	"Primary monitor only"
	; Command3:	"Change to primary monitor"
	; Response:	"Switching to primary monitor only"
	else if (OutputVar = "primarymonitor")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Switch Mon - Primary")

		ProjectMonitor(1)
	}
	; Function:	Switches to "Second Screen Only" display mode.
	; Command1:	"Second screen only"
	; Command2:	"Turn on the TV"
	; Command3:	"Second Monitor only"
	; Response:	"Turning on TV"
	else if (OutputVar = "secondscreen")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Switch Mon - Secondary")

		ProjectMonitor(4) ; or -> secondscreen, secondscreenonly, 4
	}
	; Function:	Switches to "Extend" display mode.
	; Command1:	"Extended mode"
	; Command2:	"Extend Monitors"
	; Command3:	"Switch to Extended mode"
	; Response:	"Extending Monitors"
	else if (OutputVar = "extendedmonitor")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Switch Mon - Extended")

		ProjectMonitor(3)
	}
	; Function:	Switches to "Duplicate" display mode.
	; Command1:	"Duplicate mode"
	; Command2:	"Duplicate Monitors"
	; Command3:	"Switch to Duplicate mode"
	; Response:	"Duplicating Monitors"
	else if (OutputVar = "duplicatemonitor")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Switch Mon - Extended")

		ProjectMonitor(2)
	}
	; Function:	Pauses Kodi by focussing the Kodi window and sending a Spacebar key stroke (Pause). 
	; Command1:	"Pause Kodi"
	; Command2:	""
	; Command3:	""
	; Response:	"Pausing"
	else if (OutputVar = "pausekodi")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Pause Kodi")
		CurrentWindow := WinExist("A")
		WinActivate, Kodi
		Sleep 100
		Send {Media_Play_Pause}
		Sleep 100
		WinActivate, CurrentWindow
	}
	; Function:	Toggles Kodi fullscreen by focussing the window and sending the '\' key stroke. 
	; Command1:	"Fullscreen Kodi"
	; Command2:	"Full screen Kodi"
	; Command3:	"Toggle Kodi fullscreen"
	; Response:	"Toggling Kodi fullscreen"
	else if (OutputVar = "fullscreenkodi")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Fullscreening Kodi")
		CurrentWindow := WinExist("A")
		WinActivate, Kodi
		Sleep 100
		Send {\}
	}
	; Function:	Brown Noise - Stops Kodi and plays a Brown Noise track via VLC
	; Command1:	"Enable Sleep Mode"
	; Command2:	"Start Sleep Mode"
	; Command3:	"Bed Time"
	; Response:	"Sleep Mode"
	else if (OutputVar = "brownnoise")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Brown Noise")
		Run, Super Deep Brown Noise (12 Hours) [144p].3gp, C:\Users\Marc\Downloads\, Hide
		Sleep 2250
		WinWait, ahk_exe vlc.exe
		WinActivate, ahk_exe vlc.exe
		Sleep 1000
		loop, 40
		{
			MouseClick, WD, , , 1, 2	
			Sleep 20
		}
		loop, 30
		{
			MouseClick, WU, , , 1, 2	
			Sleep 20
		}
		Sleep 500

		IfWinExist, Kodi
		{
			WinActivate, Kodi

			SendInput {+ down}
			Sleep 3000
			SendInput {+ up}

			loop, 30
			{
				SendInput {-}
				Sleep 250
			}
			SendInput {\}
			Sleep 500
			WinMinimize, Kodi
			PostMessage, 0x112, 0xF020,,, Kodi, 	; 0x112 = WM_SYSCOMMAND, 0xF020 = SC_MINIMIZE
			Sleep 800
		}
		ProjectMonitor("primarymonitor")
		SendInput #d
		Sleep 400
		run nircmd.exe monitor async_off
	}
	; Function:	Wake up Morning Routine
	; Command1:	"Morning Routine"
	; Command2:	""
	; Command3:	""
	; Response:	""
	else if (OutputVar = "morningroutine")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Morning Routine")

		WinActivate, ahk_exe vlc.exe
		loop, 20
		{
			WinActivate, ahk_exe vlc.exe
			MouseClick, WD, 500, 500, 1, 2	
			Sleep 1000
		}

		WinClose, ahk_exe vlc.exe
		run nircmd.exe monitor async_off
	}
	; Function:	Start Zelda
	; Command1:	"Start Zelda"
	; Command2:	""
	; Command3:	""
	; Response:	"Starting Zelda"
	else if (OutputVar = "startzelda")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Playing Zelda")

		ProjectMonitor("duplicate")
		Run, C:\Dropbox\AHK Scripts\Gaming Scripts\Zelda Launch Setup - Cemu.exe
	}
	; Function:	Computer Sleep Timer
	; Command1:	"Start Zelda"
	; Command2:	""
	; Command3:	""
	; Response:	"Starting Zelda"
	
	; Function:	Reboot PC 
	; Command1:	"Please reboot My Computer"
	; Command2:	"Turn My PC On and Off Again"
	; Command3:	""
	; Response:	"Restarting Desktop"
	else if (OutputVar = "RebootPC")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Reboot Computer")

		Shutdown, 6
	}

	else if (OutputVar = "sleep")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("RELOAD SCRIPT")



	}
	; Function:	
	; Command1:	
	; Command2:	
	; Command3:	
	; Response:	
	else if (OutputVar = "foodbot")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("Launch Foodbot.py")

		Run, C:\Dropbox\Software\SlackBots\slackFoodBot.py
	}
	; Function:	Reloads this script. (Used for testing.)
	; Command1:	"Reload"
	; Command2:	"Reload script"
	; Command3:	"Restart script"
	; Response:	"Reloading If This Than That script"
	else if (OutputVar = "reload")
	{
		FileDelete, %fileToDelete%
		AddLogEntry("RELOAD SCRIPT")
		ThisText=Reloading Google Ass IFTTT Script
		TrayTip, AHK - Google Assistant App Reloading, %ThisText%,, 1
		Sleep 2500
		HideTrayTipIFTTT()
		Reload
	}
	; Function:	Test function. Used for testing different scripts and computer commands without having to assign a hotkey. 
	; Command1:	"Test Script"
	; Command2:	"Run test"
	; Command3:	""
	; Response:	"Running test"
	else if (OutputVar = "test")
	{
		FileDelete, %fileToDelete%
		TrayTip, AHK - F.lux (Dimming), %ThisText%,, 1
		HideTrayTipIFTTT()
		AddLogEntry("New Test")
		;WindowsLockScreen()
	}

Return


;===========================================================
;==  ______                    _    _                     ==
;== |  ____|                  | |  (_)                    ==
;== | |__  _   _  _ __    ___ | |_  _   ___   _ __   ___  ==
;== |  __|| | | || '_ \  / __|| __|| | / _ \ | '_ \ / __| ==
;== | |   | |_| || | | || (__ | |_ | || (_) || | | |\__ \ ==
;== |_|    \__,_||_| |_| \___| \__||_| \___/ |_| |_||___/ ==
;==                                                       ==
;===========================================================


HideTrayTipIFTTT() 
{
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." 
    {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}


WindowsLockScreen()
{
	CoordMode, Mouse, Screen
	Soundbeep,,500
	Send {Enter Down}
	Sleep 2000
	Send {Enter Down}
	Soundbeep,,500
	Send {Enter Down}

	CoordMode, Mouse, Relative
}


AddLogEntry(Command)
{
	fileToLog:="C:\Dropbox\AHK Scripts\Watched Files\Logs.txt"
	if(A_Hour > 11)
	{
		if (A_Hour > 12)
		{
			hour := A_Hour - 12
			IFTTTLogTime = %hour%:%A_Min%:%A_Sec%.%A_MSec% PM %A_MM%/%A_DD%/%A_YYYY%
		}
		else
			hour = %A_Hour%
		if (hour < 10)
			IFTTTLogTime = 0%hour%:%A_Min%:%A_Sec%.%A_MSec% PM %A_MM%/%A_DD%/%A_YYYY%
		else
			IFTTTLogTime = %hour%:%A_Min%:%A_Sec%.%A_MSec% PM %A_MM%/%A_DD%/%A_YYYY%
	}
	else
		IFTTTLogTime = %A_Hour%:%A_Min%:%A_Sec%.%A_MSec% AM %A_MM%/%A_DD%/%A_YYYY%

	if((StrLen(Command) < 0) && (StrLen(Command) < 5))
		FileAppend, `n|`t%Command%`t`t`t`t`t`t|`t%IFTTTLogTime%`t |, %fileToLog%♥
	else if((StrLen(Command) > 4) && (StrLen(Command) < 8))
		FileAppend, `n|`t%Command%`t`t`t`t`t|`t%IFTTTLogTime%`t |, %fileToLog%
	else if((StrLen(Command) > 7) && (StrLen(Command) < 12))
		FileAppend, `n|`t%Command%`t`t`t`t|`t%IFTTTLogTime%`t |, %fileToLog%
	else if((StrLen(Command) > 11) && (StrLen(Command) < 16))
		FileAppend, `n|`t%Command%`t`t`t|`t%IFTTTLogTime%`t |, %fileToLog%
	else if((StrLen(Command) > 15) && (StrLen(Command) < 20))
		FileAppend, `n|`t%Command%`t`t|`t%IFTTTLogTime%`t |, %fileToLog%
	else if((StrLen(Command) > 19) && (StrLen(Command) < 24))
		FileAppend, `n|`t%Command%`t|`t%IFTTTLogTime%`t |, %fileToLog%
	else if(StrLen(Command) == 20)
		FileAppend, `n|`t%Command%|`t%IFTTTLogTime%`t |, %fileToLog%
}

;============================================
;  _______  _                              ==
; |__   __|(_)                             ==
;    | |    _  _ __ ___    ___  _ __  ___  ==
;    | |   | || '_ ` _ \  / _ \| '__|/ __| ==
;    | |   | || | | | | ||  __/| |   \__ \ ==
;    |_|   |_||_| |_| |_| \___||_|   |___/ ==
;============================================
; All Timers can be found in Marcs_Master_AHK_List.ahk
;'''might do this later''' This is to avoid any "return's" in a Timer Script
;============================================

;; Rerun "Sleep Monitor" command
KeepMonitorOff:	
	loop
	{
		run nircmd.exe monitor async_off
		Sleep 300
	}
return
