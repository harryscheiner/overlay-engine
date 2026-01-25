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
    Keys.DirectMinions := new Key("y")
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
    ; Overlay: General
    Overlays.Skills.addRegion("DirectMinionsToggle",  {text: "Direct Minions", color: "0x0e550a", colorOff: "0x550e0a", keys: [Keys.DirectMinions], mode: "timer", time: 2000})
    Overlays.Skills.addRegion("DodgeToggle",  {text: "Dodge", color: "0x0e550a", colorOff: "0x550e0a", keys: [Keys.Dodge], mode: "timer", time: 1100})
    Overlays.Skills.addRegion("FlaskToggle",  {text: "Flasks", color: "0x0e550a", colorOff: "0x550e0a", keys: [Keys.HealthFlask, Keys.ManaFlask], mode: "timer", time: 500})
    Overlays.Skills.addRegion("Skill3Toggle",  {text: "Q", color: "0x0e550a", colorOff: "0x550e0a", keys: [Keys.Skill3], mode: "timer", time: 2000})
    Overlays.Skills.addRegion("Skill4Toggle",  {text: "W", color: "0x0e550a", colorOff: "0x550e0a", keys: [Keys.Skill4], mode: "timer", time: 2000})
    Overlays.Skills.addRegion("Skill5Toggle",  {text: "E", color: "0x0e550a", colorOff: "0x550e0a", keys: [Keys.Skill5], mode: "timer", time: 2000})
    Overlays.Skills.addRegion("Skill6Toggle",  {text: "R", color: "0x0e550a", colorOff: "0x550e0a", keys: [Keys.Skill6], mode: "timer", time: 2000})
    Overlays.Skills.addRegion("Skill7Toggle",  {text: "T", color: "0x0e550a", colorOff: "0x550e0a", keys: [Keys.Skill7], mode: "timer", time: 2000})
    
    Overlays.General.addRegion("OpenPauseMenu",  {text: "Esc", color: "0x000000", background: "0x3088F3", keys: [Keys.PauseMenu], mode: "press"})
    Overlays.General.addRegion("OpenPanelGems",  {text: "G", color: "0x000000", background: "0x3088F3", keys: [Keys.PanelGems], mode: "press"})
    Overlays.General.addRegion("OpenPanelTree",  {text: "P", color: "0x000000", background: "0x3088F3", keys: [Keys.PanelTree], mode: "press"})
    Overlays.General.addRegion("OpenPanelChar",  {text: "C", color: "0x000000", background: "0x3088F3", keys: [Keys.PanelChar], mode: "press"})
    Overlays.General.addRegion("OpenPanelInv",   {text: "I", color: "0x000000", background: "0x3088F3", keys: [Keys.PanelInv], mode: "press"})

    Overlays.SkillsHide.addRegion("HideSkillsOverlay",  {text: "»", color: "0x000000", background: "0x3088F3", keys: [], mode: "special", specialHook: "hideSkillsOverlay"})
    Overlays.SkillsShow.addRegion("ShowSkillsOverlay",  {text: "«", color: "0x000000", background: "0x3088F3", keys: [], mode: "special", specialHook: "showSkillsOverlay"})

    Overlays.General.addRegion("ZoomIn",         {text: "▲", color: "0x000000", background: "0x3088F3", keys: [Keys.MWheelUp], mode: "hold"})
    Overlays.General.addRegion("ZoomOut",        {text: "▼", color: "0x000000", background: "0x3088F3", keys: [Keys.MWheelDown], mode: "hold"})

    Overlays.Skills.newState := true ; Set initial state of Skills Overlay to visible
    Overlays.SkillsHide.newState := true
  }

  setRegionPositions() {
    global
    ;GAME_BASE_WIDTH = 880 | 55rem
    ;GAME_BASE_HEIGHT = 600 | 37.5rem
    rem := Ceil(this.windowH / 37.5) ; 16px when window height == 600

    ; Game UI Panel (Health/Mana)
    POS_gameUiPanelHeight := Ceil(this.windowH * 0.21666)
    POS_gameUiPanelWidth := Ceil(POS_gameUiPanelHeight * 2.8076)

    ; Health side
    POS_healthUiX := 0
    POS_healthUiY := this.windowH - POS_gameUiPanelHeight

    ; Mana side
    POS_manaUiX := this.windowW - POS_gameUiPanelWidth
    POS_manaUiY := this.windowH - POS_gameUiPanelHeight

    ; Menu Buttons anchor position (Esc, G, P, etc)
    POS_skillsX := POS_manaUiX + (15.5*rem)
    POS_skillsY := POS_manaUiY - (4.5*rem)

    ; Menu Buttons anchor position (Esc, G, P, etc)
    POS_menuButtonsX := POS_manaUiX + (7.5*rem)
    POS_menuButtonsY := POS_manaUiY + (0.5*rem)

    ; Set the region positions
    Overlays.Skills.regions.timer.DirectMinionsToggle.updateOpts({x: POS_skillsX, y: POS_skillsY - (1*rem) - 1, w: Floor(5*rem) + 4, h: (1*rem)})
    Overlays.Skills.regions.timer.DodgeToggle.updateOpts({x: POS_skillsX, y: POS_skillsY, w: Floor(2.5*rem) + 1, h: (1.5*rem)})
    Overlays.Skills.regions.timer.FlaskToggle.updateOpts({x: POS_skillsX + Floor(2.5*rem) + 2, y: POS_skillsY, w: Floor(2.5*rem) + 2, h: (1.5*rem)})
    
    Overlays.Skills.regions.timer.Skill3Toggle.updateOpts({x: POS_skillsX, y: POS_skillsY + (1.5*rem) + 1, w: rem, h: rem})
    Overlays.Skills.regions.timer.Skill4Toggle.updateOpts({x: POS_skillsX + rem + 1, y: POS_skillsY + (1.5*rem) + 1, w: rem, h: rem})
    Overlays.Skills.regions.timer.Skill5Toggle.updateOpts({x: POS_skillsX + (2*rem) + 2, y: POS_skillsY + (1.5*rem) + 1, w: rem, h: rem})
    Overlays.Skills.regions.timer.Skill6Toggle.updateOpts({x: POS_skillsX + (3*rem) + 3, y: POS_skillsY + (1.5*rem) + 1, w: rem, h: rem})
    Overlays.Skills.regions.timer.Skill7Toggle.updateOpts({x: POS_skillsX + (4*rem) + 4, y: POS_skillsY + (1.5*rem) + 1, w: rem, h: rem})
    
    Overlays.General.regions.press.OpenPauseMenu.updateOpts({x: POS_menuButtonsX, y: POS_menuButtonsY, w: (1.25*rem), h: (1.25*rem)})
    Overlays.General.regions.press.OpenPanelGems.updateOpts({x: POS_menuButtonsX + Floor(1.25*rem) + 1, y: POS_menuButtonsY, w: (1.25*rem), h: (1.25*rem)})
    Overlays.General.regions.press.OpenPanelTree.updateOpts({x: POS_menuButtonsX + (2*Floor(1.25*rem)) + 2, y: POS_menuButtonsY, w: (1.25*rem), h: (1.25*rem)})
    Overlays.General.regions.press.OpenPanelChar.updateOpts({x: POS_menuButtonsX + (3*Floor(1.25*rem)) + 3, y: POS_menuButtonsY, w: (1.25*rem), h: (1.25*rem)})
    Overlays.General.regions.press.OpenPanelInv.updateOpts({x: POS_menuButtonsX + (4*Floor(1.25*rem)) + 4, y: POS_menuButtonsY, w: (1.25*rem), h: (1.25*rem)})
    
    Overlays.SkillsHide.regions.special.HideSkillsOverlay.updateOpts({x: POS_menuButtonsX + (5*Floor(1.25*rem)) + 5, y: POS_menuButtonsY, w: (1.25*rem), h: (1.25*rem)})
    Overlays.SkillsShow.regions.special.ShowSkillsOverlay.updateOpts({x: POS_menuButtonsX + (5*Floor(1.25*rem)) + 5, y: POS_menuButtonsY, w: (1.25*rem), h: (1.25*rem)})
    
    Overlays.General.regions.hold.ZoomIn.updateOpts({x: POS_healthUiX + POS_gameUiPanelWidth - rem, y: POS_healthUiY - (2*rem) - 1, w: rem, h: rem})
    Overlays.General.regions.hold.ZoomOut.updateOpts({x: POS_healthUiX + POS_gameUiPanelWidth - rem, y: POS_healthUiY - rem, w: rem, h: rem})

    ; DEBUG - To visualize the health and mana UI regions
    ;Overlays.General.regions.press.OpenPanelGems.updateOpts({x: POS_healthUiX, y: POS_healthUiY, w: POS_gameUiPanelWidth, h: POS_gameUiPanelHeight})
    ;Overlays.General.regions.press.OpenPauseMenu.updateOpts({x: POS_manaUiX, y: POS_manaUiY, w: POS_gameUiPanelWidth, h: POS_gameUiPanelHeight})
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
