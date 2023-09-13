#NoEnv
#SingleInstance Force
SetBatchLines -1
CoordMode, Mouse, Client
CoordMode, Pixel, Client
SetKeyDelay, 20, 50

; VRising Game Overlay, v20230911

SetTitleMatchMode 3 ; 1 = Starts with, 2 = Contains, 3 = Exact
GAME_TITLE := "VRising" ; "ahk_exe VRising.exe" ; Alternate method of matching
hGame := false

;SetTitleMatchMode 2 ; 1 = Starts with, 2 = Contains, 3 = Exact
;GAME_TITLE := "test.txt - Notepad" ; "ahk_exe VRising.exe" ; Alternate method of matching

GAME_ACTIVE := 0 ; For use with If statements to ensure game is focused

; "Close App" Gui Setup
SysGet, sizeframe, 33
SysGet, cyborder, 8
Gui, Font, s12
Gui, Add, Text, x0 w360 +Center, % "Game overlay is now running."
Gui, Add, Text, x0 w360 +Center, % "Closing this window will close the game overlay."
Gui, Show, % "x" A_ScreenWidth - 360 - sizeframe - cyborder " y" cyborder " w360", Game Overlay

; Window offset variables
X_OFFSET := getWindowOffset("x")
Y_OFFSET := getWindowOffset("y")
; Mouse coordinate variables
xpos := 0
ypos := 0

; Misc globals
ClickedRegion := false

; V Rising Specific
Class Overlay {
  curState := -1
  newState := 0
  regions := {}
  __New(opts) {
    opts.transparency := opts.hasKey("transparency") ? opts.transparency : 50

    ; Gui Setup
    Gui New, +LastFound +E0x20 +AlwaysOnTop +ToolWindow -Caption +Hwndhwnd
    WinSet, TransColor, % "0xFF00FF " opts.transparency
    Gui, Color, 0xFF00FF
    Gui, Font, s8 bold

    this.gui := hwnd
  }
  update() {
    ; Update virtual state
    if (this.curState != this.newState) {
      this.curState := this.newState

      ; Release all Toggle Region keys if Overlay not visible
      For k, v in this.regions.toggle {
        v.forceReleaseKeys()
      }
      ; Release all Hold Region keys if Overlay not visible
      For k, v in this.regions.hold {
        v.forceReleaseKeys()
      }
    }
    
    If (this.curState) {
      For regionMode, regions in this.regions {
        For k, v in regions {
          v.update()
        }
      }
    }
  }
  addRegion(id, opts) {
    opts.mode := opts.hasKey("mode") ? opts.mode : "none"
    if (!this.regions.hasKey(opts.mode))
      this.regions[opts.mode] := {}
    this.regions[opts.mode][id] := new Region(this.gui, id, opts)
  }
}
Overlays := {}
Overlays.General := new Overlay({transparency: 100}) ; Jump, Feed
Overlays.Zoom := new Overlay({transparency: 150}) ; Zoom In / Zoom Out
Overlays.HUD := new Overlay({}) ; Hotbar, Skills, Action Wheel, Emote Wheel
Overlays.Movement := new Overlay({}) ; Move, Camera
Overlays.Inventory := new Overlay({transparency: 150}) ; Repair


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
    ; Check to see if the UI Element is visible
    PixelSearch, Px, Py, this.x, this.y, this.x + this.w, this.y + this.h, this.color, this.variance, Fast RGB
    this.newState := !ErrorLevel

    ; Update virtual state
    if (this.curState != this.newState)
      this.curState := this.newState
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
Keys.MoveRight := new Key("d")
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
  __New(hwnd, id, opts) {
    this.hwnd := hwnd
    this.id := id

    this.x := opts.x
    this.y := opts.y
    this.w := opts.w
    this.h := opts.h
    this.keys := opts.keys ; Array of Key objects
    this.mode := opts.mode ; `press` | `toggle` | `hold`

    if (opts.hasKey("manual"))
      this.manual := opts.manual

    if (!opts.hasKey("noGuiControl"))
      this.createGuiControl(opts)
  }
  createGuiControl(opts) {
    ; Global scope is required to create GuiControl elements
    global

    ; Background color ON / OFF
    this.background := opts.hasKey("background") ? opts.background : "0x1DB015"
    this.backgroundOff := opts.hasKey("backgroundOff") ? opts.backgroundOff : "0xB01D15"

    ; Foreground color
    opts.value := opts.hasKey("color") ? 100 : 0
    this.color := opts.hasKey("color") ? opts.color : false

    ; Create GuiControl for rectangle
    Gui, % this.hwnd ": Add", Progress, % "X" opts.x " Y" opts.y " W" opts.w " H" opts.h " C" this.color " Background" this.background " v" this.id, % opts.value
    
    ; Create GuiControl for label
    if (this.hasText := opts.hasKey("text"))
      Gui, % this.hwnd ": Add", Text, % "X" opts.x " Y" opts.y " W" opts.w " H" opts.h " CWhite v" this.id "_Text +BackgroundTrans +Center 0x200", % opts.text
  }
  
  update() {
    changed := false
    if (this.curState != this.newState) {
      this.curState := this.newState
      if (this.mode = "toggle") {
        this.updateGuiControl()
      }
      changed := true
    }
    For k, v in this.keys {
      v.update()
    }
    return changed
  }
  updateGuiControl() {
    ; Update color based on state
    GuiControl, % this.hwnd ": +Background" (this.curState ? this.background : this.backgroundOff) , % this.id
    If (this.hasText) {
      GuiControl, % this.hwnd ": Hide", % this.id "_Text"
      GuiControl, % this.hwnd ": Show", % this.id "_Text"
    }
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
  
  forceReleaseKeys() {
    For k, v in this.keys {
      v.forceRelease()
    }
  }
}



