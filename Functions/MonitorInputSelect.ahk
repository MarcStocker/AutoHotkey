;==========================================================================================
; Set Script #Directives and Defaults
;==========================================================================================
	#Persistent
	#SingleInstance Force
	#NoEnv  		; Recommended for performance and compatibility with future AutoHotkey releases.
	SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
	BlockInput, Off ; In case there was an issue and the mouse is locked out; Finds monitor handle based on point
;==========================================================================================
;==========================================================================================

; NOTE: Use "ControlMyMonitor.exe" by NirSoft to see if you monitor even supports this.
;       If your monitor does not have the VPC Code '60' (Input Select)... then this won't work. Period. I've tried.
;       Just throw out your monitor now, and get a new one that actually supports Input Select over DDC/CI. 
;
;       If this does work for you, use the Ctrl+Win+Alt+0 key binding to identify each monitor.
;       It will copy the Monitor_Handle into your clipboard, and will use your mouse to identify which monitor.
;       Create a global variable using this value, like I did below with leftMon, centMon, and rightMon. 
;       Then just replace the monitor variables I used in the calls in the hotkey section and you're good to go. 

; Set Monitors Handles, and Input Select Num Equivients in the 2 following functions: getHMontior(), and getInputSourceFromName()
; Then switch inputs like so:
;;;  if(getMonitorInputSource("leftMon") == "hdmi"){
;;;    setMonitorInputSource("leftMon", "dp")
;;;  }
;;;  else {
;;;    setMonitorInputSource("leftMon", "hdmi")
;;;  }

getHMonitor(inputNum) 
{
  displayInputs := {"leftMon": 775292539, "centMon": 52366489, "rightMon": 257165421}
  hMonitor := displayInputs[inputNum]
  ;msgbox % "returnMonitor: " hMonitor "`ninputNum: " inputNum
  return hMonitor
}

getInputSourceFromName(inputName) 
{
  displayTypes := {"auto": "0", "dp": "15", "mdp": "16", "hdmi": "17"}
  source := displayTypes[inputName]
  ;msgbox % "returnSrcNum: " source "`ninputNum: " inputNum
  return source
}
getInputSourceFromNum(inputNum) 
{
  displayTypeNums := {0: "auto", 15: "dp", 16: "mdp", 17
  : "hdmi"}
  source := displayTypeNums[inputNum]
  ;msgbox % "returnSrcName: " source "`ninputNum: " inputNum
  return source
}

getMonitorHandle(monitor:="leftMon")
{
  point := getHMonitor(monitor)
  VarSetCapacity(Physical_Monitor, 8 + 256, 0)
  ;msgbox % "----getHandle----`n`nMonitor: " monitor "`nPoint: " point

  DllCall("dxva2\GetPhysicalMonitorsFromHMONITOR"
    , "int64", point   ; monitor handle
    , "uint", 1   ; monitor array size
    , "int", &Physical_Monitor)   ; point to array with monitor
  
  ;msgbox % "Point: " point "`nPhysical Monitor: " Physical_Monitor
  return hPhysMon := NumGet(Physical_Monitor)
}

destroyMonitorHandle(handle)
{
  DllCall("dxva2\DestroyPhysicalMonitor", "int", handle)
}

; Used to change the monitor source
setMonitorInputSource(monitor, source)
{
  themonitor := getHMonitor(monitor)
  thesource := getInputSourceFromName(source)
  handle := getMonitorHandle(monitor)
  ;msgbox % "--Set Input--`nREFERENCES`n`nMonitor: " monitor "`nSource: " source "`nThe Monitor: " themonitor "`nThe Source: " thesource
  ;msgbox % "--Set Input--`nREFERENCES`n`nHandle: " handle "`nThe Source: " thesource
  ;msgbox % "GetMons Handle: '" handle "'"
  ;handle := NumGet(1)
  sSource := displayInputs[source]
  DllCall("dxva2\SetVCPFeature"
    , "int", handle
    , "char", 0x60 ;VCP code for Input Source Select
    , "uint", thesource)
  destroyMonitorHandle(handle)
}

