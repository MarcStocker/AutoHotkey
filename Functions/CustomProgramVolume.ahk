;==============================================================================================================
;==============================================================================================================
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Must have nirCMD installed !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; Download Link: https://www.nirsoft.net/utils/nircmd-x64.zip
; Run as Administrator, then click the "Copy to Path" button.
;==============================================================================================================
;==============================================================================================================

;=================================================================================
; Uncommment lines 18-37 to use this script in standalone mode (Just run it and it'll work)
; Or remove the ';' and add the next line to your AHK master script (Before any occurances of a 'return') then call the functions
	;#include C:\<FILE LOCATION>\CustomProgramVolume.ahk
;=================================================================================
; Don't forget to run nirCMD as Admin, and "Copy to Windows Directoy" before using script
;=================================================================================
; Adjust Custom Volume Level using Ctrl+MouseWheel Up/Down
;====================================================
;;Volume Up --- Ctrl+Win+Alt+MouseWheelUp
;#!^WheelUp::          
;	ChangeCurProgramVolume("Up")
;return 
;;Volume Down --- Ctrl+Win+Alt+MouseWheelDown
;#!^WheelDown::       
;	ChangeCurProgramVolume("Down")
;return 
;;Volume Max --- Ctrl+Win+Alt+MouseWheelRight
;#!^WheelRight::    
;	SetCurProgramMaxVolume()
;Return
;; Custom Set Volume --- Ctrl+Win+Alt+MouseWheelLeft
;#!^WheelLeft::
;	SetCurProgramLastCustomVolume()
;Return
;; Mute (Set to 0%)  --- Ctrl+Win+Alt+MiddleClick
;#!^MButton::	
;	SetCurProgramVolumeMute()
;Return

;========================================
; Increase/Descrease Volume in Steps
;========================================
ChangeCurProgramVolume(UpOrDown:="Up")
{
    WinGet, curProgram, ProcessName, a
    ; IniRead, OutputVar, Filename, Section, Key [, Default] 
	IniRead, CurVolume, %tempFolder%\Application Custom Audio Levels\CustomAudioPerProgram.ini, %curProgram%, Current Volume, NoCustomVol
    ;==============================================================================================================================================
    If (CurVolume == "NoCustomVol")  ; Set Current Volume to a default if none currently exists (.45 + .05 = 50%)
        CurVolume := 0.45
    ;==============================================================================================================================================
    ; Increase/Decrease Current Volume
    ;==============================================================================================================================================
    If (UpOrDown == "Up")
        UpOrDown:=1
    else ;if (UpOrDown == Down)
        UpOrDown:=-1
	If (CurVolume <= .099)
		CurVolume := CurVolume + (.01 * UpOrDown)
    else if (CurVolume = .10)
    {
        if (UpOrDown == -1)
		    CurVolume := CurVolume + (.01 * UpOrDown)   
        else 
		    CurVolume := CurVolume + (.05 * UpOrDown)   
    }
	else
		CurVolume := CurVolume + (.05 * UpOrDown)
	if CurVolume >= 1.00
		CurVolume := 1.00
	else if (CurVolume <= 0.00)
		CurVolume = 0.00
    ;==============================================================================================================================================
	IniWrite, %CurVolume%, %tempFolder%\Application Custom Audio Levels\CustomAudioPerProgram.ini, %curProgram%, Last Custom Volume
    SetCurProgramVolumeTo(curProgram, CurVolume)
}

;========================================
; Set Volume to last "Custom Value" (Used for Mute and Max Volume)
;========================================
SetCurProgramLastCustomVolume()
{ 
    WinGet, curProgram, ProcessName, a
    ;==============================================================================================================================================
	IniRead, LastCustProgramVol, %tempFolder%\Application Custom Audio Levels\CustomAudioPerProgram.ini, %curProgram%, Last Custom Volume, NoCustomVol
    If (LastCustProgramVol == "NoCustomVol")
        LastCustProgramVol := .45
    ;==============================================================================================================================================
    SetCurProgramVolumeTo(curProgram, LastCustProgramVol)
}

;========================================
; Set Max Volume
;========================================
SetCurProgramMaxVolume()
{
    WinGet, curProgram, ProcessName, a
    SetCurProgramVolumeTo(curProgram, 1.00)
}
;========================================
; Mute Volume (Set to Zero)
;========================================
SetCurProgramVolumeMute()
{
    WinGet, curProgram, ProcessName, a
    SetCurProgramVolumeTo(curProgram, 0.00)
}
;========================================
; Save Custom Volume Level for Program
;========================================
SaveCurProgramCustomVolumeLevel()
{
    WinGet, curProgram, ProcessName, a
    If (LastCustProgramVol == "NoCustomVol")
        Progress, by75 zy00 zx5 wm700 ws800 fm8 cw212121 ctDAE6EA, Please Set a Volume before Saving, FAILURE
    Else
    {
        IniWrite, %CurVolume%, %tempFolder%\Application Custom Audio Levels\CustomAudioPerProgram.ini, %curProgram%, Current Volume
        Progress, by75 zy00 zx5 wm700 ws800 fm8 cw212121 ctDAE6EA, Custom Default set to: %CurVolume%`%, %curProgram%`nCustom Default Volume Saved!
    }
    WinSet, TransColor, E6E6E6 120, %A_ScriptName%	; Make Progress Bar Semi-Transparent
    WinSet, AlwaysOnTop, On, %A_ScriptName%			; Make Progress Bar Always On Top
    WinSet, ExStyle, +0x20, %A_ScriptName%			; Make Progress Bar Click Threw-ible
}

;========================================
; Function --- Set Volume Program Volume, and Display it via Progress Bar
;========================================
SetCurProgramVolumeTo(curProgram, CurVolume:=10)
{
    CheckForNirCMD()
    ;=====================================================
    ; Set Volume for Current program via nirCMD
    ;=====================================================
    if (curProgram != "Discord.exe")
	    run nircmd.exe setappvolume %curProgram% %CurVolume%
    ;=====================================================
    ; Set Volume for All Discord Processes (Otherwise Voice Lobbies and Videos are not affected)
    ;=====================================================
    else
    {
        WinGet, DiscordPID, PID, ahk_exe Discord.exe
        ;Msgbox, "Discord, start loop"
        for process in ComObjGet("winmgmts:").ExecQuery("" . "Select * from Win32_Process where ParentProcessId=" . DiscordPID) 
        {
            processID := process.ProcessID
	        run nircmd.exe setappvolume /%processID% %CurVolume%
        }
    }
    ;=====================================================
    ; Save Current Volume for Program
    ;=====================================================
    IfNotExist, %tempFolder%\Application Custom Audio Levels\
        FileCreateDir, %tempFolder%\Application Custom Audio Levels\
    IniWrite, %CurVolume%, %tempFolder%\Application Custom Audio Levels\CustomAudioPerProgram.ini, %curProgram%, Current Volume
    ;=====================================================
    ; Display Current, and Saved Custom volumes in pop-up Progress Bar
    ;=====================================================
	IniRead, LastCustProgramVol, %tempFolder%\Application Custom Audio Levels\CustomAudioPerProgram.ini, %curProgram%, Last Custom Volume, NoCustomVol
    ;=====================================================
    CurVolume := Round((CurVolume * 100), 0)
	CustGameVolDisplay := Round((LastCustProgramVol * 100), 0)
    ; Progress, ProgressParam1 [, SubText, MainText, WinTitle, FontName]
    ; Yes       b  = Borderless
    ; 75        y  = Y-Coordinate
    ; CurVol    p  = Progress Bar Starting positon (Specify only a number to change it afterward)
    ; Default   cb = Progress Bar Color
    ; 5 pixels  zx = Margin Space on left/right sides of window
    ; 0/None    zy = Vertial Blank Space Between each Control
    ; 700(Bold) wm = Font Weight of MainText (0-1000)
    ; 800(Bold) ws = Font Weight of SubText (0-1000)
    ; 8pt       fm = Font Size of MainText 
    ; DarkGrey  cw = Background Color
    ; Whiteish  ct = Text Color
    If (ProgressBarAlreadyActive != "Active")
        Progress, by75 zy00 zx5 wm700 ws800 fm8 cw212121 ctDAE6EA, Current Volume %CurVolume%`%, %curProgram%`nDefault Volume: %CustGameVolDisplay%`%
    WinSet, TransColor, E6E6E6 120, %A_ScriptName%	; Make Progress Bar Semi-Transparent
    WinSet, AlwaysOnTop, On, %A_ScriptName%			; Make Progress Bar Always On Top
    WinSet, ExStyle, +0x20, %A_ScriptName%			; Make Progress Bar Click Threw-ible
    Progress, 99, Current Volume %CurVolume%`%, %curProgram%`nDefault Volume: %CustGameVolDisplay%`%    ; Helps to force Progress Bar to snap into position QUICKLY
	Progress, %CurVolume%, Current Volume %CurVolume%`%, %curProgram%`nDefault Volume: %CustGameVolDisplay%`%
    ;====================================================================================================================================
    ProgressBarAlreadyActive := "Active"
    ;====================================================================================================================================
	SetTimer, ChangeAudioLevelTimer, -1200
    
}


ChangeAudioLevelTimer:
{
    ProgressBarAlreadyActive := "NotActive"
	Progress, Off
    Return
}


;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;////////////////////////////////////
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;////////////////////////////////////
;test stuff
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;////////////////////////////////////
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;////////////////////////////////////

getProgramVolume()
{
    
	WinGet, curProgram, ProcessName, A
    msgbox,  Getting Volume Details for "%curProgram%"

	run C:\Users\Marc\Downloads\soundvolumeview-x64\SoundVolumeView.exe /GetPercent %curProgram% | echo %errorlevel%
    ;run echo %ErrorLevel%

    msgbox, %ErrorLevel%

}

CheckForNirCMD()
{
    
	; Check to see if NirCMD is installed
	IfNotExist, C:\Windows\nircmd.exe
	{
		msgbox, 51, NirCMD is not Installed!!!, NirCMD is not currently installed. Without it we cannot change the volume.`nIf you're unable to install NirCMD because you are not an Admin refer to the script for how to implement the non-NirCMD method.`n`nPress YES to download NirCMD to your DOWNLOADS folder.`nPress CANCEL to exit.

		IfMsgBox Yes
		{
			Msgbox, 1,, The file 'NirCMD.zip' will download to your 'DOWNLOADS' folder`nUnzip the file and run 'NirCMD.exe' AS ADMIN (Very Important).`n`nDO NOT FORGET TO RUN IT AS ADMIN. It will not work otherwise.
			IfMsgBox Cancel
				return
			ToolTip, Downloading NirCMD to: C:\Users\%A_USERNAME%\Downloads\`n`nDon't forget to run "NirCMD.exe" as ADMIN

			UrlDownloadToFile, https://www.nirsoft.net/utils/nircmd-x64.zip, C:\Users\%A_USERNAME%\Downloads\NirCMD.zip
			Sleep 1250
			Run, C:\Users\%A_USERNAME%\Downloads\
			Sleep 3000
			ToolTip
			Return
		}
		IfMsgBox No
		{
			Run, mmsys.cpl
			return
		}
		IfMsgbox Cancel
			return
	}
}