; START KeyReleaseRegions
KeyReleaseOverlay := new Overlay({})
KeyReleaseOverlay.addRegion("KeyReleaseHotbar",  {noGuiControl: true, background: "0xFFB015", x: 163, y: 670, w: 344, h: 44, keys: [], mode: "none"})
KeyReleaseOverlay.addRegion("KeyReleaseSidebar", {noGuiControl: true, background: "0xFFB015", x: 1043, y: 138, w: 110, h: 303, keys: [], mode: "none"})
; END KeyReleaseRegions

; START Overlay: General
Overlays.General.addRegion("SkillFeed", {x: 611, y: 669, w: 29, h: 36, keys: [Keys.Feed], mode: "toggle"})
Overlays.General.addRegion("SkillJump", {text: "JUMP", x: 554, y: 624, w: 44, h: 22, keys: [Keys.Jump], mode: "toggle"})
; END Overlay: General

; START Overlay: Zoom
Overlays.Zoom.addRegion("ZoomIn",  {text: "IN",  color: "0x000000", background: "0x3088F3", x: 17, y: 658, w: 34, h: 20, keys: [Keys.ZoomIn], mode: "press"})
Overlays.Zoom.addRegion("ZoomOut", {text: "OUT", color: "0x000000", background: "0x3088F3", x: 17, y: 683, w: 34, h: 20, keys: [Keys.ZoomOut], mode: "press"})
; END Overlay: Zoom

; START Overlay: HUD
Overlays.HUD.addRegion("HotbarSlot1", {x: 164, y: 671, w: 32, h: 32, keys: [Keys.Slot1], mode: "press"})
Overlays.HUD.addRegion("HotbarSlot2", {x: 203, y: 671, w: 32, h: 32, keys: [Keys.Slot2], mode: "press"})
Overlays.HUD.addRegion("HotbarSlot3", {x: 242, y: 671, w: 32, h: 32, keys: [Keys.Slot3], mode: "press"})
Overlays.HUD.addRegion("HotbarSlot4", {x: 280, y: 671, w: 32, h: 32, keys: [Keys.Slot4], mode: "press"})
Overlays.HUD.addRegion("HotbarSlot5", {x: 319, y: 671, w: 32, h: 32, keys: [Keys.Slot5], mode: "press"})
Overlays.HUD.addRegion("HotbarSlot6", {x: 358, y: 671, w: 32, h: 32, keys: [Keys.Slot6], mode: "press"})
Overlays.HUD.addRegion("HotbarSlot7", {x: 396, y: 671, w: 32, h: 32, keys: [Keys.Slot7], mode: "press"})
Overlays.HUD.addRegion("HotbarSlot8", {x: 435, y: 671, w: 32, h: 32, keys: [Keys.Slot8], mode: "press"})
Overlays.HUD.addRegion("HotbarSlot9", {x: 474, y: 671, w: 32, h: 32, keys: [Keys.Slot9], mode: "press"})