; Gets Monitor source
getMonitorInputSource(monitor)
{
  ;monitor := getHMonitor(monitor)
  handle := getMonitorHandle(monitor)
  ;handle := NumGet(1)
  DllCall("dxva2\GetVCPFeatureAndVCPFeatureReply"
    , "int", handle
    , "char", 0x60 ;VCP code for Input Source Select
    , "Ptr", 0
    , "uint*", currentValue
    , "uint*", maximumValue)
  destroyMonitorHandle(handle)

  ; For some reason 'currentValue' is returning an "incorrect" very large value
  ; ... but it's different for each monitor (－‸ლ) 
  ; So it needs to be reduced so we can get the actual current value we want.
  ; I got these values because "ControlMyMonitor.exe" 
  ;  told me the value should be 17, not 4369. And 15, not 4367. You'll figure it out. 
  if (monitor == "leftMon")
    currentValue:=currentValue-4352
  if (monitor == "rightMon")
    currentValue:=currentValue-3840
  
  currentValue := getInputSourceFromNum(currentValue)
  ;msgbox % "Monitor: " Monitor "`nHandle: " handle "`n`nMonitor Currently Set to: " currentValue " -- Out of: " maximumValue
  return currentValue
}


GetMonitorHandleWindow(windowTitle)
{
    ; Get the window handle
    hWnd := WinExist(windowTitle)
    if (!hWnd)
    {
        ;msgbox, Window not found!
        return
    }

    ; Load user32.dll library
    hUser32 := DllCall("LoadLibrary", "Str", "user32.dll")

    ; Call MonitorFromWindow function
    hMonitor := DllCall("MonitorFromWindow", "Ptr", hWnd, "UInt", 2) ; MONITOR_DEFAULTTONEAREST

    ; Free the user32.dll library
    DllCall("FreeLibrary", "Ptr", hUser32)
    
    Clipboard := hMonitor 
    ;msgbox % "Window Based `nMonitor Handle: " hMonitor
    return hMonitor
}

GetMonitortHandleMouse()
{
  MouseGetPos, mouseX, mouseY

  ; Combine the X and Y coordinates into a 64-bit integer
  point := (mouseX & 0xFFFFFFFF) | ((mouseY & 0xFFFFFFFF) << 32)
  
  ; Call MonitorFromPoint and store the return value in monitorHandle
  hMonitor := DllCall("MonitorFromPoint"
      , "int64", point
      , "uint", 1)
  
  Clipboard := hMonitor 
  ;msgbox % "Mouse Based `nMonitor Handle: " . hMonitor
}

; Example usage
;; Switching sources~
;!$#^1:: ; All Monitors
;  if(getMonitorInputSource(leftMon) == hdmi){
;    setMonitorInputSource(leftMon, dp)
;  }
;  else {
;    setMonitorInputSource(leftMon, hdmi)
;  }
;  if(getMonitorInputSource(rightMon) == dp){
;    setMonitorInputSource(rightMon, hdmi)
;  }
;  else {
;    setMonitorInputSource(rightMon, dp)
;  }
;return
;!$#^2:: ; Far Left Monitor
;  if(getMonitorInputSource(leftMon) == hdmi){
;    setMonitorInputSource(leftMon, dp)
;  }
;  else {
;    setMonitorInputSource(leftMon, hdmi)
;  }
;return
;!$#^3:: ; Far Right Monitor
;  if(getMonitorInputSource(rightMon) == dp){
;    setMonitorInputSource(rightMon, hdmi)
;  }
;  else {
;    setMonitorInputSource(rightMon, dp)
;  }
;return
;!$#^9:: ; Far Right Monitor
;  if(getMonitorInputSource(centMon) == dp){
;    setMonitorInputSource(centMon, hdmi)
;  }
;  else {
;    setMonitorInputSource(centMon, dp)
;  }
;return
;!$#^0::
;  windowTitle := "Untitled - Notepad"
;  GetMonitorHandleWindow(windowTitle)
;
;  GetMonitortHandleMouse()
;return
