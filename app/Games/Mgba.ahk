Class Mgba extends Game {
  ; NOTE: Default coordinates expect game to be running at 960x640 resolution (window is 960x661 including a 21px menubar)
  setKeys() {
    global
    ; Movement
    Keys.MoveUp := new Key("Up")
    Keys.MoveLeft := new Key("Left")
    Keys.MoveDown := new Key("Down")
    Keys.MoveRight := new Key("Right")
    ; General
    Keys.L := new Key("a")
    Keys.R := new Key("s")
    Keys.B := new Key("z")
    Keys.A := new Key("x")
    Keys.Select := new Key("Backspace")
    Keys.Start := new Key("Return")
  }

  ; Standard: hover mode. Repeat: hover-timer mode (same regions, ids prefixed with "Rpt")
  getOverlayConfigs() {
    return [{name: "Standard", prefix: "",    mode: "hover",      time: 0,   hoverDelay: 500}
          , {name: "Repeat",   prefix: "Rpt", mode: "hovertimer", time: 500, hoverDelay: 0}]
  }

  setOverlays() {
    global
    Overlays.Standard := new Overlay({transparency: 145})
    Overlays.Repeat := new Overlay({transparency: 145})
  }

  setRegions() {
    global
    regionDefs := [["MoveUp",    "↑",      [Keys.MoveUp],    "0x164375"]
                 , ["MoveRight", "→",      [Keys.MoveRight], "0x164375"]
                 , ["MoveDown",  "↓",      [Keys.MoveDown],  "0x164375"]
                 , ["MoveLeft",  "←",      [Keys.MoveLeft],  "0x164375"]
                 , ["BtnL",      "L",      [Keys.L],         "0x164375"]
                 , ["BtnR",      "R",      [Keys.R],         "0x164375"]
                 , ["BtnSelect", "Select", [Keys.Select],    "0x164375"]
                 , ["BtnStart",  "Start",  [Keys.Start],     "0x164375"]
                 , ["BtnB",      "B",      [Keys.B],         "0x164375"]
                 , ["BtnA",      "A",      [Keys.A],         "0x164375"]]

    For mgIdx, mgCfg in this.getOverlayConfigs() {
      For mgDefIdx, mgDef in regionDefs {
        mgOpts := {text: mgDef[2], color: mgDef[4], colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: mgDef[3], mode: mgCfg.mode}
        if (mgCfg.time)
          mgOpts.time := mgCfg.time
        if (mgCfg.hoverDelay)
          mgOpts.hoverDelay := mgCfg.hoverDelay
        Overlays[mgCfg.name].addRegion(mgCfg.prefix . mgDef[1], mgOpts)
      }
    }

    ; Toggle buttons (bottom right), switch visibility between the two overlays
    Overlays.Standard.addRegion("ToggleToRepeat",   {text: "Mode: Standard", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [], mode: "hover", hoverDelay: 1000, specialHook: "showRepeatOverlay"})
    Overlays.Repeat.addRegion("ToggleToStandard",   {text: "Mode: Repeat", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [], mode: "hover", hoverDelay: 1000, specialHook: "showStandardOverlay"})

    Overlays.Standard.newState := true
    Overlays.Repeat.newState := false
  }

  setRegionPositions() {
    global
    ; The menubar sits at the top of the window and is not usable screen space,
    ; so it is treated as a y offset and excluded from the usable height
    menuH   := 21
    usableH := this.windowH - menuH

    scaleH  := usableH / 640
    centerX := Floor(this.windowW / 2)
    centerY := menuH + Floor(usableH / 2)

    ; Movement (fixed margins from the usable area edges)
    margin := Floor(30 * scaleH)
    long   := Floor(250 * scaleH)
    short  := Floor(40 * scaleH)
    moveDownY := menuH + usableH - margin - short

    ; Button row above MoveDown, spanning its width
    gap    := Floor(4 * scaleH)
    btnW   := Floor((long - 5 * gap) / 6)
    rowGap := Floor(20 * scaleH)
    btnY   := moveDownY - rowGap - short
    rowX   := centerX - Floor((6 * btnW + 5 * gap) / 2)
    step   := btnW + gap

    ; Toggle button (bottom right corner)
    toggleW := Floor(110 * scaleH)
    toggleX := this.windowW - margin - toggleW

    For mgIdx, mgCfg in this.getOverlayConfigs() {
      mgRegions := Overlays[mgCfg.name].regions[mgCfg.mode]
      mgP := mgCfg.prefix
      mgRegions[mgP . "MoveUp"].updateOpts(    {x: centerX - Floor(long / 2),     y: menuH + margin,            w: long,  h: short})
      mgRegions[mgP . "MoveDown"].updateOpts(  {x: centerX - Floor(long / 2),     y: moveDownY,                 w: long,  h: short})
      mgRegions[mgP . "MoveLeft"].updateOpts(  {x: margin,                        y: centerY - Floor(long / 2), w: short, h: long})
      mgRegions[mgP . "MoveRight"].updateOpts( {x: this.windowW - margin - short, y: centerY - Floor(long / 2), w: short, h: long})

      mgRegions[mgP . "BtnL"].updateOpts(      {x: rowX,            y: btnY, w: btnW, h: short})
      mgRegions[mgP . "BtnR"].updateOpts(      {x: rowX + step,     y: btnY, w: btnW, h: short})
      mgRegions[mgP . "BtnSelect"].updateOpts( {x: rowX + step * 2, y: btnY, w: btnW, h: short})
      mgRegions[mgP . "BtnStart"].updateOpts(  {x: rowX + step * 3, y: btnY, w: btnW, h: short})
      mgRegions[mgP . "BtnB"].updateOpts(      {x: rowX + step * 4, y: btnY, w: btnW, h: short})
      mgRegions[mgP . "BtnA"].updateOpts(      {x: rowX + step * 5, y: btnY, w: btnW, h: short})
    }

    Overlays.Standard.regions.hover.ToggleToRepeat.updateOpts(   {x: toggleX, y: moveDownY, w: toggleW, h: short})
    Overlays.Repeat.regions.hover.ToggleToStandard.updateOpts(   {x: toggleX, y: moveDownY, w: toggleW, h: short})
  }

  ; Hooks
  hook_Special(region) {
    global
    if (region.curState) {
      if (region.specialHook = "showRepeatOverlay") {
        Overlays.Standard.newState := false
        Overlays.Repeat.newState := true
      }
      if (region.specialHook = "showStandardOverlay") {
        Overlays.Repeat.newState := false
        Overlays.Standard.newState := true
      }
    }
  }
}
GAME_CLASSES.Push({cls: "Mgba", title: "mGBA -", matchMode: 1})
