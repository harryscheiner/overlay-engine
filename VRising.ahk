#NoEnv
#SingleInstance Force
SetBatchLines -1
CoordMode, Mouse, Client
CoordMode, Pixel, Client
SetKeyDelay, 20, 50

SetTitleMatchMode 3 ; 1 = Starts with, 2 = Contains, 3 = Exact
GAME_TITLE := "VRising" ; "ahk_exe VRising.exe" ; Alternate method of matching

;SetTitleMatchMode 2 ; 1 = Starts with, 2 = Contains, 3 = Exact
;GAME_TITLE := "test.txt - Notepad" ; "ahk_exe VRising.exe" ; Alternate method of matching

GAME_ACTIVE := 0 ; For use with If statements to ensure game is focused

; Window offset variables
X_OFFSET := getWindowOffset("x")
Y_OFFSET := getWindowOffset("y")
; Mouse coordinate variables
xpos := 0
ypos := 0

; General overlay setup
Gui New, +LastFound +E0x20 +AlwaysOnTop +ToolWindow -Caption +Hwndhwnd
WinSet, TransColor, 0xFF00FF 50
Gui, Color, 0xFF00FF

; Misc globals
AllowClickThrough := true

; V Rising Specific
Overlays := {}
Overlays.HUD := {check: "", curState: 1, newState: 1}
Overlays.Movement := {check: "", curState: 1, newState: 1}

Class GameUIElement {
  curState := -1
  newState := 0
  __New(opts) {
    this.x := opts.x
    this.y := opts.y
    this.w := opts.w
    this.h := opts.h
    this.color := opts.color
    this.variance := opts.hasKey("variance") ? opts.variance : 2
  }
  update() {
    ; Update virtual state
    if (this.curState != this.newState) {
      this.curState := this.newState
    }
  }
  check() {
    PixelSearch, Px, Py, this.x, this.y, this.x + this.w, this.y + this.h, this.color, this.variance, Fast RGB
    this.newState := !ErrorLevel
  }
}
GameUIElements := {}
GameUIElements.HealthBar := new GameUIElement({x: 208, y: 653, w: 2, h: 4, color: 0x007283})
GameUIElements.InventoryWindow := new GameUIElement({x: 123, y: 78, w: 2, h: 3, color: 0x940a0e})
GameUIElements.CraftingWindow := new GameUIElement({x: 314, y: 78, w: 2, h: 4, color: 0x660507})


; Key Map
Class Key {
  curState := -1
  newState := 0
  __New(key) {
    this.key := key
  }
  update() {
    ; Update virtual state
    if (this.curState != this.newState)
      this.curState := this.newState

    ; Update real keypress state
    key := this.key
    If (this.curState && !GetKeyState(key))
      Send {%key% Down}
    If (!this.curState && GetKeyState(key))
      Send {%key% Up}
  }

  forceRelease() {
    key := this.key
    If (GetKeyState(key))
      Send {%key% Up}
  }
}
Keys := {}
; Hotbar
Keys.Slot1 := new Key("1")
Keys.Slot2 := new Key("2")
Keys.Slot3 := new Key("3")
Keys.Slot4 := new Key("4")
Keys.Slot5 := new Key("5")
Keys.Slot6 := new Key("6")
Keys.Slot7 := new Key("7")
Keys.Slot8 := new Key("8")
Keys.Slot9 := new Key("9")
; Skills
Keys.PrimaryAttack := new Key("h")
Keys.WeaponAttack1 := new Key("q")
Keys.WeaponAttack2 := new Key("e")
Keys.DodgeSpell := new Key("Space")
Keys.Spell1 := new Key("r")
Keys.Spell2 := new Key("c")
Keys.Ultimate := new Key("t")
; Movement
Keys.MoveUp := new Key("w")
Keys.MoveLeft := new Key("a")
Keys.MoveDown := new Key("s")
Keys.Moveright := new Key("d")
Keys.RotateCamera := new Key("v")
; Misc
Keys.Feed := new Key("f")
Keys.Jump := new Key("z")

Keys.ZoomIn := new Key("WheelUp")
Keys.ZoomOut := new Key("WheelDown")

Keys.Repair := new Key("o")

Keys.ActionWheel := new Key("i")
Keys.EmoteWheel := new Key("LAlt")


