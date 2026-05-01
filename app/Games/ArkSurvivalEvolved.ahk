Class ArkSurvivalEvolved extends Game {
  ; NOTE: All coordinates expect game to be running at APPROXIMATELY 1600x850 resolution
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
    Keys.Attack := new Key("h")
    Keys.Jump := new Key("Space")
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.Movement := new Overlay({transparency: 120})
    Overlays.Camera := new Overlay({transparency: 120})
    Overlays.General := new Overlay({transparency: 120})
    Overlays.Cursor := new Overlay({transparency: 255}) ; Faux Cursor
  }

  setRegions() {
    global
    ; Overlay: Movement
    Overlays.Movement.addRegion("MoveUp",           {text: "↑", color: "0x000000", background: "0x3088F3", x: 775, y: 340, w: 50, h: 50, keys: [Keys.MoveUp], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpRight",      {text: "↗", color: "0x000000", background: "0x3088F3", x: 824, y: 357, w: 44, h: 44, keys: [Keys.MoveUp, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveRight",        {text: "→", color: "0x000000", background: "0x3088F3", x: 835, y: 400, w: 50, h: 50, keys: [Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownRight",    {text: "↘", color: "0x000000", background: "0x3088F3", x: 824, y: 449, w: 44, h: 44, keys: [Keys.MoveDown, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDown",         {text: "↓", color: "0x000000", background: "0x3088F3", x: 775, y: 460, w: 50, h: 50, keys: [Keys.MoveDown], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownLeft",     {text: "↙", color: "0x000000", background: "0x3088F3", x: 732, y: 449, w: 44, h: 44, keys: [Keys.MoveDown, Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveLeft",         {text: "←", color: "0x000000", background: "0x3088F3", x: 715, y: 400, w: 50, h: 50, keys: [Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpLeft",       {text: "↖", color: "0x000000", background: "0x3088F3", x: 732, y: 357, w: 44, h: 44, keys: [Keys.MoveUp, Keys.MoveLeft], mode: "hover"})

    ; Overlay: Camera
    Overlays.Camera.addRegion("CameraUp",           {text: "↑", color: "0x000000", background: "0x3088F3", x: 785, y: 600, w: 30, h: 40, keys: [Keys.CameraUp], mode: "hover"})
    Overlays.Camera.addRegion("CameraRight",        {text: "→", color: "0x000000", background: "0x3088F3", x: 814, y: 619, w: 60, h: 40, keys: [Keys.CameraRight], mode: "hover"})
    Overlays.Camera.addRegion("CameraDown",         {text: "↓", color: "0x000000", background: "0x3088F3", x: 785, y: 639, w: 30, h: 40, keys: [Keys.CameraDown], mode: "hover"})
    Overlays.Camera.addRegion("CameraLeft",         {text: "←", color: "0x000000", background: "0x3088F3", x: 726, y: 619, w: 60, h: 40, keys: [Keys.CameraLeft], mode: "hover"})

    ; Overlay: General
    Overlays.General.addRegion("Attack",            {text: "Attack", color: "0x0e550a", colorOff: "0x550e0a", x: 732, y: 542, w: 54, h: 35, keys: [Keys.Attack], mode: "toggle"})
    Overlays.General.addRegion("Jump",              {text: "Jump", color: "0x0e550a", colorOff: "0x550e0a", x: 814, y: 542, w: 54, h: 35, keys: [Keys.Jump], mode: "timer", time: 2000})

    ; Overlay: Cursor
    Gui, % Overlays.Cursor.gui ": Add", Pic, x0 y0 w32 h32 vFauxCursor, % A_WinDir . "\Cursors\aero_arrow.cur"
  }

  ; Hooks
  hook_MidOverlayLoop() {
    global
    Overlays.Movement.newState := true ; Always visible
    Overlays.Camera.newState := true ; Always visible
    Overlays.General.newState := true ; Always visible
    Overlays.Cursor.newState := true ; Always visible

    ; Faux cursor since the game cursor can be a little funny sometimes
    MouseGetPos, xpos, ypos
    GuiControl, % Overlays.Cursor.gui ": MoveDraw", FauxCursor, % "+X" xpos " +Y" ypos

  }
}
GAME_CLASSES.Push({cls: "ArkSurvivalEvolved", title: "ARK: Survival Evolved"})