Overlays.HUD.addRegion("SkillPrimaryAttack", {x: 652, y: 669, w: 36, h: 36, keys: [Keys.PrimaryAttack], mode: "toggle", manual: true})
Overlays.HUD.addRegion("SkillWeaponAttack1", {x: 691, y: 669, w: 36, h: 36, keys: [Keys.WeaponAttack1], mode: "toggle"})
Overlays.HUD.addRegion("SkillWeaponAttack2", {x: 730, y: 669, w: 36, h: 36, keys: [Keys.WeaponAttack2], mode: "toggle"})
Overlays.HUD.addRegion("SkillDodgeSpell",    {x: 779, y: 669, w: 36, h: 36, keys: [Keys.DodgeSpell], mode: "toggle"})
Overlays.HUD.addRegion("SkillSpell1",        {x: 828, y: 669, w: 36, h: 36, keys: [Keys.Spell1], mode: "toggle"})
Overlays.HUD.addRegion("SkillSpell2",        {x: 867, y: 669, w: 36, h: 36, keys: [Keys.Spell2], mode: "toggle"})
Overlays.HUD.addRegion("SkillUltimate",      {x: 916, y: 669, w: 36, h: 36, keys: [Keys.Ultimate], mode: "toggle"})

Overlays.HUD.addRegion("WheelAction",      {text: "Action", color: "0x000000", background: "0x3088F3", x: 496, y: 450, w: 40, h: 20, keys: [Keys.ActionWheel], mode: "hold"})
Overlays.HUD.addRegion("WheelEmote",       {text: "Emote", color: "0x000000", background: "0x3088F3", x: 616, y: 450, w: 40, h: 20, keys: [Keys.EmoteWheel], mode: "hold"})
; END Overlay: HUD

; START Overlay: Movement
Overlays.Movement.addRegion("MoveUp",           {color: "0x000000", background: "0x3088F3", x: 546, y: 270, w: 60, h: 40, keys: [Keys.RotateCamera, Keys.MoveUp], mode: "hold"})
Overlays.Movement.addRegion("MoveUpRight",      {color: "0x000000", background: "0x3088F3", x: 616, y: 280, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveUp, Keys.MoveRight], mode: "hold"})
Overlays.Movement.addRegion("MoveRight",        {color: "0x000000", background: "0x3088F3", x: 626, y: 330, w: 40, h: 60, keys: [Keys.RotateCamera, Keys.MoveRight], mode: "hold"})
Overlays.Movement.addRegion("MoveDownRight",    {color: "0x000000", background: "0x3088F3", x: 616, y: 400, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveDown, Keys.MoveRight], mode: "hold"})
Overlays.Movement.addRegion("MoveDown",         {color: "0x000000", background: "0x3088F3", x: 546, y: 410, w: 60, h: 40, keys: [Keys.RotateCamera, Keys.MoveDown], mode: "hold"})
Overlays.Movement.addRegion("MoveDownLeft",     {color: "0x000000", background: "0x3088F3", x: 496, y: 400, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveDown, Keys.MoveLeft], mode: "hold"})
Overlays.Movement.addRegion("MoveLeft",         {color: "0x000000", background: "0x3088F3", x: 486, y: 330, w: 40, h: 60, keys: [Keys.RotateCamera, Keys.MoveLeft], mode: "hold"})
Overlays.Movement.addRegion("MoveUpLeft",       {color: "0x000000", background: "0x3088F3", x: 496, y: 280, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveUp, Keys.MoveLeft], mode: "hold"})
Overlays.Movement.addRegion("MoveRotateCamera", {color: "0x000000", background: "0x3088F3", x: 536, y: 320, w: 80, h: 80, keys: [Keys.RotateCamera], mode: "hold"})
; END Overlay: Movement