Class Region {
  curState := -1
  newState := 0
  updateColor := false
  __New(opts) {
    this.x := opts.x
    this.y := opts.y
    this.w := opts.w
    this.h := opts.h
    this.keys := opts.keys ; Array of Key objects
    this.mode := opts.mode ; `press` | `toggle` | `hold`
    if (opts.hasKey("color"))
      this.color := opts.color
    if (opts.hasKey("manual"))
      this.manual := opts.manual
  }
  update() {
    if (this.curState != this.newState) {
      this.curState := this.newState
      this.updateColor := true
      return true
    }
    return false
  }
  pressKeys() {
    For k, v in this.keys {
      key := v.key
      Send {%key%}
    }
  }
  toggleKeys() {
    this.newState := !this.newState
    this.updateKeyStates(this.newState)
  }
  holdKeys() {
    If (!this.hasKey("manual") || !this.manual) {
      this.newState := true
      this.updateKeyStates(this.newState)
    } else {
      this.updateKeyStates(true)
    }
  }
  releaseKeys() {
    If (!this.hasKey("manual") || !this.manual) {
      this.newState := false
      this.updateKeyStates(this.newState)
    } else {
      this.updateKeyStates(false)
    }
  }
  updateKeyStates(state) {
    For k, v in this.keys {
      v.newState := state
    }
  }
}


; START Overlay: HUD
KeyReleaseRegions := {}
KeyReleaseRegions.Hotbar  := new Region({x: 163, y: 670, w: 344, h: 44, keys: [], mode: "none"})
KeyReleaseRegions.Sidebar := new Region({x: 1043, y: 138, w: 110, h: 303, keys: [], mode: "none"})
For k, v in KeyReleaseRegions {
  x := v.x
  y := v.y
  w := v.w
  h := v.h
  color := "0xFFB015"
  Gui, Add, Progress, x%x% y%y% w%w% h%h% Background%color% vKeyRelease%k%
}

HotbarButtons := {}
HotbarButtons.Slot1 := new Region({x: 164, y: 671, w: 32, h: 32, keys: [Keys.Slot1], mode: "press"})
HotbarButtons.Slot2 := new Region({x: 203, y: 671, w: 32, h: 32, keys: [Keys.Slot2], mode: "press"})
HotbarButtons.Slot3 := new Region({x: 242, y: 671, w: 32, h: 32, keys: [Keys.Slot3], mode: "press"})
HotbarButtons.Slot4 := new Region({x: 280, y: 671, w: 32, h: 32, keys: [Keys.Slot4], mode: "press"})
HotbarButtons.Slot5 := new Region({x: 319, y: 671, w: 32, h: 32, keys: [Keys.Slot5], mode: "press"})
HotbarButtons.Slot6 := new Region({x: 358, y: 671, w: 32, h: 32, keys: [Keys.Slot6], mode: "press"})
HotbarButtons.Slot7 := new Region({x: 396, y: 671, w: 32, h: 32, keys: [Keys.Slot7], mode: "press"})
HotbarButtons.Slot8 := new Region({x: 435, y: 671, w: 32, h: 32, keys: [Keys.Slot8], mode: "press"})
HotbarButtons.Slot9 := new Region({x: 474, y: 671, w: 32, h: 32, keys: [Keys.Slot9], mode: "press"})
For k, v in HotbarButtons {
  x := v.x
  y := v.y
  w := v.w
  h := v.h
  color := "0x1DB015"
  Gui, Add, Progress, x%x% y%y% w%w% h%h% Background%color% vHotbar%k%
}

SkillButtons := {}
SkillButtons.PrimaryAttack := new Region({x: 652, y: 669, w: 36, h: 36, keys: [Keys.PrimaryAttack], mode: "toggle", manual: true})
SkillButtons.WeaponAttack1 := new Region({x: 691, y: 669, w: 36, h: 36, keys: [Keys.WeaponAttack1], mode: "toggle"})
SkillButtons.WeaponAttack2 := new Region({x: 730, y: 669, w: 36, h: 36, keys: [Keys.WeaponAttack2], mode: "toggle"})
SkillButtons.DodgeSpell    := new Region({x: 779, y: 669, w: 36, h: 36, keys: [Keys.DodgeSpell], mode: "toggle"})
SkillButtons.Spell1        := new Region({x: 828, y: 669, w: 36, h: 36, keys: [Keys.Spell1], mode: "toggle"})
SkillButtons.Spell2        := new Region({x: 867, y: 669, w: 36, h: 36, keys: [Keys.Spell2], mode: "toggle"})
SkillButtons.Ultimate      := new Region({x: 916, y: 669, w: 36, h: 36, keys: [Keys.Ultimate], mode: "toggle"})
SkillButtons.Feed          := new Region({x: 611, y: 669, w: 29, h: 36, keys: [Keys.Feed], mode: "toggle"})
SkillButtons.Jump          := new Region({x: 554, y: 636, w: 44, h: 11, keys: [Keys.Jump], mode: "toggle"})
For k, v in SkillButtons {
  x := v.x
  y := v.y
  w := v.w
  h := v.h
  color := "0xB01D15"
  Gui, Add, Progress, x%x% y%y% w%w% h%h% Background%color% vSkill%k%
}

