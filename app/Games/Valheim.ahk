Class Valheim extends Game {
  ; Init functions
  matchGame() {
    global
    SetTitleMatchMode 3
    GAME_TITLE := "Valheim"
    ; NOTE: All coordinates expect game to be running at 867x726 resolution with 115% GUI Scale
  }
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
    Keys.Teleport := new Key("End")
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
    GameUIElements.PauseMenuOrangeA := new GameUIElement({x: 375, y: 229, w: 1, h: 2, color: 0xf98b16, variance: 32})
    GameUIElements.PauseMenuOrangeB := new GameUIElement({x: 400, y: 229, w: 1, h: 2, color: 0xf98b16, variance: 32, dependency: GameUIElements.PauseMenuOrangeA})
    GameUIElements.PauseMenuOrangeC := new GameUIElement({x: 467, y: 229, w: 1, h: 2, color: 0xf98b16, variance: 32, dependency: GameUIElements.PauseMenuOrangeB})
    GameUIElements.PauseMenuOrangeD := new GameUIElement({x: 490, y: 229, w: 1, h: 2, color: 0xf98b16, variance: 32, dependency: GameUIElements.PauseMenuOrangeC})

    ; Log Off or Quit
    GameUIElements.LogOffButtonYes := new GameUIElement({x: 407, y: 305, w: 2, h: 2, color: 0xf59e00, variance: 8})
    GameUIElements.LogOffButtonNo  := new GameUIElement({x: 457, y: 305, w: 2, h: 2, color: 0xb1741f, variance: 8, dependency: GameUIElements.LogOffButtonYes})

    ; Map
    GameUIElements.MapIconFire  := new GameUIElement({x: 765, y: 510, w: 2, h: 2, color: 0xe3e3e3})
    GameUIElements.MapIconHouse := new GameUIElement({x: 765, y: 540, w: 2, h: 2, color: 0xc9c9c9, dependency: GameUIElements.MapIconFire})
    GameUIElements.MapIconT     := new GameUIElement({x: 765, y: 573, w: 2, h: 2, color: 0xdedede, dependency: GameUIElements.MapIconHouse})
    GameUIElements.MapIconDot   := new GameUIElement({x: 765, y: 615, w: 2, h: 2, color: 0xc9c9c9, dependency: GameUIElements.MapIconT})
  }

  setRegions() {
    global
    ; Overlay: Zoom
    Overlays.Map.addRegion("ZoomIn",   {text: "↑ In ↑",  color: "0x000000", background: "0x3088F3", x: 409, y: 419, w: 50, h: 16, keys: [Keys.ZoomIn], mode: "press"})
    Overlays.Map.addRegion("ZoomOut",  {text: "↓ Out ↓", color: "0x000000", background: "0x3088F3", x: 409, y: 437, w: 50, h: 16, keys: [Keys.ZoomOut], mode: "press"})
    Overlays.Map.addRegion("Map",      {text: "Map",      color: "0x000000", background: "0x3088F3", x: 461, y: 429, w: 30, h: 16, keys: [Keys.Map], mode: "press"})
    Overlays.Map.addRegion("Ping",     {text: "Ping",     color: "0x000000", background: "0x3088F3", x: 409, y: 387, w: 50, h: 30, keys: [Keys.SecondaryAttack], mode: "press"})

    ; Overlay: HUDCenter
    Overlays.HUDCenter.addRegion("SecondaryAttack", {text: "Atk2", color: "0x000000", background: "0x3088F3", x: 377, y: 277, w: 30, h: 16, keys: [Keys.SecondaryAttack], mode: "hold"})
    Overlays.HUDCenter.addRegion("Block",           {text: "Block", color: "0x000000", background: "0x3088F3", x: 461, y: 277, w: 30, h: 16, keys: [Keys.Block], mode: "hold"})
    Overlays.HUDCenter.addRegion("Inventory",       {text: "Inv",  color: "0x000000", background: "0x3088F3", x: 377, y: 411, w: 30, h: 16, keys: [Keys.Inventory], mode: "press"})
    Overlays.HUDCenter.addRegion("Use",             {text: "Use",  color: "0x000000", background: "0x3088F3", x: 461, y: 411, w: 30, h: 16, keys: [Keys.Use], mode: "press"})
    Overlays.HUDCenter.addRegion("Power",           {text: "Power",  color: "0x000000", background: "0x3088F3", x: 409, y: 437, w: 50, h: 16, keys: [Keys.Power], mode: "press"})
    Overlays.HUDCenter.addRegion("Sit",             {text: "Sit",  color: "0x000000", background: "0x3088F3", x: 409, y: 455, w: 50, h: 16, keys: [Keys.Sit], mode: "press"})
    Overlays.HUDCenter.addRegion("Map",             {text: "Map",  color: "0x000000", background: "0x3088F3", x: 461, y: 429, w: 30, h: 16, keys: [Keys.Map], mode: "press"})
    
    ; Overlay: General
    Overlays.General.addRegion("PauseMenu",       {text: "Esc",  color: "0x000000", background: "0x3088F3", x: 377, y: 429, w: 30, h: 16, keys: [Keys.PauseMenu], mode: "press"})

    ; Overlay: Movement
    Overlays.Movement.addRegion("MoveUp",           {text: "↑", color: "0x000000", background: "0x3088F3", x: 409, y: 287, w: 50, h: 30, keys: [Keys.RotateCamera, Keys.MoveUp], mode: "hold"})
    Overlays.Movement.addRegion("MoveUpRight",      {text: "↗", color: "0x000000", background: "0x3088F3", x: 461, y: 295, w: 30, h: 30, keys: [Keys.RotateCamera, Keys.MoveUp, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveRight",        {text: "→", color: "0x000000", background: "0x3088F3", x: 469, y: 327, w: 30, h: 50, keys: [Keys.RotateCamera, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveDownRight",    {text: "↘", color: "0x000000", background: "0x3088F3", x: 461, y: 379, w: 30, h: 30, keys: [Keys.RotateCamera, Keys.MoveDown, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveDown",         {text: "↓", color: "0x000000", background: "0x3088F3", x: 409, y: 387, w: 50, h: 30, keys: [Keys.RotateCamera, Keys.MoveDown], mode: "hold"})
    Overlays.Movement.addRegion("MoveDownLeft",     {text: "↙", color: "0x000000", background: "0x3088F3", x: 377, y: 379, w: 30, h: 30, keys: [Keys.RotateCamera, Keys.MoveDown, Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveLeft",         {text: "←", color: "0x000000", background: "0x3088F3", x: 369, y: 327, w: 30, h: 50, keys: [Keys.RotateCamera, Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveUpLeft",       {text: "↖", color: "0x000000", background: "0x3088F3", x: 377, y: 295, w: 30, h: 30, keys: [Keys.RotateCamera, Keys.MoveUp, Keys.MoveLeft], mode: "hold"})

    Overlays.Movement.addRegion("JumpAutoWalk",     {text: "Jump ↑↑", color: "0x000000", background: "0x3088F3", x: 409, y: 251, w: 50, h: 16, keys: [Keys.Jump, Keys.AutoWalk], mode: "press"}) ; "special", specialHook: "JumpAutoWalk"})
    Overlays.Movement.addRegion("AutoWalk",         {text: "↑↑", color: "0x000000", background: "0x3088F3", x: 409, y: 269, w: 50, h: 16, keys: [Keys.AutoWalk], mode: "press"})
    Overlays.Movement.addRegion("CameraUp",         {text: "↑", color: "0x000000", background: "0x3088F3", x: 401, y: 327, w: 10, h: 16, keys: [Keys.CameraUp], mode: "hold"})
    Overlays.Movement.addRegion("CameraLeft",       {text: "↶", color: "0x000000", background: "0x3088F3", x: 413, y: 319, w: 20, h: 24, keys: [Keys.CameraLeft], mode: "hold"})
    Overlays.Movement.addRegion("CameraRight",      {text: "↷", color: "0x000000", background: "0x3088F3", x: 435, y: 319, w: 20, h: 24, keys: [Keys.CameraRight], mode: "hold"})
    Overlays.Movement.addRegion("CameraDown",       {text: "↓", color: "0x000000", background: "0x3088F3", x: 457, y: 327, w: 10, h: 16, keys: [Keys.CameraDown], mode: "hold"})
    Overlays.Movement.addRegion("Teleport",         {text: "Teleport", color: "0x000000", background: "0x3088F3", x: 409, y: 419, w: 50, h: 16, keys: [Keys.Teleport], mode: "press"})
  }

  ; Hooks
  hook_Special(region) {
    ;global
    ;if (region.curState) {
    ;  if (region.specialHook = "Example") {
    ;  }
    ;}
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
    Overlays.Map.newState := GameUIElements.MapIconDot.curState
    Overlays.Movement.newState := !GameUIElements.PauseMenuOrangeD.curState && !GameUIElements.LogOffButtonNo.curState && !GameUIElements.MapIconDot.curState
    Overlays.HUDCenter.newState := Overlays.Movement.newState ; Same as Movement
    Overlays.General.newState := true ; Always visible

    ; KeyReleaseRegions - check state to restore toggled keys
    ;MouseGetPos, xpos, ypos
    ;For k, v in KeyReleaseOverlay.regions.none {
    ;  v.newState := (xpos < v.x || ypos < v.y || xpos > v.x + v.w || ypos > v.y + v.h)
    ;  if (v.update())
    ;    goSub ReleaseAllKeys
    ;}
  }
}
GAME := new Valheim()