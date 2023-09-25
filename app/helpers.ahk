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

logDebug(text) {
  FormatTime, vDate,, yyyy-MM-dd hh-mm-ss tt ;12-hour
  FileAppend, %vDate% - %text%`r`n, debug.log
}

logDebugToWindow(text, line := 1) {
  GuiControl,, % "DebugLine" line, % text
}