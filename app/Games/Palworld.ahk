Class Palworld extends Game {
  ; NOTE: Default coordinates expect game to be running at 1366x768 resolution
  setKeys() {
    global
    ; Movement
    Keys.MoveUp := new Key("w")
    Keys.MoveLeft := new Key("a")
    Keys.MoveDown := new Key("s")
    Keys.MoveRight := new Key("d")
    ; Camera
    Keys.CameraUp := new Key("Up")
    Keys.CameraLeft := new Key("Left")
    Keys.CameraDown := new Key("Down")
    Keys.CameraRight := new Key("Right")
    ; General
    Keys.Attack := new Key("LButton")
    Keys.Jump := new Key("Space")
    Keys.Use := new Key("f")
    Keys.Crouch := new Key("c")
    Keys.ReloadWeapon := new Key("r")
    Keys.PalSphere := new Key("q")
    ; Inventory
    Keys.Inventory := new Key("Tab")
    Keys.Build := new Key("b")
    Keys.Map := new Key("m")
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.Movement := new Overlay({transparency: 170})
    Overlays.Camera := new Overlay({transparency: 120})
    Overlays.General := new Overlay({transparency: 170})
    Overlays.Inventory := new Overlay({transparency: 170})
    Overlays.Special := new Overlay({transparency: 170})
    Overlays.Cursor := new Overlay({transparency: 255}) ; Faux Cursor
  }

  setGameUIElements() {
    global
    GameUIElements.InventoryOpen  := new GameUIElement({x: 60,  y: 30,  w: 25, h: 30, image: A_ScriptDir . "\app\Games\images\palworld\inv-open-arrows.png",  variance: 30, trans: "FF00FF"})
    GameUIElements.CraftingOpen   := new GameUIElement({x: 240, y: 130, w: 20, h: 35, image: A_ScriptDir . "\app\Games\images\palworld\crafting-left.png",    variance: 30, trans: "FF00FF"})
    ;GameUIElements.CraftingOther  := new GameUIElement({x: 525, y: 725, w: 20, h: 20, image: A_ScriptDir . "\app\Games\images\palworld\build-other.png",      variance: 30, trans: "FF00FF"})
    GameUIElements.MapOpen        := new GameUIElement({x: 110, y: 90,  w: 70, h: 65, image: A_ScriptDir . "\app\Games\images\palworld\map-corner.png",       variance: 30, trans: "FF00FF"})
    GameUIElements.SettingsOpen   := new GameUIElement({x: 70,  y: 25,  w: 35, h: 50, image: A_ScriptDir . "\app\Games\images\palworld\settings-s.png",       variance: 30, trans: "FF00FF"})
    GameUIElements.WheelOpen      := new GameUIElement({x: 540, y: 360, w: 15, h: 40, image: A_ScriptDir . "\app\Games\images\palworld\wheel-left.png",       variance: 30, trans: "FF00FF"})
    GameUIElements.WorkbenchOpen  := new GameUIElement({x: 340, y: 100, w: 15, h: 35, image: A_ScriptDir . "\app\Games\images\palworld\workbench-left.png",   variance: 30, trans: "FF00FF"})
    GameUIElements.HealthBar      := new GameUIElement({x: 30,  y: 695, w: 20, h: 20, image: A_ScriptDir . "\app\Games\images\palworld\healthbar.png",        variance: 30, trans: "FF00FF"})
  }

  setRegions() {
    global
    ; Overlay: Movement
    Overlays.Movement.addRegion("MoveUp",           {text: "↑", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveUp], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpRight",      {text: "↗", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveUp, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveRight",        {text: "→", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownRight",    {text: "↘", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveDown, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDown",         {text: "↓", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveDown], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownLeft",     {text: "↙", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveDown, Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveLeft",         {text: "←", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpLeft",       {text: "↖", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveUp, Keys.MoveLeft], mode: "hover"})

    ; Overlay: Camera
    Overlays.Camera.addRegion("CameraUp",           {text: "↑", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraUp], mode: "hovertimer", time: 1})
    Overlays.Camera.addRegion("CameraRight",        {text: "→", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraRight], mode: "hovertimer", time: 1})
    Overlays.Camera.addRegion("CameraDown",         {text: "↓", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraDown], mode: "hovertimer", time: 1})
    Overlays.Camera.addRegion("CameraLeft",         {text: "←", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraLeft], mode: "hovertimer", time: 1})

    ; Overlay: General
    Overlays.General.addRegion("GenAttack",         {text: "Attack", color: "0x0e550a", colorOff: "0x550e0a", keys: [Keys.Attack], mode: "toggle"})
    Overlays.General.addRegion("GenJump",           {text: "Jump", color: "0x0e550a", colorOff: "0x550e0a", keys: [Keys.Jump], mode: "timer", time: 2000})
    Overlays.General.addRegion("OpenBuild",         {text: "Build", color: "0x000000", background: "0x3088F3", keys: [Keys.Build], mode: "press"})
    Overlays.General.addRegion("OpenMap",           {text: "Map", color: "0x000000", background: "0x3088F3", keys: [Keys.Map], mode: "press"})
    Overlays.General.addRegion("GenUse",            {text: "F", color: "0x000000", background: "0x3088F3", keys: [Keys.Use], mode: "press"})
    Overlays.General.addRegion("GenReload",         {text: "Reload", color: "0x000000", background: "0x3088F3", keys: [Keys.ReloadWeapon], mode: "press"})
    Overlays.General.addRegion("GenCrouch",         {text: "Crouch", color: "0x000000", background: "0x3088F3", keys: [Keys.Crouch], mode: "press"})
    Overlays.General.addRegion("GenPalSphere",      {text: "Q", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.PalSphere], mode: "toggle"})

    ; Overlay: Inventory
    Overlays.Inventory.addRegion("OpenInv",         {text: "Inv", color: "0x000000", background: "0x3088F3", keys: [Keys.Inventory], mode: "press"})

    ; Overlay: Special
    Overlays.Special.addRegion("Teleport",          {text: "Teleport", color: "0x000000", background: "0x3088F3", x: 150, y: 10, w: 60, h: 20, keys: [], mode: "special", specialHook: "teleportToHarry"})
    Overlays.Special.addRegion("Repair",            {text: "Repair", color: "0x000000", background: "0x3088F3", x: 150, y: 32, w: 60, h: 20, keys: [], mode: "special", specialHook: "repairGear"})

    ; Overlay: Cursor
    Gui, % Overlays.Cursor.gui ": Add", Pic, x0 y0 w32 h32 vFauxCursor, % A_WinDir . "\Cursors\aero_arrow.cur"
  }

  setRegionPositions() {
    global
    scaleH  := this.windowH / 768
    centerX := Floor(this.windowW / 2)
    centerY := Floor(this.windowH / 2)

    ; Movement (centered in window, scaled from expected resolution)
    Overlays.Movement.regions.hover.MoveUp.updateOpts(        {x: centerX - Floor(25 * scaleH), y: centerY - Floor(85 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveUpRight.updateOpts(   {x: centerX + Floor(24 * scaleH), y: centerY - Floor(68 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})
    Overlays.Movement.regions.hover.MoveRight.updateOpts(     {x: centerX + Floor(35 * scaleH), y: centerY - Floor(25 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveDownRight.updateOpts( {x: centerX + Floor(24 * scaleH), y: centerY + Floor(24 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})
    Overlays.Movement.regions.hover.MoveDown.updateOpts(      {x: centerX - Floor(25 * scaleH), y: centerY + Floor(35 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveDownLeft.updateOpts(  {x: centerX - Floor(68 * scaleH), y: centerY + Floor(24 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})
    Overlays.Movement.regions.hover.MoveLeft.updateOpts(      {x: centerX - Floor(85 * scaleH), y: centerY - Floor(25 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveUpLeft.updateOpts(    {x: centerX - Floor(68 * scaleH), y: centerY - Floor(68 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})

    ; General (anchored relative to screen center)
    Overlays.General.regions.toggle.GenAttack.updateOpts(     {x: centerX - Floor(78 * scaleH), y: centerY + Floor(107 * scaleH), w: Floor(54 * scaleH), h: Floor(35 * scaleH)})
    Overlays.General.regions.timer.GenJump.updateOpts(        {x: centerX + Floor(24 * scaleH), y: centerY + Floor(107 * scaleH), w: Floor(54 * scaleH), h: Floor(35 * scaleH)})
    Overlays.General.regions.press.OpenBuild.updateOpts(      {x: centerX - Floor(117 * scaleH), y: centerY + Floor(225 * scaleH), w: Floor(46 * scaleH), h: Floor(40 * scaleH)})
    Overlays.General.regions.press.OpenMap.updateOpts(        {x: centerX - Floor(70 * scaleH),  y: centerY + Floor(225 * scaleH), w: Floor(46 * scaleH), h: Floor(40 * scaleH)})
    Overlays.General.regions.press.GenUse.updateOpts(         {x: centerX - Floor(23 * scaleH),  y: centerY + Floor(225 * scaleH), w: Floor(46 * scaleH), h: Floor(40 * scaleH)})
    Overlays.General.regions.press.GenReload.updateOpts(      {x: centerX + Floor(24 * scaleH),  y: centerY + Floor(225 * scaleH), w: Floor(46 * scaleH), h: Floor(40 * scaleH)})
    Overlays.General.regions.press.GenCrouch.updateOpts(      {x: centerX + Floor(71 * scaleH),  y: centerY + Floor(225 * scaleH), w: Floor(46 * scaleH), h: Floor(40 * scaleH)})
    Overlays.General.regions.toggle.GenPalSphere.updateOpts(  {x: centerX + Floor(118 * scaleH), y: centerY + Floor(225 * scaleH), w: Floor(46 * scaleH), h: Floor(40 * scaleH)})
    
    ; Inventory (anchored relative to screen center)
    Overlays.Inventory.regions.press.OpenInv.updateOpts(       {x: centerX - Floor(164 * scaleH), y: centerY + Floor(225 * scaleH), w: Floor(46 * scaleH), h: Floor(40 * scaleH)})

    ; Camera (fixed margins from screen edges)
    margin := 70
    Overlays.Camera.regions.hovertimer.CameraUp.updateOpts(   {x: centerX - 125,                 y: margin,                     w: 250, h: 40})
    Overlays.Camera.regions.hovertimer.CameraDown.updateOpts( {x: centerX - 125,                 y: this.windowH - margin - 40, w: 250, h: 40})
    Overlays.Camera.regions.hovertimer.CameraLeft.updateOpts( {x: margin,                        y: centerY - 125,              w: 40,  h: 250})
    Overlays.Camera.regions.hovertimer.CameraRight.updateOpts({x: this.windowW - margin - 40,    y: centerY - 125,              w: 40,  h: 250})
  }

  ; Hooks
  hook_Special(region) {
    global
    if (region.curState) {
      if (region.specialHook = "teleportToHarry") {
        Sleep 200
        Send, {Tab}
        Sleep 20
        Send, cheat TeleportToPlayerName Harry
        Send, {Enter}
      } else if (region.specialHook = "repairGear") {
        Sleep 200
        Send, {Tab}
        Sleep 20
        Send, cheat AddEquipmentDurability 99999
        Send, {Enter}
      }
    }
  }
  ; Hooks
  hook_MidOverlayLoop() {
    global

    MostMenusClosed := !GameUIElements.SettingsOpen.curState && !GameUIElements.MapOpen.curState && !GameUIElements.WheelOpen.curState && !GameUIElements.CraftingOpen.curState && !GameUIElements.WorkbenchOpen.curState

    Overlays.Movement.newState  := GameUIElements.HealthBar.curState && MostMenusClosed && !GameUIElements.InventoryOpen.curState
    Overlays.Camera.newState    := Overlays.Movement.newState
    Overlays.General.newState   := Overlays.Movement.newState
    Overlays.Inventory.newState := MostMenusClosed
    Overlays.Special.newState   := !GameUIElements.SettingsOpen.curState
    Overlays.Cursor.newState    := Overlays.Movement.newState

    ; Faux cursor since the game cursor can be a little funny sometimes
    MouseGetPos, xpos, ypos
    GuiControl, % Overlays.Cursor.gui ": MoveDraw", FauxCursor, % "+X" xpos " +Y" ypos

  }
}
GAME_CLASSES.Push({cls: "Palworld", title: "Pal  "})
