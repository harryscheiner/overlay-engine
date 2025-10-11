Class PathOfExile2 extends Game {
  ; Init functions
  matchGame() {
    global
    SetTitleMatchMode 3
    GAME_TITLE := "Path of Exile 2"
    ; NOTE: All coordinates expect game to be running at APPROXIMATELY 880x600 resolution
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
    ; Screens
    Keys.PauseMenu := new Key("Esc")
    Keys.Map := new Key("Tab")
    Keys.PanelGems := new Key("g")
    Keys.PanelTree := new Key("p")
    Keys.PanelChar := new Key("c")
    Keys.PanelInv := new Key("i")
    ; Misc
    Keys.AltKey := new Key("LAlt")
    Keys.MWheelUp := new Key("WheelUp")
    Keys.MWheelDown := new Key("WheelDown")
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.General := new Overlay({font: "s7", transparency: 100})
    Overlays.Skills := new Overlay({font: "s7", transparency: 100})
    Overlays.SkillsHide := new Overlay({font: "s12", transparency: 100})
    Overlays.SkillsShow := new Overlay({font: "s12", transparency: 100})
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
    POS_bottomLeftX := POS_healthUiWidth * 1.2
    POS_bottomLeftY := this.windowH - this.offsetY - (POS_healthUiHeight * 1.00)
    
    ; Above Mana UI anchor position
    POS_aboveManaX := this.windowW - (POS_healthUiWidth * 0.45)
    POS_aboveManaY := this.windowH - this.offsetY - (POS_healthUiHeight * 1.30)
    
    ; Left Of Mana UI anchor position
    POS_leftOfManaX := this.windowW - (POS_healthUiWidth * 0.90)
    POS_leftOfManaY := this.windowH - this.offsetY - (POS_healthUiHeight * 0.80)

    ; Overlay: General
    Overlays.Skills.addRegion("DodgeToggle",  {text: "Dodge", color: "0x0e550a", colorOff: "0x550e0a", x: POS_aboveManaX + 0, y: POS_aboveManaY + 10, w: 41, h: 23, keys: [Keys.Dodge], mode: "timer", time: 1100})
    Overlays.Skills.addRegion("FlaskToggle",  {text: "Flasks", color: "0x0e550a", colorOff: "0x550e0a", x: POS_aboveManaX + 42, y: POS_aboveManaY + 10, w: 42, h: 23, keys: [Keys.HealthFlask, Keys.ManaFlask], mode: "timer", time: 500})
    Overlays.Skills.addRegion("Skill3Toggle",  {text: "Q", color: "0x0e550a", colorOff: "0x550e0a", x: POS_aboveManaX + 0, y: POS_aboveManaY + 34, w: 16, h: 16, keys: [Keys.Skill3], mode: "timer", time: 2000})
    Overlays.Skills.addRegion("Skill4Toggle",  {text: "W", color: "0x0e550a", colorOff: "0x550e0a", x: POS_aboveManaX + 17, y: POS_aboveManaY + 34, w: 16, h: 16, keys: [Keys.Skill4], mode: "timer", time: 2000})
    Overlays.Skills.addRegion("Skill5Toggle",  {text: "E", color: "0x0e550a", colorOff: "0x550e0a", x: POS_aboveManaX + 34, y: POS_aboveManaY + 34, w: 16, h: 16, keys: [Keys.Skill5], mode: "timer", time: 2000})
    Overlays.Skills.addRegion("Skill6Toggle",  {text: "R", color: "0x0e550a", colorOff: "0x550e0a", x: POS_aboveManaX + 51, y: POS_aboveManaY + 34, w: 16, h: 16, keys: [Keys.Skill6], mode: "timer", time: 2000})
    Overlays.Skills.addRegion("Skill7Toggle",  {text: "T", color: "0x0e550a", colorOff: "0x550e0a", x: POS_aboveManaX + 68, y: POS_aboveManaY + 34, w: 16, h: 16, keys: [Keys.Skill7], mode: "timer", time: 2000})
    
    Overlays.General.addRegion("OpenPauseMenu",  {text: "Esc", color: "0x000000", background: "0x3088F3", x: POS_leftOfManaX + 0, y: POS_leftOfManaY + 0, w: 20, h: 20, keys: [Keys.PauseMenu], mode: "press"})
    Overlays.General.addRegion("OpenPanelGems",  {text: "G", color: "0x000000", background: "0x3088F3", x: POS_leftOfManaX + 21, y: POS_leftOfManaY + 0, w: 20, h: 20, keys: [Keys.PanelGems], mode: "press"})
    Overlays.General.addRegion("OpenPanelTree",  {text: "P", color: "0x000000", background: "0x3088F3", x: POS_leftOfManaX + 42, y: POS_leftOfManaY + 0, w: 20, h: 20, keys: [Keys.PanelTree], mode: "press"})
    Overlays.General.addRegion("OpenPanelChar",  {text: "C", color: "0x000000", background: "0x3088F3", x: POS_leftOfManaX + 64, y: POS_leftOfManaY + 0, w: 20, h: 20, keys: [Keys.PanelChar], mode: "press"})
    Overlays.General.addRegion("OpenPanelInv",   {text: "I", color: "0x000000", background: "0x3088F3", x: POS_leftOfManaX + 86, y: POS_leftOfManaY + 0, w: 20, h: 20, keys: [Keys.PanelInv], mode: "press"})

    Overlays.SkillsHide.addRegion("HideSkillsOverlay",  {text: "»", color: "0x000000", background: "0x3088F3", x: POS_leftOfManaX + 108, y: POS_leftOfManaY + 0, w: 20, h: 20, keys: [], mode: "special", specialHook: "hideSkillsOverlay"})
    Overlays.SkillsShow.addRegion("ShowSkillsOverlay",  {text: "«", color: "0x000000", background: "0x3088F3", x: POS_leftOfManaX + 108, y: POS_leftOfManaY + 0, w: 20, h: 20, keys: [], mode: "special", specialHook: "showSkillsOverlay"})

    Overlays.General.addRegion("ZoomIn",         {text: "▲", color: "0x000000", background: "0x3088F3", x: POS_bottomLeftX, y: POS_bottomLeftY, w: 16, h: 16, keys: [Keys.MWheelUp], mode: "hold"})
    Overlays.General.addRegion("ZoomOut",        {text: "▼", color: "0x000000", background: "0x3088F3", x: POS_bottomLeftX, y: POS_bottomLeftY + 17, w: 16, h: 16, keys: [Keys.MWheelDown], mode: "hold"})
    ;Overlays.General.addRegion("OpenPanelGems2", {text: "G", color: "0x000000", background: "0x3088F3", x: POS_bottomLeftX, y: POS_bottomLeftY + 34, w: 16, h: 16, keys: [Keys.PanelGems], mode: "press"})

    Overlays.Skills.newState := true ; Set initial state of Skills Overlay to visible
    Overlays.SkillsHide.newState := true
  }

  ; Hooks
  hook_Special(region) {
    global
    if (region.curState) {
      if (region.specialHook = "showSkillsOverlay") {
        Overlays.Skills.newState := true
        Overlays.SkillsShow.newState := false
        Overlays.SkillsHide.newState := true
      }
      if (region.specialHook = "hideSkillsOverlay") {
        Overlays.Skills.newState := false
        Overlays.SkillsHide.newState := false
        Overlays.SkillsShow.newState := true
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