; END Overlay: HUD

; START Overlay: Movement
MovementButtons := {}
MovementButtons.Up           := new Region({x: 546, y: 270, w: 60, h: 40, keys: [Keys.RotateCamera, Keys.MoveUp], mode: "hold"})
MovementButtons.UpRight      := new Region({x: 616, y: 280, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveUp, Keys.MoveRight], mode: "hold"})
MovementButtons.Right        := new Region({x: 626, y: 330, w: 40, h: 60, keys: [Keys.RotateCamera, Keys.MoveRight], mode: "hold"})
MovementButtons.DownRight    := new Region({x: 616, y: 400, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveDown, Keys.MoveRight], mode: "hold"})
MovementButtons.Down         := new Region({x: 546, y: 410, w: 60, h: 40, keys: [Keys.RotateCamera, Keys.MoveDown], mode: "hold"})
MovementButtons.DownLeft     := new Region({x: 496, y: 400, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveDown, Keys.MoveLeft], mode: "hold"})
MovementButtons.Left         := new Region({x: 486, y: 330, w: 40, h: 60, keys: [Keys.RotateCamera, Keys.MoveLeft], mode: "hold"})
MovementButtons.UpLeft       := new Region({x: 496, y: 280, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveUp, Keys.MoveLeft], mode: "hold"})
MovementButtons.RotateCamera := new Region({x: 536, y: 320, w: 80, h: 80, keys: [Keys.RotateCamera], mode: "hold"})
For k, v in MovementButtons {
  x := v.x
  y := v.y
  w := v.w
  h := v.h
  color := "0x000000"
  background := "0x3088F3"
  Gui, Add, Progress, x%x% y%y% w%w% h%h% Background%background% c%color% vMove%k%, 100
}
; END Overlay: Movement





; General overlay creation
hOverlay := hwnd
SetTimer OverlayLoop, 100
Return





; TODOs

; Instead of showing/hiding all UI controls, create multiple GUIs and show/hide them
; Add a CheckGameState function that checks groups of pixel colors to determine which Overlay should be visible

; Need a way to prevent keys from forcing themselves on or off based on their virtual state if they aren't actively being toggled or held
  ; Key state has to be set to false when keys are force released
  ; When an overlay region becomes visible, call updatekeys to set them back to the values they should be

; How is LButton Up working when you release the button outside a region?

; Check GAME_ACTIVE at the start of the loop and use the GAME_ACTIVE var in MoveOverlay
  ; Might fix the "h" bug


; Lailloken UI - Path of Exile UI tool
; https://github.com/Lailloken/Lailloken-UI

; ImageSearch
; https://www.autohotkey.com/docs/v1/lib/ImageSearch.htm
; https://github.com/Lailloken/Lailloken-UI/blob/v1.20.0/Lailloken%20UI.ahk




; Mouse buttons have to be able to be swapped for Chris
  ; LButton and RButton do not behave as expected
  ; The bind for LButton works, but Send LButton Down does not. Maybe use Click?
  ; ^ Implemented! Needs testing.

; "0x3088F3"



$LButton::  
  AllowClickThrough := true
  if (GAME_ACTIVE) {
    MouseGetPos, xpos, ypos
    
    If (Overlays.HUD.curState) {
      ; Hotbar Slots - Click to activate
      For k, v in HotbarButtons {
        If (xpos < v.x || ypos < v.y || xpos > v.x + v.w || ypos > v.y + v.h)
          Continue
        v.pressKeys()
      }

      ; Skills - Click to toggle state
      For k, v in SkillButtons {
        If (xpos < v.x || ypos < v.y || xpos > v.x + v.w || ypos > v.y + v.h)
          Continue
        v.toggleKeys()
        AllowClickThrough := false
      }
      
      ; PrimaryAttack manual control
      If (AllowClickThrough && !SkillButtons.PrimaryAttack.curState && !SkillButtons.PrimaryAttack.manual) {
        SkillButtons.PrimaryAttack.manual := true
        SkillButtons.PrimaryAttack.holdKeys()
      }
    }

    If (Overlays.Movement.curState) {
      ; Movement - Press to hold
      For k, v in MovementButtons {
        If (xpos < v.x || ypos < v.y || xpos > v.x + v.w || ypos > v.y + v.h)
          Continue
        v.holdKeys()
        AllowClickThrough := false
      }
    }
  }
  If (AllowClickThrough)
    Click Down
