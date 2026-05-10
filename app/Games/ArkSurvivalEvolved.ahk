Class ArkSurvivalEvolved extends Game {
  ; NOTE: All coordinates expect game to be running at APPROXIMATELY 1366x768 resolution
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
    Keys.Use := new Key("e")
    Keys.Crouch := new Key("c")
    Keys.Prone := new Key("x")
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.Movement := new Overlay({transparency: 170})
    Overlays.General := new Overlay({transparency: 170})
    Overlays.Camera := new Overlay({transparency: 170})
    Overlays.Special := new Overlay({transparency: 170})
    Overlays.Cursor := new Overlay({transparency: 255}) ; Faux Cursor
  }

  setRegions() {
    global
    ; Overlay: Movement
    Overlays.Movement.addRegion("MoveUp",           {text: "↑", color: "0x000000", background: "0x3088F3", x: 658, y: 299, w: 50, h: 50, keys: [Keys.MoveUp], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpRight",      {text: "↗", color: "0x000000", background: "0x3088F3", x: 707, y: 316, w: 44, h: 44, keys: [Keys.MoveUp, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveRight",        {text: "→", color: "0x000000", background: "0x3088F3", x: 718, y: 359, w: 50, h: 50, keys: [Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownRight",    {text: "↘", color: "0x000000", background: "0x3088F3", x: 707, y: 408, w: 44, h: 44, keys: [Keys.MoveDown, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDown",         {text: "↓", color: "0x000000", background: "0x3088F3", x: 658, y: 419, w: 50, h: 50, keys: [Keys.MoveDown], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownLeft",     {text: "↙", color: "0x000000", background: "0x3088F3", x: 615, y: 408, w: 44, h: 44, keys: [Keys.MoveDown, Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveLeft",         {text: "←", color: "0x000000", background: "0x3088F3", x: 598, y: 359, w: 50, h: 50, keys: [Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpLeft",       {text: "↖", color: "0x000000", background: "0x3088F3", x: 615, y: 316, w: 44, h: 44, keys: [Keys.MoveUp, Keys.MoveLeft], mode: "hover"})

    ; Overlay: Camera
    Overlays.Camera.addRegion("CameraUp",           {text: "↑", color: "0x000000", background: "0x3088F3", x: 668, y: 539, w: 30, h: 35, keys: [Keys.CameraUp], mode: "hover"})
    Overlays.Camera.addRegion("CameraRight",        {text: "→", color: "0x000000", background: "0x3088F3", x: 707, y: 578, w: 60, h: 40, keys: [Keys.CameraRight], mode: "hover"})
    Overlays.Camera.addRegion("CameraDown",         {text: "↓", color: "0x000000", background: "0x3088F3", x: 668, y: 623, w: 30, h: 35, keys: [Keys.CameraDown], mode: "hover"})
    Overlays.Camera.addRegion("CameraLeft",         {text: "←", color: "0x000000", background: "0x3088F3", x: 599, y: 578, w: 60, h: 40, keys: [Keys.CameraLeft], mode: "hover"})

    ; Overlay: General
    Overlays.General.addRegion("GenAttack",         {text: "Attack", color: "0x0e550a", colorOff: "0x550e0a", x: 605, y: 491, w: 54, h: 35, keys: [Keys.Attack], mode: "toggle"})
    Overlays.General.addRegion("GenJump",           {text: "Jump", color: "0x0e550a", colorOff: "0x550e0a", x: 707, y: 491, w: 54, h: 35, keys: [Keys.Jump], mode: "timer", time: 2000})
    Overlays.General.addRegion("GenUse",            {text: "E", color: "0x0e550a", colorOff: "0x550e0a", x: 670, y: 585, w: 26, h: 27, keys: [Keys.Use], mode: "hold"})
    Overlays.General.addRegion("GenCrouch",         {text: "Crouch", color: "0x0e550a", colorOff: "0x550e0a", x: 605, y: 527, w: 54, h: 35, keys: [Keys.Crouch], mode: "hold"})
    Overlays.General.addRegion("GenProne",          {text: "Prone", color: "0x0e550a", colorOff: "0x550e0a", x: 707, y: 527, w: 54, h: 35, keys: [Keys.Prone], mode: "hold"})

    Overlays.Special.addRegion("Teleport",          {text: "Teleport", color: "0x000000", background: "0x3088F3", x: 150, y: 10, w: 60, h: 20, keys: [], mode: "special", specialHook: "teleportToHarry"})
    Overlays.Special.addRegion("Repair",            {text: "Repair", color: "0x000000", background: "0x3088F3", x: 150, y: 32, w: 60, h: 20, keys: [], mode: "special", specialHook: "repairGear"})

    ; Overlay: Cursor
    Gui, % Overlays.Cursor.gui ": Add", Pic, x0 y0 w32 h32 vFauxCursor, % A_WinDir . "\Cursors\aero_arrow.cur"
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
    Overlays.Movement.newState := true ; Always visible
    Overlays.Camera.newState := true ; Always visible
    Overlays.General.newState := true ; Always visible
    Overlays.Special.newState := true ; Always visible
    Overlays.Cursor.newState := true ; Always visible

    ; Faux cursor since the game cursor can be a little funny sometimes
    MouseGetPos, xpos, ypos
    GuiControl, % Overlays.Cursor.gui ": MoveDraw", FauxCursor, % "+X" xpos " +Y" ypos

  }
}
GAME_CLASSES.Push({cls: "ArkSurvivalEvolved", title: "ARK: Survival Evolved"})
