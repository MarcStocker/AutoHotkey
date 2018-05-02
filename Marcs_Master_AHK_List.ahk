;==========================================================================================
;==========================================================================================
;=======     __  __                   _       __  __              _                 =======
;=======    |  \/  |                 ( )     |  \/  |            | |                =======
;=======    | \  / |  __ _  _ __  ___|/ ___  | \  / |  __ _  ___ | |_  ___  _ __    =======
;=======    | |\/| | / _` || '__|/ __| / __| | |\/| | / _` |/ __|| __|/ _ \| '__|   =======
;=======    | |  | || (_| || |  | (__  \__ \ | |  | || (_| |\__ \| |_|  __/| |      =======
;=======    |_|  |_| \__,_||_|   \___| |___/ |_|  |_| \__,_||___/ \__|\___||_|      =======
;=======                       _    _  _  __  _       _       _                     =======
;=======                /\    | |  | || |/ / | |     (_)     | |                    =======
;=======               /  \   | |__| || ' /  | |      _  ___ | |_                   =======
;=======              / /\ \  |  __  ||  <   | |     | |/ __|| __|                  =======
;=======             / ____ \ | |  | || . \  | |____ | |\__ \| |_                   =======
;=======            /_/    \_\|_|  |_||_|\_\ |______||_||___/ \__|                  =======
;==========================================================================================
;==========================================================================================
;==  Quick Cheat Sheet                                                              =======
;==  -----------------------------------------------------------------------------  =======
;==  Hotkeys: ^ = Control; ! = Alt; + = Shift; # = Windows key; * = Wildcard;       =======
;==           & = Combo keys; Others include ~, $, UP (see "Hotkeys" in Help)       =======
;==  -----------------------------------------------------------------------------  =======
;==  SetTitleMatchMode, Fast|Slow                                                   =======
;==      1: A window's title must start with the specified WinTitle to be a match.  =======
;==      2: A window's title can contain WinTitle anywhere inside it to be a match. =======
;==      3: A window's title must exactly match WinTitle to be a match.             =======
;==========================================================================================
;==========================================================================================

;------------------------------------------------------------------------------------------
; Starting Script SplashImage (Displays AHK 3 key logo with "Starting Master Script" on the keys)
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

ScriptStartingGui:
{
    Sleep 1500
    SplashImage, 8:Off
    SplashImage, 9:Off
    SplashImage, 10:Off
}
;------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------



; Set Script #Directives and Defaults
;==========================================================================================
;==========================================================================================
    #Persistent
    #NoEnv          ; Recommended for performance and compatibility with future AutoHotkey releases.
    SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
    BlockInput, Off ; In case there was an issue and the mouse is locked out
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
;    #include C:\Dropbox\AHK Scripts\Window Moving-Setup.ahk
;===================================================================================================
; Gaming Scripts
;===================================================================================================
;    #include C:\Dropbox\AHK Scripts\Gaming Scripts\RL Audio Toggle Adjustment.ahk
;===================================================================================================
; Audio Manipulation
;===================================================================================================
    ;#include C:\Dropbox\AHK Scripts\~~Master Scripts Collection\Change Audio Devices.ahk
;===================================================================================================
; Functions
;===================================================================================================
    #include C:\Dropbox\AHK Scripts\Functions\Change Audio Devices.ahk
    #include C:\Dropbox\AHK Scripts\Functions\ProjectMonitor.ahk
;=================================================================================================== - End Include Scripts Section

; Global Variables/Settings
;===============================================================================
    
    #Persistent     ; Keeps a script permanently running (that is, until the user closes it or ExitApp is encountered).
    #NoEnv          ; Recommended for performance and compatibility with future AutoHotkey releases.
    ;#Warn          ; Enable warnings to assist with detecting common errors.
    SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

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
;      Nircmd webpage: https://www.nirsoft.net/utils/nircmd.html
;      Direct Download: https://www.nirsoft.net/utils/nircmd-x64.zip
; -----------------------------------------------------------------------------
; 'AudDev' and 'MicDev' must be the actual names of the "Playback" and "Recording" 
; devices found in the Sound selection window
;=================================================================================
; Toggle Between 2 primary Audio Devices and Microphones
;    - Onkyo Sound System
;    - G930 Headset
;=================================================================================
ScrollLock:: ;ScrollLock default hotkey
^!#+t::      ;Hotkey to emulate Printscreen for the TV Remote

    audiotoggle:=!audiotoggle ;Toggle between 2 Primary Audio Sources (Headset and Stereo) 
    if audiotoggle
    {
        AudDev=Onkyo Sound System
        MicDev=WebCam Mic
        audiosplashfile=C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Stereo transparent 3d.png
    }
    Else
    {
        AudDev=G930 Headset
        MicDev=G930 Mic
        audiosplashfile=C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Headset 3d.png
    }

    SetDefaultAudioDevice(AudDev, MicDev, audiosplashfile)     ;Set Audio and Mic Devices
Return
;---------------------------------------------------------------------------------

;=================================================================================
; Change Directly to the Monitor Speakers
;=================================================================================
+ScrollLock::   ;;;; Shift + ScrollLock - Switch Audio Device to one of the 2 monitors

    AudDev=Asus Monitor
    MicDev=WebCam Mic
    audiosplashfile=C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Asus Monitor.png

    SetDefaultAudioDevice(AudDev, MicDev, audiosplashfile)    ;Set Audio and Mic Devices
    
return
;---------------------------------------------------------------------------------

;=================================================================================
; OLD VERSION - Toggle Audio by navigating the Sound selection window
;=================================================================================
; Old Version
;+ScrollLock::   ;;;; Shift + ScrollLock - Switch Audio Device to one of the 2 monitors
;    toggle:=!toggle ;toggles up and down states. 
;    Run, mmsys.cpl 
;    WinWait,Sound ; Change "Sound" to the name of the window in your local language 
;    if toggle
;        ControlSend,SysListView321,{Down 3} ; This number selects the matching audio device in the list, change it accordingly 
;    Else
;        ControlSend,SysListView321,{Down 4} ; This number selects the matching audio device in the list, change it accordingly 
;    sleep 40
;    ControlClick,&Set Default,Sound,,,,na ; Change "&Set Default" to the name of the button in your local language 
;    sleep 40
;    ControlClick,OK,Sound,,,,na
;return
;---------------------------------------------------------------------------------
;================================================================================= - End Change Audio Hotkeys
;=================================================================================
; Edit Program Volume Levels
;=================================================================================
; Adjust Minimum Volume Level using Ctrl+MouseWheel Up/Down
;====================================================
;;Volume Up
;#!^WheelUp:: 
;    VolWasChanged = True
;    if (CustGameVol < .10)
;        CustGameVol := CustGameVol + .01
;    else
;        CustGameVol := CustGameVol + .05
;    if CustGameVol > 1.00
;        CustGameVol := 1.00
;    Progress, by75 n%CustGameVolDisplay% p%CustGameVolDisplay%, Lower Volume Set to: %CustGameVolDisplay%, Volume: %CurrentVolDisplay%`%
;    CustGameVolDisplay := Round((CustGameVol * 100), 0)
;    run nircmd.exe setappvolume focused %CustGameVol%
;    SetTimer, PUBGVolTimer, -1000
;return 
;;Volume Down
;#!^WheelDown:: 
;    if (CustGameVol < .10)
;        CustGameVol := CustGameVol - .01
;    else
;        CustGameVol := CustGameVol - .05
;    VolWasChanged = True
;    if (CustGameVol < 0)
;        CustGameVol = .01
;    CustGameVolDisplay := Round((CustGameVol * 100), 0)
;    Progress, by75 n%CustGameVolDisplay% p%CustGameVolDisplay%, Lower Volume Set to: %CustGameVolDisplay%, Volume: %CurrentVolDisplay%`%
;    run nircmd.exe setappvolume focused %CustGameVol%
;    SetTimer, PUBGVolTimer, -1000
;return 
;
;
;; Set Volume to Custom, or Max
;;====================================================
;WheelLeft::        ;ScrollWheelRight         
;    Progress, by75 p%CustGameVol%, Volume Set to: %CustGameVol%`%
;    run nircmd.exe setappvolume focused %CustGameVol%
;    SetTimer, PUBGVolTimer, -1600
;return
;
;WheelRight::    ;ScrollWheelRight             
;    Progress, by75 p100,  Volume Set to: 100`%
;    run nircmd.exe setappvolume focused 1
;    SetTimer, PUBGVolTimer, -1600
;return




;=================================================================================
; Dim Screen - For use with Flux. 
;     Raise brightness all the way, then decrease to just before red.
;=================================================================================
>!>^>+d::
    ThisText=Dimming the Screen
    TrayTip, AHK - F.lux (Dimming), %ThisText%,, 1
    HideTrayTip()
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
return

>!>#>^>+d::
    Send {Alt Down}
    SendInput {PgUp 20}
    Send {Alt Up}
    Sleep 100
    Send {Alt Down}
    Send {End}
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
    if rainmetertoggle =
    {
        msgbox, 0, Toggle Rainmeter Layouts,No Audio Visualizers, .8
        Run, C:\Program Files\Rainmeter\Rainmeter.exe !LoadLayout "Win 10 Tri Screen all 1080 - Gaming noVA"
        rainmetertoggle=0
        return
    }
    rainmetertoggle:=!rainmetertoggle
    if rainmetertoggle
    {
        Run, C:\Program Files\Rainmeter\Rainmeter.exe !LoadLayout "Win 10 Tri Screen all 1080 - Gaming"
        rainmetertoggle = 1
        msgbox, 0, Toggle Rainmeter Layouts,Taskbar Audio Visualizers, .8
    }
    else
    {
        Run, C:\Program Files\Rainmeter\Rainmeter.exe !LoadLayout "Win 10 Tri Screen all 1080 - VATree"
        rainmetertoggle=
        msgbox, 0, Toggle Rainmeter Layouts,Desktop Audio Visualizers, .8
    }

;    if rainmetertoggle AND !rainmetertoggletwo
;    {
;        msgbox, rainmeter1
;    }
;    elseif rainmetertoggle && !rainmetertoggletwo
;    {
;        msgbox, rainmeter2
;        rainmetertoggletwo!=rainmetertoggletwo
;    }
;    elseif !rainmetertoggle AND !rainmetertoggletwo
;    {
;        msgbox, rainmeter3
;    }

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
    ;    WinGetTitle, title, A
    ;    WinGetClass, class, A
    ;    WinGet, process, ProcessName,A
    ;    
    ;    GuiControl,, WindowTitle, 
    ;    GuiControl,, WindowClass, 
    ;    GuiControl,, WindowProcess, 
    ;}

    ;MsgBox, The active window's class is "%class%".
return
;-----------------------------------------------------------------------------------------------------

; Gaming
;=====================================================================================================
!#^g:: 
	IfWinActive, PLAYERUNKNOWN'S BATTLEGROUNDS 
	{
	    IfWinNotExist, PUBG nircmd Audio Toggle.ahk
	        GameExe="C:\Dropbox\AHK Scripts\Gaming Scripts\PUBG nircmd Audio Toggle.ahk"
	        run, %GameExe%
	}

	IfWinActive, RocketLeague.exe
	{
	    GameExe="C:\Dropbox\AHK Scripts\Gaming Scripts\Rocket League Hotkeys.exe"
	    run, %GameExe%
	}
return

; Rocket League
;=====================================================
; 2 Player Full screen - Side by side. 
#IfWinActive, Rocket League ahk_exe RocketLeague.exe
    WheelRight::    ;ScrollWheelRight
	    rlrmtoggle:=!rlrmtoggle 
	    if rlrmtoggle
	        WinMove, A,, 0, 0, 3840, 1080
	    else
	        WinMove, A,, 0, 0, 1920, 1080
	    return
	    WheelLeft::    ;ScrollWheelRight
	        rllmtoggle:=!rllmtoggle 
	        if rllmtoggle
	        {
	            WinMove, A,, -1920, 0, 3840, 1080
	            sleep 500
	            WinMove, A,, -1920,,,
	        }
	        else
	            WinMove, A,, 0, 0, 1920, 1080
    return
#If
return

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
; Testing   (Mostly old garbage)
; ----------------------------------------------------------------------------------------------------



;^Up::
;    ;Gui, Add, Text, hi
;    ;Gui, Show
;
;        ProjectMonitor(4)
;
;Return




;^!#Numpad1::
;    WinMove, A,, 0, 0, 1920, 1080
;return
;^!#Numpad2::
;    WinMove, A,, 1920, 0, 1920, 1080
;return
;^!#Numpad3::
;    WinMove, A,, -1920, 0, 1920, 1080
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
;    Progress, %ProBar%, %Mins%:%Secs%:%MilSec%, Screen Locked
;    if (Probar mod 19230 = 0)
;        Mins := Mins + 1
;    if ( ProBar = 3600 )
;    {
;        Progress, Off
;        return
;    }
;    Sleep 15.6
;    ProBar := ProBar + 1
;    if (mod(ProBar, 64) = 0)
;        Secs := Secs + 1
;
;    MilSec := Milsec + 15.6
;    MilSec := Round(Mod(MilSec, 1000))
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
;    Gui, New,, Audio Splash Gui
;    Gui, -MaximizeBox -MinimizeBox -SysMenu -Border
;    Gui, Margin, 0, 0
;    Gui, Color, 000000
;
;
;
;    WinSet, TransColor, 000000 150, Audio Splash Gui
;
;    Gui, Add, Picture,, C:\Dropbox\AHK Scripts\SplashImages\Audio Selected Stereo transparent 3d.png
;    Gui, Show    
;    WinSet, Style, -0xC00000, Audio Splash Gui
;    WinSet, TransColor, 000000 150, Audio Splash Gui
;    WinSet, AlwaysOnTop, On, Audio Splash Gui
;    WinSet, ExStyle, +0x20, Audio Splash Gui
;    Sleep 1800
;    Gui, Destroy
;
;
;return
;
