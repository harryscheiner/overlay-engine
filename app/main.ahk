﻿#NoEnv
#SingleInstance Force
SetBatchLines -1
CoordMode, Mouse, Client
CoordMode, Pixel, Client
SetKeyDelay, 20, 50

#Include ./app/helpers.ahk
#Include ./app/Common/Overlay.ahk
#Include ./app/Common/GameUIElement.ahk
#Include ./app/Common/Key.ahk
#Include ./app/Common/Region.ahk
#Include ./app/Games/Game.ahk

GAME_ACTIVE := 0 ; For use with If statements to ensure game is focused

; Window offset variables
X_OFFSET := getWindowOffset("x")
Y_OFFSET := getWindowOffset("y")
; Mouse coordinate variables
xpos := 0
ypos := 0

; Misc globals
ClickedRegion := false

; "Close App" Gui Setup
SysGet, sizeframe, 33
SysGet, cyborder, 8
Gui, Font, s12
Gui, Add, Text, x0 w280 +Center, % "Game overlay is now running."
Gui, Add, Text, x0 w280 +Center vDebugLine1, % "To exit the program, press Ctrl+Esc"
Gui, Add, Text, x0 w280 +Center vDebugLine2, % "or close this window."
Gui, Add, Button, x110 w60 +Center, % "Close", Close
Gui, Show, % "x" A_ScreenWidth - 280 - sizeframe - cyborder " y" cyborder " w280", Game Overlay

; Create empty objects
Keys := {}
Overlays := {}
GameUIElements := {}

goSub Main
Return

$LButton::
  ClickedRegion := false
  if (GAME_ACTIVE) {
    MouseGetPos, xpos, ypos

    For overlayKey, overlay in Overlays {
      If (overlay.curState) {
        For regionMode, regions in Overlay.regions {
          For k, v in regions {
            If (xpos < v.x || ypos < v.y || xpos > v.x + v.w || ypos > v.y + v.h)
              Continue
            Switch (regionMode) {
              case "special":
                v.newState := true
              case "hold":
                v.holdKeys()
                GAME.hook_LButtonDown_AfterHold()
              case "press":
                v.pressKeys()
                GAME.hook_LButtonDown_AfterPress()
              case "toggle":
                v.toggleKeys()
                GAME.hook_LButtonDown_AfterToggle()
            }
            if (regionMode != "passthrough") {
              ClickedRegion := true
            }
          }
        }
      }
    }

    GAME.hook_LButtonDown_AfterOverlays()
  }
  If (!ClickedRegion)
    Click Down
Return

$LButton Up::
  if (GAME_ACTIVE) {
    For overlayKey, overlay in Overlays {
      If (overlay.curState) {
        If (Overlay.regions.hasKey("hold")) {
          For k, v in Overlay.regions.hold {
            v.releaseKeys()
          }
        }
      }
      If (Overlay.regions.hasKey("special")) {
        For k, v in Overlay.regions.special {
          v.newState := false
        }
      }
    }

    GAME.hook_LButtonUp_AfterOverlays()
  }
  If (!ClickedRegion)
    Click Up
Return

OverlayLoop:
  if (GAME_ACTIVE) {
    For k, v in GameUIElements {
      v.update()
    }

    GAME.hook_MidOverlayLoop()

    For k, v in Overlays {
      v.update()
    }
  }
  gosub RenderOverlay
Return

RenderOverlay:
  if (hGame := WinActive(GAME_TITLE)) {
    WinGetPos x, y, , , % "ahk_id " hGame
    For k, v in Overlays {
      overlay := v.gui
      if (v.curState)
        Gui %overlay%: Show, % Format("NoActivate x{} y{}", x + X_OFFSET, y + Y_OFFSET)
      else
        Gui %overlay%: Hide
    }
    GAME_ACTIVE := 1
  } else {
    if (GAME_ACTIVE == 1) {
      For k, v in Overlays {
        ;v.newState := false
        overlay := v.gui
        Gui %overlay%: Hide
      }
      GAME_ACTIVE := 0
      goSub ReleaseAllKeys
    }
  }
Return

ReleaseAllKeys:
  For k, v in Keys {
    v.forceRelease()
  }
Return

; Force close with Ctrl+Esc
^Esc::
  goSub ReleaseAllKeys
  ExitApp
Return

ButtonClose:
  goSub ReleaseAllKeys
  ExitApp
Return

GuiClose:
  goSub ReleaseAllKeys
  ExitApp
Return

Main:
hgame := false