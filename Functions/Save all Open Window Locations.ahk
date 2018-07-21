; Save all Open Window Locations
; This file has 3 functions:
; * SaveAllWindowLocations(NameOfLayout) - Save the location of all open windows 
; * LoadAllWindowLocations(NameOfLayout) - 
; * WindowLocationGui()

SaveAllWindowLocations(LayoutType:="")
{
	;msgbox, layout type: %LayoutType%
	DetectHiddenwindows, Off
	IfExist, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini
	{
		;Msgbox, Deleting File: %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini
		FileDelete, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini
		;Msgbox, Deleted
		Sleep 250
	}

	;Msgbox, Saving info to folder: %tempFolder%\Window Locations`nFile: %LayoutType%WindowLocations.ini

	WinGet, AllWindowsList, List, 
	
	ProBar := 0
	Progress, 0 y0 b h75, Window Saver, Saving Window Locations
		WinSet, AlwaysOnTop, On, %A_ScriptName%			; Make Progress Bar Always On Top
		WinSet, ExStyle, +0x20, %A_ScriptName%			; Make Progress Bar Click Threw-ible
		WinSet, TransColor, 000000 150, %A_ScriptName%	; Make Progress Bar Semi-Transparent

	numofwin := 0
	;MsgBox, 0, Saving Window Locations, Num Windows: %AllWindowsList%, .5
	loop % AllWindowsList
	{
		this_id := AllWindowsList%A_Index%
   		WinGetTitle, this_title, ahk_id %this_id%
   		win_title:=this_title
   		WinGet, win_ID, ID, %this_title%
   		WinGet, this_exe, ProcessName, ahk_id %this_id%
		if InStr(this_title, " - Outlook")
			this_title:="Outlook"
		if InStr(this_exe, "vivaldi.exe")
			this_title:="vivaldi"

		;MsgBox, Title: %this_title%`nWinID: %this_id%
		If this_title !=
		{
			WinGetPos, winX, winY, winWidth, winHeight, %win_title%
			WinGet, isMax, MinMax, %win_title%

			this_title := StrReplace(this_title, "[", "``(")
			this_title := StrReplace(this_title, "]", "``)")
			IniWrite, %A_Index% - %this_title%, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, All Open Windows, WinNum %numofwin%

			;Msgbox, title: %this_title%

			UpdateProgress(ProBar, 10, "Window Saver", this_title)

			;If (winX = "-32000") 
			;	continue
			;If (winY = "-32000") 
			;	continue


			IniWrite, %winX%, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %A_Index% - %this_title%, winX
			IniWrite, %winY%, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %A_Index% - %this_title%, winY

			IniWrite, %win_ID%, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %A_Index% - %this_title%, win_ID

			if winWidth < 10
				IniWrite, 300, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %A_Index% - %this_title%, winWidth
			else	
				IniWrite, %winWidth%, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %A_Index% - %this_title%, winWidth
			if winHeight < 10
				IniWrite, 225, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %A_Index% - %this_title%, winHeight
			else
				IniWrite, %winHeight%, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %A_Index% - %this_title%, winHeight
			if isMax = 1
				IniWrite, TRUE, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %A_Index% - %this_title%, isMax
			else
				IniWrite, FALSE, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %A_Index% - %this_title%, isMax

			numofwin++
			;Msgbox, Title: %this_title%`nWinMove, A,, %winX%, %winY%, %winWidth%, %winHeight%`nisMax:%isMax%
			Sleep 5
		}
	}
	Progress, 100, Saving Window Locations, FINISHED
	IniWrite, %numofwin%, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, All Open Windows, Total Windows
	;MsgBox, 0, Saving Window Locations, Done - Saved %numofwin% Windows, .9
	DetectHiddenwindows, ON	
	SetTimer, SaveWindowsTurnOffProgress, -1600
}

