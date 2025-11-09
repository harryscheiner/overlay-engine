; Get the offset of a particular axis to simulate Coordmode "Client" with GUI
getWindowOffset(axis) {
  if (axis = "x") {
    SysGet, xborder, 32
    return xborder
  } else if (axis = "y") {
    SysGet, yborder, 33
    SysGet, titlebar, 4
    return yborder + titlebar
  }
}

getClientSize(hWnd, ByRef w := "", ByRef h := "") {
  VarSetCapacity(rect, 16)
  DllCall("GetClientRect", "ptr", hWnd, "ptr", &rect)
  w := NumGet(rect, 8, "int")
  h := NumGet(rect, 12, "int")
}

logDebug(text) {
  FormatTime, vDate,, yyyy-MM-dd hh-mm-ss tt ;12-hour
  File := FileOpen("debug.log", "a")
  File.Write(vDate " - " text "`r`n")
}

logDebugToWindow(text, line := 1) {
  GuiControl,, % "DebugLine" line, % text
}