; START Overlay: Inventory Repair
Overlays.Inventory.addRegion("RepairHelmet", {text: "R", x: 205, y:  96, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
Overlays.Inventory.addRegion("RepairChest",  {text: "R", x: 207, y: 143, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
Overlays.Inventory.addRegion("RepairGloves", {text: "R", x: 278, y: 202, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
Overlays.Inventory.addRegion("RepairPants",  {text: "R", x: 207, y: 210, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
Overlays.Inventory.addRegion("RepairBoots",  {text: "R", x: 207, y: 297, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
Overlays.Inventory.addRegion("RepairCloak",  {text: "R", x: 145, y: 111, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
Overlays.Inventory.addRegion("RepairRing",   {text: "R", x: 145, y: 199, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
Overlays.Inventory.addRegion("RepairSlot1",  {text: "R", x: 122, y: 397, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
Overlays.Inventory.addRegion("RepairSlot2",  {text: "R", x: 162, y: 397, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
Overlays.Inventory.addRegion("RepairSlot3",  {text: "R", x: 203, y: 397, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
Overlays.Inventory.addRegion("RepairSlot4",  {text: "R", x: 244, y: 397, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
; END Overlay: Inventory Repair

SetTimer OverlayLoop, 100
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
              case "hold":
                v.holdKeys()
              case "press":
                v.pressKeys()
                For k, v in Overlays.General.regions.toggle {
                  v.releaseKeys()
                }
              case "toggle":
                v.toggleKeys()
            }
            ClickedRegion := true
          }
        }
      }
    }

    If (Overlays.HUD.curState) {
      ; PrimaryAttack manual control
      If (!ClickedRegion && !Overlays.HUD.regions.toggle.SkillPrimaryAttack.curState && !Overlays.HUD.regions.toggle.SkillPrimaryAttack.manual) {
        Overlays.HUD.regions.toggle.SkillPrimaryAttack.manual := true
        Overlays.HUD.regions.toggle.SkillPrimaryAttack.holdKeys()
      }
    }
  }
  If (!ClickedRegion)
    Click Down
Return

$LButton Up::
  if (GAME_ACTIVE) {

    For overlayKey, overlay in Overlays {
      If (overlay.curState && Overlay.regions.hasKey("hold")) {
        For k, v in Overlay.regions.hold {
          v.releaseKeys()
        }
      }
    }

    ; PrimaryAttack manual control
    If (!ClickedRegion && Overlays.HUD.regions.toggle.SkillPrimaryAttack.manual) {
      Overlays.HUD.regions.toggle.SkillPrimaryAttack.manual := false
      Overlays.HUD.regions.toggle.SkillPrimaryAttack.releaseKeys()
    }
  }
  If (!ClickedRegion)
    Click Up
Return

; Helper functions
OverlayLoop:
  if (GAME_ACTIVE) {
    For k, v in GameUIElements {
      v.update()
    }
    Overlays.General.newState := GameUIElements.HealthBar.curState
    Overlays.Zoom.newState := !GameUIElements.InventoryWindow.curState && !GameUIElements.CraftingWindow.curState
    Overlays.HUD.newState := GameUIElements.HealthBar.curState && !GameUIElements.InventoryWindow.curState && !GameUIElements.CraftingWindow.curState
    Overlays.Movement.newState := GameUIElements.HealthBar.curState
    Overlays.Inventory.newState := GameUIElements.InventoryWindow.curState
    
    ; KeyReleaseRegions - check state to restore toggled keys
    MouseGetPos, xpos, ypos
    For k, v in KeyReleaseOverlay.regions.none {
      v.newState := (xpos < v.x || ypos < v.y || xpos > v.x + v.w || ypos > v.y + v.h)
      if (v.update())
        goSub ReleaseAllKeys
    }

    For k, v in Overlays {
      v.update()
    }
  }
  gosub RenderOverlay
Return

RenderOverlay:
  if (hGame := WinActive(GAME_TITLE)) {
    ;WinGetPos x, y, , , % "ahk_id " hGame ; Alternate method of matching
    WinGetPos x, y, , , % %hGame%
    For k, v in Overlays {
      overlay := v.gui
      if (v.curState)
        Gui %overlay%: Show, % Format("NoActivate x{} y{}", x + X_OFFSET, y + Y_OFFSET)
      else
        Gui %overlay%: Hide
    }
    GAME_ACTIVE := 1
  } else {
    For k, v in Overlays {
      ;v.newState := false
      overlay := v.gui
      Gui %overlay%: Hide
    }
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

GuiClose:
  goSub ReleaseAllKeys
	ExitApp
	return