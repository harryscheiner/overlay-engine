Class PathOfExile2 extends Game {
  ; Init functions
  matchGame() {
    global
    SetTitleMatchMode 3
    GAME_TITLE := "Path of Exile 2"
    ; NOTE: All coordinates expect game to be running at APPROXIMATELY 970x680 resolution
  }
  setKeys() {
    global
    ; Flasks
    Keys.HealthFlask := new Key("1")
    Keys.ManaFlask := new Key("2")
    ; Movement
    Keys.Dodge := new Key("Space")
    ; Skills
    Keys.Skill1 := new Key("MButton")
    Keys.Skill2 := new Key("RButton")
    Keys.Skill3 := new Key("q")
    Keys.Skill4 := new Key("w")
    Keys.Skill5 := new Key("e")
    Keys.Skill6 := new Key("r")
    Keys.Skill7 := new Key("t")
    ; Misc
    Keys.AltKey := new Key("LAlt")
    Keys.MWheelUp := new Key("WheelUp")
    Keys.MWheelDown := new Key("WheelDown")
    Keys.PauseMenu := new Key("Esc")
    Keys.Map := new Key("Tab")
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.General := new Overlay({font: "s7", transparency: 100})
  }

  setGameUIElements() {
    global
    ; Game UI Elements
  }

  setRegions() {
    global
    ; Health UI = 26% of window height
    POS_healthUiHeight := this.windowH * 0.26
    POS_healthUiWidth := POS_healthUiHeight * 1.75

    ; Bottom left UI anchor position
    POS_bottomLeftX := POS_healthUiWidth * 0.45
    POS_bottomLeftY := this.windowH - this.offsetY - (POS_healthUiHeight * 0.95)

    ; Overlay: General
    Overlays.General.addRegion("DodgeToggle",  {text: "Dodge", color: "0x0e550a", colorOff: "0x550e0a", x: POS_bottomLeftX + 17, y: POS_bottomLeftY, w: 40, h: 16, keys: [Keys.Dodge], mode: "timer", time: 1000})
    Overlays.General.addRegion("FlaskToggle",  {text: "Flasks", color: "0x0e550a", colorOff: "0x550e0a", x: POS_bottomLeftX + 17, y: POS_bottomLeftY + 17, w: 40, h: 16, keys: [Keys.HealthFlask, Keys.ManaFlask], mode: "timer", time: 500})
    Overlays.General.addRegion("Skill3Toggle",  {text: "Q", color: "0x0e550a", colorOff: "0x550e0a", x: POS_bottomLeftX + 17, y: POS_bottomLeftY + 34, w: 16, h: 16, keys: [Keys.Skill3], mode: "timer", time: 2000})
    Overlays.General.addRegion("Skill4Toggle",  {text: "W", color: "0x0e550a", colorOff: "0x550e0a", x: POS_bottomLeftX + 34, y: POS_bottomLeftY + 34, w: 16, h: 16, keys: [Keys.Skill4], mode: "timer", time: 2000})
    Overlays.General.addRegion("Skill5Toggle",  {text: "E", color: "0x0e550a", colorOff: "0x550e0a", x: POS_bottomLeftX + 51, y: POS_bottomLeftY + 34, w: 16, h: 16, keys: [Keys.Skill5], mode: "timer", time: 2000})
    Overlays.General.addRegion("Skill6Toggle",  {text: "R", color: "0x0e550a", colorOff: "0x550e0a", x: POS_bottomLeftX + 68, y: POS_bottomLeftY + 34, w: 16, h: 16, keys: [Keys.Skill6], mode: "timer", time: 2000})
    Overlays.General.addRegion("Skill7Toggle",  {text: "T", color: "0x0e550a", colorOff: "0x550e0a", x: POS_bottomLeftX + 85, y: POS_bottomLeftY + 34, w: 16, h: 16, keys: [Keys.Skill7], mode: "timer", time: 2000})

    Overlays.General.addRegion("ZoomIn",       {text: "▲", color: "0x000000", background: "0x3088F3", x: POS_bottomLeftX, y: POS_bottomLeftY, w: 16, h: 16, keys: [Keys.MWheelUp], mode: "hold"})
    Overlays.General.addRegion("ZoomOut",      {text: "▼", color: "0x000000", background: "0x3088F3", x: POS_bottomLeftX, y: POS_bottomLeftY + 17, w: 16, h: 16, keys: [Keys.MWheelDown], mode: "hold"})
  }

  ; Hooks
  hook_Special(region) {
    global
    if (region.curState) {
      if (region.specialHook = "longJump") {
        For k, v in [Keys.MoveUp, Keys.Jump]
          v.down()
        Sleep 180
        Keys.Dodge.down()
        Sleep 200
        For k, v in [Keys.MoveUp, Keys.Jump]
          v.up()
        Keys.Dodge.up()
      }
    }
  }
  hook_LButtonDown_AfterPress() {
  }
  hook_LButtonDown_AfterOverlays() {
  }
  hook_LButtonUp_AfterOverlays() {
  }
  hook_MidOverlayLoop() {
    global
    ; Check state of GameUIElements and set state of Overlays accordingly
    Overlays.General.newState := true ; Always visible
  }
}
GAME := new PathOfExile2()
