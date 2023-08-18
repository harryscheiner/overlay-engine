#SingleInstance force
SetKeyDelay, 20, 50
TToggle=0

; IniWrite, 1, cfg.ini, MainKeys, myKey

; Layout

Gui, Font, s15, Tahoma

Gui, Add, Radio, vR1, radio1				; not checked yet
Gui, Add, Radio, vR2 checked, radio2		; already checked



Gui, Show, w370 h170, % "V Rising Scripts"
return


; Labels

GuiClose:
	ExitApp
	return

;FnRClickCountdown:
;	rclickcounter=5
;	while rclickcounter > 0
;	{
;		GuiControl, , BtnRClickCountdown, % " Right clicking in " . rclickcounter . "..."
;		Sleep, 1000
;		rclickcounter := rclickcounter - 1
;	}
;	GuiControl, , BtnRClickCountdown, % " * * * Right clicking! * * *"
;	MouseClick, Left ; Chris's left and right clicks are reversed ***********************
;	Sleep, 500
;	GuiControl, , BtnRClickCountdown, % " Right click after 5 seconds: READY"
;	return


;#IfWinActive ahk_exe VRising.exe
#If MouseIsOver("ahk_exe VRising.exe")
{
;LButton::RButton
	~LButton::
	Sleep 200
	Send {RButton}
	Return
}
	Return 
#If
;#IfWinActive


; Function to detect if the mouse is hovering a specific window
MouseIsOver(vWinTitle:="", vWinText:="", vExcludeTitle:="", vExcludeText:="") {
	MouseGetPos,,, hWnd
	return WinExist(vWinTitle (vWinTitle=""?"":" ") "ahk_id " hWnd, vWinText, vExcludeTitle, vExcludeText)
}