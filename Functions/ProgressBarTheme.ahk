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

ProgressBarThemed(yCoord:=75, bGroundColor:=212121, textColor:="DAE6EA", mainText:="", subText:="")
{
    Progress, b y%yCoord% zy00 zx5 wm700 ws800 fm8 cw%bGroundColor% ct%textColor%, %subText%, %mainText%
    WinSet, TransColor, E6E6E6 120, %A_ScriptName%	; Make Progress Bar Semi-Transparent
    WinSet, AlwaysOnTop, On, %A_ScriptName%			; Make Progress Bar Always On Top
    WinSet, ExStyle, +0x20, %A_ScriptName%			; Make Progress Bar Click Threw-ible
}

applyProgressBarTheme()
{
    WinSet, TransColor, E6E6E6 120, %A_ScriptName%	; Make Progress Bar Semi-Transparent
    WinSet, AlwaysOnTop, On, %A_ScriptName%			; Make Progress Bar Always On Top
    WinSet, ExStyle, +0x20, %A_ScriptName%			; Make Progress Bar Click Threw-ible
}