Class Valheim extends Game {
  ; NOTE: Regions are positioned responsively, scaled from an 867x726 baseline resolution
  menuClearTicks := 0 ; Menu-visibility debounce counter
  setKeys() {
    global
    ; Skills
    ;Keys.PrimaryAttack := new Key("LButton")
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
    Overlays.Movement := new Overlay({transparency: 120}) ; Move, Camera
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
  }

  setRegions() {
    global
    ; Overlay: Zoom
    Overlays.Map.addRegion("ZoomIn",   {text: "↑ In ↑",  color: "0x000000", background: "0x3088F3", keys: [Keys.ZoomIn], mode: "press"})
    Overlays.Map.addRegion("ZoomOut",  {text: "↓ Out ↓", color: "0x000000", background: "0x3088F3", keys: [Keys.ZoomOut], mode: "press"})
    Overlays.Map.addRegion("Map",      {text: "Map",      color: "0x000000", background: "0x3088F3", keys: [Keys.Map], mode: "press"})
    Overlays.Map.addRegion("Ping",     {text: "Ping",     color: "0x000000", background: "0x3088F3", keys: [Keys.SecondaryAttack], mode: "press"})

    ; Overlay: HUDCenter
    Overlays.HUDCenter.addRegion("SecondaryAttack", {text: "Atk2", color: "0x000000", background: "0x3088F3", keys: [Keys.SecondaryAttack], mode: "hold"})
    Overlays.HUDCenter.addRegion("Block",           {text: "Block", color: "0x000000", background: "0x3088F3", keys: [Keys.Block], mode: "hold"})
    Overlays.HUDCenter.addRegion("Inventory",       {text: "Inv",  color: "0x000000", background: "0x3088F3", keys: [Keys.Inventory], mode: "press"})
    Overlays.HUDCenter.addRegion("Use",             {text: "Use",  color: "0x000000", background: "0x3088F3", keys: [Keys.Use], mode: "press"})
    Overlays.HUDCenter.addRegion("Power",           {text: "Power",  color: "0x000000", background: "0x3088F3", keys: [Keys.Power], mode: "press"})
    ;Overlays.HUDCenter.addRegion("Sit",             {text: "Sit",  color: "0x000000", background: "0x3088F3", keys: [Keys.Sit], mode: "press"})
    Overlays.HUDCenter.addRegion("Map",             {text: "Map",  color: "0x000000", background: "0x3088F3", keys: [Keys.Map], mode: "press"})

    ; Overlay: General
    Overlays.General.addRegion("PauseMenu",       {text: "Esc",  color: "0x000000", background: "0x3088F3", keys: [Keys.PauseMenu], mode: "press"})

    ; Overlay: Movement
    Overlays.Movement.addRegion("MoveUp",           {text: "↑", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveUp], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpRight",      {text: "↗", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveUp, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveRight",        {text: "→", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownRight",    {text: "↘", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveDown, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDown",         {text: "↓", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveDown], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownLeft",     {text: "↙", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveDown, Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveLeft",         {text: "←", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpLeft",       {text: "↖", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.MoveUp, Keys.MoveLeft], mode: "hover"})

    Overlays.Movement.addRegion("JumpAutoWalk",     {text: "Jump ↑↑", color: "0x000000", background: "0x3088F3", keys: [Keys.Jump, Keys.AutoWalk], mode: "press"})
    Overlays.Movement.addRegion("AutoWalk",         {text: "↑↑", color: "0x000000", background: "0x3088F3", keys: [Keys.AutoWalk], mode: "press"})
    Overlays.Movement.addRegion("CameraUp",         {text: "↑", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraUp], mode: "hover"})
    Overlays.Movement.addRegion("CameraLeft",       {text: "↶", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraLeft], mode: "hover"})
    Overlays.Movement.addRegion("CameraRight",      {text: "↷", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraRight], mode: "hover"})
    Overlays.Movement.addRegion("CameraDown",       {text: "↓", color: "0x164375", colorOff: "0x000000", background: "0x3088F3", backgroundOff: "0x3088F3", keys: [Keys.CameraDown], mode: "hover"})
    Overlays.Movement.addRegion("TeleportHome",     {text: "Home", color: "0x000000", background: "0x3088F3", keys: [Keys.TeleportHome], mode: "press"})
    Overlays.Movement.addRegion("TeleportToHarry",  {text: "H", color: "0x000000", background: "0x3088F3", keys: [Keys.TeleportToHarry], mode: "press"})
    Overlays.Movement.addRegion("TeleportToKatie",  {text: "K", color: "0x000000", background: "0x3088F3", keys: [Keys.TeleportToKatie], mode: "press"})
    Overlays.Movement.addRegion("TeleportToSteve",  {text: "S", color: "0x000000", background: "0x3088F3", keys: [Keys.TeleportToSteve], mode: "press"})
    Overlays.Movement.addRegion("TeleportToDavid",  {text: "D", color: "0x000000", background: "0x3088F3", keys: [Keys.TeleportToDavid], mode: "press"})
  }

  setRegionPositions() {
    global
    scaleH  := this.windowH / 726
    centerX := Floor(this.windowW / 2)
    centerY := Floor(this.windowH / 2)

    ; Overlay: Map (anchored relative to screen center)
    Overlays.Map.regions.press.ZoomIn.updateOpts(  {x: centerX - Floor(24 * scaleH), y: centerY + Floor(56 * scaleH), w: Floor(50 * scaleH), h: Floor(16 * scaleH)})
    Overlays.Map.regions.press.ZoomOut.updateOpts( {x: centerX - Floor(24 * scaleH), y: centerY + Floor(74 * scaleH), w: Floor(50 * scaleH), h: Floor(16 * scaleH)})
    Overlays.Map.regions.press.Map.updateOpts(     {x: centerX + Floor(28 * scaleH), y: centerY + Floor(66 * scaleH), w: Floor(30 * scaleH), h: Floor(16 * scaleH)})
    Overlays.Map.regions.press.Ping.updateOpts(    {x: centerX - Floor(24 * scaleH), y: centerY + Floor(24 * scaleH), w: Floor(50 * scaleH), h: Floor(30 * scaleH)})

    ; Overlay: HUDCenter (anchored relative to screen center)
    Overlays.HUDCenter.regions.hold.SecondaryAttack.updateOpts( {x: centerX - Floor(70 * scaleH), y: centerY - Floor(112 * scaleH), w: Floor(44 * scaleH), h: Floor(22 * scaleH)})
    Overlays.HUDCenter.regions.hold.Block.updateOpts(           {x: centerX + Floor(28 * scaleH), y: centerY - Floor(112 * scaleH), w: Floor(44 * scaleH), h: Floor(22 * scaleH)})
    Overlays.HUDCenter.regions.press.Inventory.updateOpts(      {x: centerX - Floor(70 * scaleH), y: centerY + Floor(90 * scaleH), w: Floor(44 * scaleH), h: Floor(22 * scaleH)})
    Overlays.HUDCenter.regions.press.Use.updateOpts(            {x: centerX + Floor(28 * scaleH), y: centerY + Floor(90 * scaleH), w: Floor(44 * scaleH), h: Floor(22 * scaleH)})
    Overlays.HUDCenter.regions.press.Power.updateOpts(          {x: centerX - Floor(24 * scaleH), y: centerY + Floor(90 * scaleH), w: Floor(50 * scaleH), h: Floor(22 * scaleH)})
    Overlays.HUDCenter.regions.press.Map.updateOpts(            {x: centerX + Floor(28 * scaleH), y: centerY + Floor(114 * scaleH), w: Floor(44 * scaleH), h: Floor(22 * scaleH)})

    ; Overlay: General (anchored relative to screen center)
    Overlays.General.regions.press.PauseMenu.updateOpts( {x: centerX - Floor(70 * scaleH), y: centerY + Floor(114 * scaleH), w: Floor(44 * scaleH), h: Floor(22 * scaleH)})

    ; Overlay: Movement (anchored relative to screen center)
    Overlays.Movement.regions.hover.MoveUp.updateOpts(          {x: centerX - Floor(25 * scaleH), y: centerY - Floor(85 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveUpRight.updateOpts(     {x: centerX + Floor(24 * scaleH), y: centerY - Floor(68 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})
    Overlays.Movement.regions.hover.MoveRight.updateOpts(       {x: centerX + Floor(35 * scaleH), y: centerY - Floor(25 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveDownRight.updateOpts(   {x: centerX + Floor(24 * scaleH), y: centerY + Floor(24 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})
    Overlays.Movement.regions.hover.MoveDown.updateOpts(        {x: centerX - Floor(25 * scaleH), y: centerY + Floor(35 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveDownLeft.updateOpts(    {x: centerX - Floor(68 * scaleH), y: centerY + Floor(24 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})
    Overlays.Movement.regions.hover.MoveLeft.updateOpts(        {x: centerX - Floor(85 * scaleH), y: centerY - Floor(25 * scaleH), w: Floor(50 * scaleH), h: Floor(50 * scaleH)})
    Overlays.Movement.regions.hover.MoveUpLeft.updateOpts(      {x: centerX - Floor(68 * scaleH), y: centerY - Floor(68 * scaleH), w: Floor(44 * scaleH), h: Floor(44 * scaleH)})

    Overlays.Movement.regions.press.JumpAutoWalk.updateOpts(   {x: centerX - Floor(24 * scaleH), y: centerY - Floor(136 * scaleH), w: Floor(50 * scaleH), h: Floor(22 * scaleH)})
    Overlays.Movement.regions.press.AutoWalk.updateOpts(       {x: centerX - Floor(24 * scaleH), y: centerY - Floor(112 * scaleH), w: Floor(50 * scaleH), h: Floor(22 * scaleH)})

    ; Camera (fixed margins from screen edges)
    margin := 70
    Overlays.Movement.regions.hover.CameraUp.updateOpts(    {x: centerX - 125,              y: margin,                     w: 250, h: 40})
    Overlays.Movement.regions.hover.CameraDown.updateOpts(  {x: centerX - 125,              y: this.windowH - margin - 40, w: 250, h: 40})
    Overlays.Movement.regions.hover.CameraLeft.updateOpts(  {x: margin,                     y: centerY - 125,              w: 40,  h: 250})
    Overlays.Movement.regions.hover.CameraRight.updateOpts( {x: this.windowW - margin - 40, y: centerY - 125,              w: 40,  h: 250})

    Overlays.Movement.regions.press.TeleportHome.updateOpts(   {x: centerX - Floor(24 * scaleH), y: centerY + Floor(144 * scaleH), w: Floor(50 * scaleH), h: Floor(22 * scaleH)})
    Overlays.Movement.regions.press.TeleportToHarry.updateOpts({x: centerX - Floor(42 * scaleH), y: centerY + Floor(172 * scaleH), w: Floor(20 * scaleH), h: Floor(22 * scaleH)})
    Overlays.Movement.regions.press.TeleportToKatie.updateOpts({x: centerX - Floor(20 * scaleH), y: centerY + Floor(172 * scaleH), w: Floor(20 * scaleH), h: Floor(22 * scaleH)})
    Overlays.Movement.regions.press.TeleportToSteve.updateOpts({x: centerX + Floor(2 * scaleH),  y: centerY + Floor(172 * scaleH), w: Floor(20 * scaleH), h: Floor(22 * scaleH)})
    Overlays.Movement.regions.press.TeleportToDavid.updateOpts({x: centerX + Floor(24 * scaleH), y: centerY + Floor(172 * scaleH), w: Floor(20 * scaleH), h: Floor(22 * scaleH)})
  }

  ; Hooks
  hook_MidOverlayLoop() {
    global
    ; Check state of GameUIElements and set state of Overlays accordingly
    Overlays.Map.newState := GameUIElements.MapIconCluster.curState

    ; Debounce: require 2 consecutive clear ticks before showing Movement again
    menuOpen := GameUIElements.PauseMenuOpen.curState || GameUIElements.LogOffButtonNo.curState || GameUIElements.MapIconCluster.curState
    this.menuClearTicks := menuOpen ? 0 : this.menuClearTicks + 1

    Overlays.Movement.newState := this.menuClearTicks >= 2
    Overlays.HUDCenter.newState := Overlays.Movement.newState ; Same as Movement
    Overlays.General.newState := true ; Always visible
  }
}
GAME_CLASSES.Push({cls: "Valheim", title: "Valheim"})