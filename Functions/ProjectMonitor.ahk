;=====================================================================================================
;		README		README		README		README		README		README		README		README
;=====================================================================================================
	; Pass in one of 3 options to change the current Projection mode (You'll figure it out below)
	;
	; Hits Win+P and uses the Home, End, Arrow Keys and Enter to select the appropriate layout.
;=====================================================================================================
;=====================================================================================================

ProjectMonitor(Screen)
{
	if (Screen != "primaryscreen" && Screen != "primarymonitor" && Screen != "1" && Screen != "duplicatescreens" && Screen != "duplicate" && Screen != "2" && Screen != "extendscreens" && Screen != "extendmonitors" && Screen != "3" && Screen != "secondscreen" && Screen != "secondscreenonly" && Screen != "4")
	{
		Msgbox, 0, ERROR: ProjectMonitor(Screen), Invalid argument for Screen`nScreen: %Screen%`n`nValid arguments are:`nprimaryscreen`nprimarymonitor`n1`nduplicatescreens`nduplicate`n2`nextendscreens`nextendmonitors`n3`nsecondscreen`nsecondscreenonly`n4`n
		Return 1
	}

	CoordMode, Mouse, Window
	WinGet, OldFocusedWindow, ID, A
	BlockInput, On
	Send #p
	loop
	{
		WinActivate, ShellExperienceHost.exe,, 5
		IfWinActive Project
		{
			Sleep 1100
			WinActivate, ShellExperienceHost.exe,, 5
			if(screen == "primaryscreen" || screen == "primarymonitor" || screen == "1")
			{
				WinActivate, ShellExperienceHost.exe,, 5
				Send {Home}
				Send {Enter}
			}
			else if(screen == "duplicatescreens" || screen == "duplicate" || screen == "2")
			{
				WinActivate, ShellExperienceHost.exe,, 5
				Send {Home}
				Send {Down} 
				Send {Enter}
			}
			else if(screen == "extendscreens" || screen == "extendmonitors" || screen == "3")
			{
				WinActivate, ShellExperienceHost.exe,, 5
				Send {End}
				Send {Up} 
				Send {Enter}
			}
			else if(screen == "secondscreen" || screen == "secondscreenonly" || screen == "4")
			{
				WinActivate, ShellExperienceHost.exe,, 5
				Send {End}
				Send {Enter}
			}
			Sleep 150
			Send {esc}
			BlockInput, Off
			BlockInput, MouseMoveOff
			Break
		}
		Sleep 50
	}
	Sleep 1200
	WinActivate, ahk_id %OldFocusedWindow%
}

;For Testing Purposes
;!#^p::
;	togglepro:=!togglepro
;	if togglepro
;		ProjectMonitor(1)
;	else
;		ProjectMonitor(3)
;return