RestoreAllWindowLocations(LayoutType:="")
{
	;msgbox, layout type: %LayoutType%
	
	SetWinDelay, -1					; Set Delay between window actions to non-existant
	ProBar := 0
	Progress, 0 y0 b, Window Restorer, Moving Windows to their Saved Locations
		WinSet, AlwaysOnTop, On, %A_ScriptName%			; Make Progress Bar Always On Top
		WinSet, ExStyle, +0x20, %A_ScriptName%			; Make Progress Bar Click Threw-ible
		WinSet, TransColor, 000000 150, %A_ScriptName%	; Make Progress Bar Semi-Transparent

	IniRead, numWindows, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, All Open Windows, Total Windows
	;MsgBox, 0, Arranging Saved Windows, Starting Process - %numWindows% windows to move, .9
	numWindowsLeft:=numWindows
	loop % numWindows
	{
		Moved = False
		IniRead, curWindow, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, All Open Windows, WinNum %numWindowsLeft%
		if curWinow = "6 - Outlook"
			msgbox, yes
		IniRead, win_ID, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %curWindow%, win_ID

		curWindowone := StrReplace(curWindow, "``(", "[")
		curWindowone := StrReplace(curWindowone, "``)", "]")
		;msgbox, %curWindowone%
		curWindowone := RegExReplace(curWindowone, "[0-9]* - ", "")
		;msgbox, %curWindowone%

			UpdateProgress(ProBar, numWindows/100, "Window Restorer", curWindow)
		numWindowsLeft:=numWindowsLeft-1
		curIndex:=A_Index-1
		WinGet, WinID, ID, %curWindowone%
		IfWinNotExist ahk_id %WinID%
		{
			IfWinExist ahk_id %win_ID%
			{
			;	Msgbox, Definitely exists
				WinID:=win_ID
			}
			else
			{
				;Msgbox, Title: %curWindowone%`nID: %WinID%`nIndex: %curIndex% of %numWindows%`nnot found
				continue
			}
		}
		if (curWindowone = Microsoft Store) OR (curWindowone = Windows Shell Experience Host) OR (curWindowone = Program Manager)
			continue

		IniRead, winX, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %curWindow%, winX
		IniRead, winY, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %curWindow%, winY
		IniRead, winWidth, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %curWindow%, winWidth
		IniRead, winHeight, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %curWindow%, winHeight
		IniRead, isMax, %tempFolder%\Window Locations\%LayoutType%WindowLocations.ini, %curWindow%, isMax

		WinGet, isCurrentlyMax, MinMax, ahk_id %WinID%

		;Msgbox, Title: %curWindow%`nWinMove, A, %winX%, %winY%, %winWidth%, %winHeight%, .6

		if (winX == ERROR) OR (winY == ERROR) OR (winWidth == ERROR) OR (winHeight == ERROR) OR (isMax == ERROR)
		{
			Msgbox, IT ERRED`nTitle: %curWindow%`nWinMove, A,, %winX%, %winY%, %winWidth%, %winHeight%`nisMax:%isMax%
			Continue
		}
		if (winX > -10000) AND (winY > -10000)
		{
			;Msgbox, winxAndwinY are not -32000`nwinX: %winX%`nwinY: %winY%
			;Msgbox, Not -32000`nTitle: %curWindow%`nWinMove, A,, %winX%, %winY%, %winWidth%, %winHeight%`nisMax:%isMax%`nCurrnetisMax: %isCurrentlyMax%
			if (isCurrentlyMax == -1)
			{
				;MsgBox, Restoring window from Taskbar
				WinRestore, ahk_id %WinID%
			}
			if isMax = TRUE
			{
				WinMove, ahk_id %WinID%,, %winX%, %winY%, %winWidth%-100, %winHeight%-100
				WinMove, ahk_id %WinID%,, %winX%+15, %winY%+15, %winWidth%-125, %winHeight%-125
				Sleep 25
				PostMessage, 0x112, 0xF030,,, ahk_id %WinID%,  
			}	
			else
				WinMove, ahk_id %WinID%,, %winX%, %winY%, %winWidth%, %winHeight%
			Moved = True
		}
		else if winX = -32000 AND winY = -32000
		{
			Msgbox, IT IS -32000`nTitle: %curWindow%`nWinMove, A,, %winX%, %winY%, %winWidth%, %winHeight%`nisMax:%isMax%`nCurrnetisMax: %isCurrentlyMax%
			if isMax != 1
			{
				Msgbox, It's not minimized, LETS DO IT
				WinMinimize, ahk_id %WinID%
				Moved = True
			}
		}
		if Moved = True
		{
			;Msgbox, Moved = True
			Sleep 50
		}
	}
	Progress, 100, FINISHED, Window Restorer
	;MsgBox, 0, Arranging Saved Windows, Done Moving Everything, .9
	SetTimer, SaveWindowsTurnOffProgress, -1600
}

SaveWindowsTurnOffProgress:
	Progress, Off
Return

UpdateProgress(ByRef ProBar, incr, title, text)
{
	ProBar += incr
	Progress, %ProBar%, %text%, %title%
}


;WindowLocationGui()
;{
;	Gui, Layouts:New, AlwaysOnTop 
;	Gui, Layouts:Font, s12
;	Gui, Layouts:Add, Text,, Save/Load Window Configurations
;	Gui, Layouts:Font, s8
;	Gui, Layouts:Add, Button, x5 y+10 gLoadLayout v1Default, Load &Default
;	Gui, Layouts:Font, s10
;	Gui, Layouts:Add, Text, x+5 yp+2, -  Default Configuration
;	Gui, Layouts:Font, s8
;	Gui, Layouts:Add, Button, x5 y+10 gLoadLayout v1Work Default, Load &Work
;	Gui, Layouts:Font, s10
;	Gui, Layouts:Add, Text, x+5 yp+2, -  Work (Default)
;	Gui, Layouts:Font, s12
;	Gui, Layouts:Add, Text, y+5,
;	Gui, Layouts:Add, Text, y+5, Custom Configs
;	loop, Files, %tempFolder%\Window Locations\*.ini
;	{
;		LocFileName := StrReplace(A_LoopFileName, "WindowLocations.ini", "")
;		LocFileName := StrReplace(LocFileName, "-")
;		LocFileName := StrReplace(LocFileName, " ")
;		if (LocfileName != "Default") AND (LocfileName != "Work")
;		{
;			button%A_Index% := LocfileName
;			Gui, Layouts:Font, s8
;			Gui, Layouts:Add, Button, % "x5 y+10 gLoadLayout v" A_Index LocfileName, Load
;			Gui, Layouts:Font, s10
;			Gui, Layouts:Add, Text, x+5 yp+2, -  %LocfileName%
;			Gui, Layouts:Font, s8
;			Gui, Layouts:Add, Button, % "x215 yp-2 gDeleteLayout vdelete" A_Index LocfileName, ;Delete
;		}
;	}
;	Gui, Layouts:Font, s8
;	Gui, Layouts:Add, Text, y+5,
;	Gui, Layouts:Add, Button, x5 y+10 gLayoutSaveLayout, &Save Custom Layout
;	Gui, Layouts:Add, Button, xp+25 y+5 w50 gLayoutCancel, Cancel
;	GuiControl, Choose, ControlID, 1
;	Gui, Show, y300
;return
;}
;
;;Gui Button Controls
;GuiEscape:
;LayoutsGuiEscape:
;	Gui, Layouts:Destroy
;return
;LayoutCancel:
;	Gui, Layouts:Destroy
;Return
;
;LoadLayout:
;	layout := A_GuiControl
;	layout := SubStr(layout, 2)
;	Gui, Layouts:Destroy
;	;Msgbox, guiControl- %layout%
;	RestoreAllWindowLocations(layout)
;return
;DeleteLayout:
;	layout := A_GuiControl
;	Gui, Layouts:Destroy
;	;Msgbox, Deleting Layout: %layout%
;	IfExist, %tempFolder%\Window Locations\%layout%WindowLocations.ini
;	{
;		FileDelete, %tempFolder%\Window Locations\%layout%WindowLocations.ini
;		msgbox, deleted file
;	}
;return
;LoadWorkLayout:
;	Gui, Layouts:Destroy
;	RestoreAllWindowLocations("Work")
;return
;LoadDefaultLayout:
;	Gui, Layouts:Destroy
;	RestoreAllWindowLocations()
;return
;LayoutSaveLayout:	
;	Gui, Layouts:Destroy
;
;	InputBox, Layout, Save/Load Desktop Window Locations, Save Layout as:,,200,125,,250,,20,
;	Layout := StrReplace(Layout, "-",,numOfMinus)
;	Layout := StrReplace(Layout, " ",,numOfSpace)
;	If ErrorLevel
;		Return
;	SaveAllWindowLocations(Layout)
;Return