Return

$LButton Up::
  if (GAME_ACTIVE) {
    If (Overlays.HUD.curState) {
      ; PrimaryAttack manual control
      If (AllowClickThrough && !SkillButtons.PrimaryAttack.curState && SkillButtons.PrimaryAttack.manual) {
        SkillButtons.PrimaryAttack.manual := false
        SkillButtons.PrimaryAttack.releaseKeys()
      }
    }

    If (Overlays.Movement.curState) {
      ; Movement - Release key
      For k, v in MovementButtons {
        If (xpos < v.x || ypos < v.y || xpos > v.x + v.w || ypos > v.y + v.h)
          Continue
        v.releaseKeys()
      }
    }
  }
  If (AllowClickThrough)
    Click Up
Return

x::
  Overlays.HUD.newState := !Overlays.HUD.newState
Return

; Helper functions
OverlayLoop:
  ;ToolTip, % SkillButtons.PrimaryAttack.manual
  ;ToolTip, % SkillButtons.DodgeSpell.curState
  ;ToolTip, % Overlays.HUD.curState
  ;ToolTip, % Keys.H.newState
  
  if (GAME_ACTIVE) {
    For k, v in GameUIElements {
      v.check()
      v.update()
    }
    Overlays.HUD.newState := GameUIElements.HealthBar.curState

    ; Overlay States
      ; Movement Overlay
        ; Health bar visible
        ; Compass Visible
      ; HUD
        ; Health bar visible
        ; NOT Inventory visible
        ; NOT Crafting window visible
      ; Inventory Repair
        ; Inventory Visible
    


    For k, v in Overlays {
      if (v.curState != v.newState) {
        v.curState := v.newState
        controlVisualState := v.newState ? "Show" : "Hide"
        Switch k {
          Case "HUD":
            For k, v in HotbarButtons {
              GuiControl, %hOverlay%: %controlVisualState%, Hotbar%k%
            }
            For k, v in SkillButtons {
              GuiControl, %hOverlay%: %controlVisualState%, Skill%k%
            }
            return
        }
      }
    }

    If (Overlays.HUD.curState) {
      ; KeyReleaseRegions - check state to restore toggled keys
      MouseGetPos, xpos, ypos
      For k, v in KeyReleaseRegions {
        v.newState := (xpos < v.x || ypos < v.y || xpos > v.x + v.w || ypos > v.y + v.h)
        if (v.update())
          goSub ReleaseAllKeys
      }

      ; Skill Region Colors (based on state)
      For k, v in SkillButtons {
        if (v.updateColor) {
          color := (v.curState ? "0x1DB015" : "0xB01D15")
          GuiControl, %hOverlay%: +Background%color%, Skill%k%
        }
      }
      
      ; TODO: There might be a better spot for this
      For k, v in SkillButtons {
        v.update()
      }
    } else {
      For k, v in SkillButtons {
        v.key.forceRelease()
      }
    }

    If (Overlays.Movement.curState) {
      ; Nothing yet
    } else {
      For k, v in MovementButtons {
        v.key.forceRelease()
      }
    }

    ; BUG - Even an overlay is off, (line ~436 above, SkillButtons forceRelease), the keys still get updated to their current state
    For k, v in Keys {
      v.update()
    }
  }
  gosub RenderOverlay
Return

RenderOverlay:
  if (hGame := WinActive(GAME_TITLE)) {
    ;WinGetPos x, y, , , % "ahk_id " hGame ; Alternate method of matching
    WinGetPos x, y, , , % %hGame%
    Gui %hOverlay%: Show, % Format("NoActivate x{} y{}", x + X_OFFSET, y + Y_OFFSET)
    GAME_ACTIVE := 1
  } else {
    Gui %hOverlay%: Hide
    GAME_ACTIVE := 0
    goSub ReleaseAllKeys
  }
Return

ReleaseAllKeys:
  For k, v in Keys {
    v.forceRelease()
  }
Return

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

; Force close with Ctrl+Esc
^Esc::
  goSub ReleaseAllKeys
  ExitApp
Return