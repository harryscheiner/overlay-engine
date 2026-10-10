Class Valheim extends Game {
  ; NOTE: Regions are positioned responsively, scaled from an 867x726 baseline resolution
  menuClearTicks := 0 ; Menu-visibility debounce counter
  confirmedInGame := false ; Re-armed when the Log Off dialog closes - see hook_MidOverlayLoop
  logOffWasOpen := false
  pendingLogoffReset := false
  setKeys() {
    global
    ; Skills
    Keys.PrimaryAttack := new Key("Numpad1")
    Keys.SecondaryAttack := new Key("MButton")
    Keys.Block := new Key("RButton")
    ; Movement
    Keys.MoveUp := new Key("w")
    Keys.MoveLeft := new Key("a")
    Keys.MoveDown := new Key("s")
    Keys.MoveRight := new Key("d")
    Keys.AutoWalk := new Key("q")
    Keys.Jump := new Key("Space")
    Keys.TeleportHome := new Key("Home")
    Keys.TeleportToHarry := new Key("PgUp")
    Keys.TeleportToKatie := new Key("PgDn")
    Keys.TeleportToSteve := new Key("End")
    Keys.TeleportToDavid := new Key("Insert")
    ; Camera
    Keys.CameraUp := new Key("Up")
    Keys.CameraLeft := new Key("Left")
    Keys.CameraDown := new Key("Down")
    Keys.CameraRight := new Key("Right")
    ; Misc
    Keys.Inventory := new Key("Tab")
    Keys.Use := new Key("e")
    Keys.Power := new Key("f")
    Keys.Sit := new Key("x")
    Keys.Map := new Key("m")
    ; General
    Keys.PauseMenu := new Key("Esc")
    ; Map
    Keys.ZoomIn := new Key(".")
    Keys.ZoomOut := new Key(",")
    ; Keys.Map already declared above
    ; Keys.SecondaryAttack for Ping
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.Map := new Overlay({transparency: 150}) ; Zoom In / Zoom Out
    Overlays.HUDCenter := new Overlay({transparency: 120}) ; Skills, Misc
    Overlays.Movement := new Overlay({transparency: 120}) ; Move
    Overlays.Camera := new Overlay({transparency: 120}) ; Camera
    Overlays.Attack := new Overlay({transparency: 120}) ; Primary/Secondary Attack, Block
    Overlays.General := new Overlay({transparency: 120}) ; General
  }

  setGameUIElements() {
    global
    ; Game UI Elements
    ; Pause Menu
    GameUIElements.PauseMenuOpen := new GameUIElement({x: 585, y: 185, w: 200, h: 40, image: A_ScriptDir . "\app\Games\images\valheim\pause-menu-line.png", variance: 35, trans: "FF00FF"})

    ; Log Off
    GameUIElements.LogOffButtonYes := new GameUIElement({x: 601, y: 281, w: 72, h: 46, image: A_ScriptDir . "\app\Games\images\valheim\logoff-yes.png", variance: 30, trans: "FF00FF"})
    GameUIElements.LogOffButtonNo  := new GameUIElement({x: 697, y: 281, w: 61, h: 46, image: A_ScriptDir . "\app\Games\images\valheim\logoff-no.png",  variance: 30, trans: "FF00FF", dependency: GameUIElements.LogOffButtonYes})

    ; Map
    GameUIElements.MapIconCluster := new GameUIElement({x: 1183, y: 437, w: 73, h: 226, image: A_ScriptDir . "\app\Games\images\valheim\map-icons.png", variance: 30, trans: "FF00FF"})

    ; Health symbol (bottom left) - present whenever we're actually in a game world
    GameUIElements.HealthSymbol := new GameUIElement({x: 50, y: 691, w: 60, h: 54, image: A_ScriptDir . "\app\Games\images\valheim\health-symbol.png", variance: 100, trans: "FF00FF"})

    ; Trophy icon (top-right) - shown whenever inventory/crafting/a chest is open
    GameUIElements.InventoryOpen := new GameUIElement({x: 1170, y: 44, w: 66, h: 72, image: A_ScriptDir . "\app\Games\images\valheim\trophy-icon.png", variance: 40, trans: "FF00FF"})
  }

  setRegions() {
    global
    ; Overlay: Zoom
    Overlays.Map.addRegion("ZoomIn",   {text: "↑ In ↑",  color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.ZoomIn], mode: "hovertimer", time: 1000, hoverDelay: 500})
    Overlays.Map.addRegion("ZoomOut",  {text: "↓ Out ↓", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.ZoomOut], mode: "hovertimer", time: 1000, hoverDelay: 500})
    ; Single press via specialHook (not a key hold) to avoid double-toggling the map
    Overlays.Map.addRegion("Map",      {text: "Close",    color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [], mode: "hover", hoverDelay: 500, specialHook: "pressMap"})
    Overlays.Map.addRegion("Ping",     {text: "Ping",     color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.SecondaryAttack], mode: "hovertimer", time: 1000})

    ; Overlay: HUDCenter
    Overlays.HUDCenter.addRegion("Inventory",       {text: "Inv",  color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.Inventory], mode: "hover", hoverDelay: 500})
    Overlays.HUDCenter.addRegion("Use",             {text: "Use",  color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.Use], mode: "hover", hoverDelay: 500})
    Overlays.HUDCenter.addRegion("Power",           {text: "Power",  color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.Power], mode: "hover", hoverDelay: 500})
    ;Overlays.HUDCenter.addRegion("Sit",             {text: "Sit",  color: "0x164375", colorOff: "0x000000", background: "0x3088F3", keys: [Keys.Sit], mode: "press"})
    Overlays.HUDCenter.addRegion("Map",             {text: "Map",  color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [], mode: "hover", hoverDelay: 500, specialHook: "pressMap"})

    ; Overlay: General
    Overlays.General.addRegion("PauseMenu",       {text: "Esc",  color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.PauseMenu], mode: "hover", hoverDelay: 500})

    ; Overlay: Camera
    Overlays.Camera.addRegion("CameraUp",         {text: "↑", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraUp], mode: "hover"})
    Overlays.Camera.addRegion("CameraLeft",       {text: "↶", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraLeft], mode: "hover"})
    Overlays.Camera.addRegion("CameraRight",      {text: "↷", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraRight], mode: "hover"})
    Overlays.Camera.addRegion("CameraDown",       {text: "↓", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraDown], mode: "hover"})

    ; Overlay: Attack
    Overlays.Attack.addRegion("SecondaryAttack", {text: "Atk2", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.SecondaryAttack], mode: "hover", hoverDelay: 500})
    Overlays.Attack.addRegion("PrimaryAttack",   {text: "Atk1", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.PrimaryAttack], mode: "hover", hoverDelay: 500})
    Overlays.Attack.addRegion("Block",           {text: "Block", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.Block], mode: "hover", hoverDelay: 500})

    ; Overlay: Movement
    Overlays.Movement.addRegion("MoveUp",           {text: "↑", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveUp], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpRight",      {text: "↗", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveUp, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveRight",        {text: "→", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownRight",    {text: "↘", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveDown, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDown",         {text: "↓", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveDown], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownLeft",     {text: "↙", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveDown, Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveLeft",         {text: "←", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpLeft",       {text: "↖", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveUp, Keys.MoveLeft], mode: "hover"})

    Overlays.Movement.addRegion("JumpAutoWalk",     {text: "Jump ↑↑", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.Jump, Keys.AutoWalk], mode: "hovertimer", time: 500})
    ;Overlays.Movement.addRegion("AutoWalk",         {text: "↑↑", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.AutoWalk], mode: "hover", hoverDelay: 500})
    Overlays.Movement.addRegion("TeleportHome",     {text: "Home", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.TeleportHome], mode: "hovertimer", time: 1000})
    Overlays.Movement.addRegion("TeleportToHarry",  {text: "H", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.TeleportToHarry], mode: "hovertimer", time: 1000})
    Overlays.Movement.addRegion("TeleportToKatie",  {text: "K", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.TeleportToKatie], mode: "hovertimer", time: 1000})
    Overlays.Movement.addRegion("TeleportToSteve",  {text: "S", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.TeleportToSteve], mode: "hovertimer", time: 1000})
    Overlays.Movement.addRegion("TeleportToDavid",  {text: "D", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.TeleportToDavid], mode: "hovertimer", time: 1000})
  }

  setRegionPositions() {
    global
    scaleH  := this.windowH / 726
    centerX := Floor(this.windowW / 2)
    centerY := Floor(this.windowH / 2)

    ; Overlay: Map (anchored relative to screen center)
    ; ZoomIn/ZoomOut: fixed margins, left of the filter icons, above "Visible to other players"
    Overlays.Map.regions.hovertimer.ZoomIn.updateOpts( {x: this.windowW - 238, y: this.windowH - 228, w: 50, h: 50})
    Overlays.Map.regions.hovertimer.ZoomOut.updateOpts({x: this.windowW - 238, y: this.windowH - 176, w: 50, h: 50})
    ; Close sits directly above ZoomIn (10px gap), same width, half the height
    Overlays.Map.regions.hover.Map.updateOpts(         {x: this.windowW - 238, y: this.windowH - 263, w: 50, h: 25})
    Overlays.Map.regions.hovertimer.Ping.updateOpts(   {x: centerX - Floor(24 * scaleH), y: centerY + Floor(24 * scaleH), w: Floor(50 * scaleH), h: Floor(30 * scaleH)})

    ; Overlay: Attack (anchored relative to screen center)
    rowGap := 2

    ; PrimaryAttack's x/w are derived from Atk2/Block's edges, same as Power below
    atkY := centerY - Floor(162 * scaleH)
    atkH := Floor(34 * scaleH)
    secX := centerX - Floor(70 * scaleH)
    secW := Floor(44 * scaleH)
    blockX := centerX + Floor(28 * scaleH)
    blockW := Floor(44 * scaleH)
    Overlays.Attack.regions.hover.SecondaryAttack.updateOpts({x: secX, y: atkY, w: secW, h: atkH})
    Overlays.Attack.regions.hover.Block.updateOpts(          {x: blockX, y: atkY, w: blockW, h: atkH})
    Overlays.Attack.regions.hover.PrimaryAttack.updateOpts(  {x: secX + secW + rowGap, y: atkY, w: blockX - rowGap - (secX + secW + rowGap), h: atkH})

    ; Overlay: HUDCenter (anchored relative to screen center)
    ; 3x2 grid: row1 (Inv/Power/Use), row2 (Esc/JumpAutoWalk/Map) 2px below.
    ; Power's x/w are derived from Inv/Use's edges to keep the gap exact.
    row1Y := centerY + Floor(140 * scaleH)
    row2Y := row1Y + atkH + rowGap
    invX := centerX - Floor(70 * scaleH)
    invW := Floor(44 * scaleH)
    useX := centerX + Floor(28 * scaleH)
    Overlays.HUDCenter.regions.hover.Inventory.updateOpts({x: invX, y: row1Y, w: invW, h: atkH})
    Overlays.HUDCenter.regions.hover.Use.updateOpts(       {x: useX, y: row1Y, w: Floor(44 * scaleH), h: atkH})
    Overlays.HUDCenter.regions.hover.Power.updateOpts(     {x: invX + invW + rowGap, y: row1Y, w: useX - rowGap - (invX + invW + rowGap), h: atkH})

    Overlays.HUDCenter.regions.hover.Map.updateOpts(            {x: centerX + Floor(28 * scaleH), y: row2Y, w: Floor(44 * scaleH), h: atkH})

    ; Overlay: General (anchored relative to screen center)
    Overlays.General.regions.hover.PauseMenu.updateOpts({x: centerX - Floor(70 * scaleH), y: row2Y, w: Floor(44 * scaleH), h: atkH})

    ; Overlay: Movement (anchored relative to screen center)
    Overlays.Movement.regions.hover.MoveUp.updateOpts(          {x: centerX - Floor(25 * scaleH), y: centerY - Floor(85 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveUpRight.updateOpts(     {x: centerX + Floor(24 * scaleH), y: centerY - Floor(68 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})
    Overlays.Movement.regions.hover.MoveRight.updateOpts(       {x: centerX + Floor(35 * scaleH), y: centerY - Floor(25 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveDownRight.updateOpts(   {x: centerX + Floor(24 * scaleH), y: centerY + Floor(24 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})
    Overlays.Movement.regions.hover.MoveDown.updateOpts(        {x: centerX - Floor(25 * scaleH), y: centerY + Floor(35 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveDownLeft.updateOpts(    {x: centerX - Floor(68 * scaleH), y: centerY + Floor(24 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})
    Overlays.Movement.regions.hover.MoveLeft.updateOpts(        {x: centerX - Floor(85 * scaleH), y: centerY - Floor(25 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveUpLeft.updateOpts(      {x: centerX - Floor(68 * scaleH), y: centerY - Floor(68 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})

    ; JumpAutoWalk completes the grid's row2, centered under Power (same row as Esc/Map)
    Overlays.Movement.regions.hovertimer.JumpAutoWalk.updateOpts({x: centerX - Floor(24 * scaleH), y: row2Y, w: Floor(50 * scaleH), h: atkH})
    ;Overlays.Movement.regions.hover.AutoWalk.updateOpts(         {x: centerX - Floor(24 * scaleH), y: centerY - Floor(162 * scaleH), w: Floor(50 * scaleH), h: Floor(22 * scaleH)})

    ; Overlay: Camera (fixed margins from screen edges)
    margin := 70
    Overlays.Camera.regions.hover.CameraUp.updateOpts(    {x: centerX - 125,              y: margin,                     w: 250, h: 40})
    Overlays.Camera.regions.hover.CameraDown.updateOpts(  {x: centerX - 125,              y: this.windowH - margin - 40, w: 250, h: 40})
    Overlays.Camera.regions.hover.CameraLeft.updateOpts(  {x: margin,                     y: centerY - 125,              w: 40,  h: 250})
    Overlays.Camera.regions.hover.CameraRight.updateOpts( {x: this.windowW - margin - 40, y: centerY - 125,              w: 40,  h: 250})

    ; Teleport row: flush with the bottom (2px margin), same width as CameraDown,
    ; H/K/S/D square, Home fills the rest, 2px gaps between buttons
    teleportY := this.windowH - 42
    Overlays.Movement.regions.hovertimer.TeleportHome.updateOpts(   {x: centerX - 125, y: teleportY, w: 82, h: 40})
    Overlays.Movement.regions.hovertimer.TeleportToHarry.updateOpts({x: centerX - 41,  y: teleportY, w: 40, h: 40})
    Overlays.Movement.regions.hovertimer.TeleportToKatie.updateOpts({x: centerX + 1,   y: teleportY, w: 40, h: 40})
    Overlays.Movement.regions.hovertimer.TeleportToSteve.updateOpts({x: centerX + 43,  y: teleportY, w: 40, h: 40})
    Overlays.Movement.regions.hovertimer.TeleportToDavid.updateOpts({x: centerX + 85,  y: teleportY, w: 40, h: 40})
  }

  ; Hooks
  hook_Special(region) {
    global
    if (region.curState && region.specialHook = "pressMap") {
      key := Keys.Map.key
      Send, {%key%}
    }
  }

  hook_MidOverlayLoop() {
    global
    ; Latches true once the health symbol is seen, so later misses can't hide
    ; everything mid-game. Re-armed on Log Off, but held pending until the health
    ; symbol is also gone (it lingers a tick after the dialog closes).
    logOffOpen := GameUIElements.LogOffButtonNo.curState
    if (this.logOffWasOpen && !logOffOpen)
      this.pendingLogoffReset := true
    this.logOffWasOpen := logOffOpen

    if (this.pendingLogoffReset) {
      this.confirmedInGame := false
      if (!GameUIElements.HealthSymbol.curState)
        this.pendingLogoffReset := false
    } else if (!this.confirmedInGame && GameUIElements.HealthSymbol.curState) {
      this.confirmedInGame := true
    }
    inGame := this.confirmedInGame

    ; Check state of GameUIElements and set state of Overlays accordingly
    Overlays.Map.newState := inGame && GameUIElements.MapIconCluster.curState

    ; Debounce: require 2 consecutive clear ticks before showing Movement again
    menuOpen := GameUIElements.PauseMenuOpen.curState || GameUIElements.LogOffButtonNo.curState || GameUIElements.MapIconCluster.curState
    this.menuClearTicks := menuOpen ? 0 : this.menuClearTicks + 1

    Overlays.Movement.newState := inGame && this.menuClearTicks >= 2
    Overlays.HUDCenter.newState := Overlays.Movement.newState ; Same as Movement

    ; Camera/Attack also hide instantly (no debounce) while inventory is open
    Overlays.Camera.newState := Overlays.Movement.newState && !GameUIElements.InventoryOpen.curState
    Overlays.Attack.newState := Overlays.Movement.newState && !GameUIElements.InventoryOpen.curState
    Overlays.General.newState := inGame
  }
}
GAME_CLASSES.Push({cls: "Valheim", title: "Valheim"})