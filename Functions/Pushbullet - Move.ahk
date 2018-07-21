; Move to top of right monitor
; Default
AdjustPushbullet()
{
	WinGet, oldWindow, ID, A
	DetectHiddenwindows, ON		
	CoordMode, Mouse, Screen
	IfWinExist, Pushbullet Pro
		WinClose, Pushbullet Pro
	WinActivate, PBChat Notifications - Pushbullet ahk_exe pushbullet_client.exe,	
	#IfWinActive, PBChat Notifications - Pushbullet ahk_exe pushbullet_client.exe,
		DetectHiddenWindows, On
		WinGet, PBList, List, PBChat
		xCor := 1928
		yCor := 0
		loop, %PBList%
		{
			this_id := PBList%A_Index%
	   		WinGetTitle, this_title, ahk_id %this_id%
			WinActivate, %this_title%
			WinMove, %this_title%,, xCor, yCor+100,,
			SendInput {Esc}

			xCor += 90
		}
		
		CoordMode, Mouse, Screen

		Loop, 2
		{
			xCor := 1928
			Loop, %PBList%
			{
				this_id := PBList%A_Index%
		   		WinGetTitle, this_title, ahk_id %this_id%
				WinActivate, %this_title%
		   		WinGetPos,,,,winHeight, ahk_id %this_id%
		   		if winHeight > 90
					MouseClick, Left, xCor+40, yCor+40, 1, 1
				SendInput {Esc}
				WinMove, %this_title%,, xCor, yCor,,
				WinSet, ExStyle, +0x80, ahk_id %this_id%
				xCor += 90
			}
		}
		xCor := 1928
		BlockInput, MouseMove
		MouseGetPos, oldMouseX, oldMouseY
		Loop, %PBList%
		{
			this_id := PBList%A_Index%
	   		WinGetTitle, this_title, ahk_id %this_id%
	   		WinGetPos,,,,winHeight, ahk_id %this_id%
	   		if winHeight > 90
				MouseClick, Left, xCor+40, yCor+40, 1, 1
			SendInput {Esc}
			xCor += 90
		}
		MouseMove, oldMouseX, oldMouseY, 0
		BlockInput, MouseMoveOff
	#If
	WinActivate, ahk_id %oldWindow%
}

; Move to right side of Left Most Monitor
; Based off how many monitors there are
HideAdjustPushBullet()
{
	WinGet, oldWindow, ID, A
	DetectHiddenwindows, ON		
	CoordMode, Mouse, Screen
	IfWinExist, Pushbullet Pro
		WinClose, Pushbullet Pro
	WinActivate, PBChat Notifications - Pushbullet ahk_exe pushbullet_client.exe,	
	#IfWinActive, PBChat Notifications - Pushbullet ahk_exe pushbullet_client.exe,
		DetectHiddenWindows, On
		WinGet, PBList, List, PBChat
		SysGet, NumMonitors, MonitorCount
		if NumMonitors = 2
		{
			xCor := -1920
			yCor := 43
		}
		else if NumMonitors > 2
		{
			SysGet, Mon, Monitor, 1
			xCor := MonRight+20
			yCor := 534
		}
		loop, %PBList%
		{
			this_id := PBList%A_Index%
	   		WinGetTitle, this_title, ahk_id %this_id%
			WinActivate, %this_title%
			WinMove, %this_title%,, xCor, yCor,,
			Send {Esc}
			xCor += 90
		}
		
		CoordMode, Mouse, Screen
		Loop, 2
		{
			If NumMonitors = 2
			{
				xCor := -97
				yCor := 15
			}
			else if NumMonitors > 2
			{
				SysGet, Mon, Monitor, 1
				xCor := MonRight-((MonRight-MonLeft)*0.0536458333)
				yCor := MonTop
			}
			Loop, %PBList%
			{
				this_id := PBList%A_Index%
		   		WinGetTitle, this_title, ahk_id %this_id%
				WinActivate, %this_title%
		   		WinGetPos,,,,winHeight, ahk_id %this_id%
		   		if winHeight > 90
					MouseClick, Left, xCor+40, yCor+40, 1, 1
				Send {Esc}
				WinMove, %this_title%,, xCor, yCor,,
				WinSet, ExStyle, +0x80, ahk_id %this_id%
				yCor += 90
			}
		}
		If NumMonitors = 2
		{
			xCor := -97
			yCor := 15
		}
		else if NumMonitors > 2
		{
			SysGet, Mon, Monitor, 1
			xCor := -1183
			yCor := MonTop
		}
		BlockInput, MouseMove
		MouseGetPos, oldMouseX, oldMouseY
		Loop, %PBList%
		{
			this_id := PBList%A_Index%
	   		WinGetTitle, this_title, ahk_id %this_id%
	   		WinGetPos,,,,winHeight, ahk_id %this_id%
	   		if winHeight > 90
				MouseClick, Left, xCor+40, yCor+40, 1, 0
			Send {Esc}
			yCor += 90
		}
		MouseMove, oldMouseX, oldMouseY, 0
		BlockInput, MouseMoveOff
		Loop, %PBList%
		{
			Send {Esc}
		}
	#If
	WinActivate, ahk_id %oldWindow%
}