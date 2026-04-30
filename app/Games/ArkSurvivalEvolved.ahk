Class ArkSurvivalEvolved extends Game {
  ; NOTE: All coordinates expect game to be running at APPROXIMATELY 1600x850 resolution
  setKeys() {
    global
    ; Movement
    Keys.MoveUp := new Key("w")
    Keys.MoveLeft := new Key("a")
    Keys.MoveDown := new Key("s")
    Keys.MoveRight := new Key("d")
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.Movement := new Overlay({transparency: 120})
  }

  setRegions() {
    global
    ; Overlay: Movement
    Overlays.Movement.addRegion("MoveUp",           {text: "↑", color: "0x000000", background: "0x3088F3", x: 409, y: 287, w: 50, h: 30, keys: [Keys.MoveUp], mode: "hold"})
    Overlays.Movement.addRegion("MoveUpRight",      {text: "↗", color: "0x000000", background: "0x3088F3", x: 461, y: 295, w: 30, h: 30, keys: [Keys.MoveUp, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveRight",        {text: "→", color: "0x000000", background: "0x3088F3", x: 469, y: 327, w: 30, h: 50, keys: [Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveDownRight",    {text: "↘", color: "0x000000", background: "0x3088F3", x: 461, y: 379, w: 30, h: 30, keys: [Keys.MoveDown, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveDown",         {text: "↓", color: "0x000000", background: "0x3088F3", x: 409, y: 387, w: 50, h: 30, keys: [Keys.MoveDown], mode: "hold"})
    Overlays.Movement.addRegion("MoveDownLeft",     {text: "↙", color: "0x000000", background: "0x3088F3", x: 377, y: 379, w: 30, h: 30, keys: [Keys.MoveDown, Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveLeft",         {text: "←", color: "0x000000", background: "0x3088F3", x: 369, y: 327, w: 30, h: 50, keys: [Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveUpLeft",       {text: "↖", color: "0x000000", background: "0x3088F3", x: 377, y: 295, w: 30, h: 30, keys: [Keys.MoveUp, Keys.MoveLeft], mode: "hold"})
  }

  ; Hooks
  hook_MidOverlayLoop() {
    global
    Overlays.Movement.newState := true ; Always visible
  }
}
GAME_CLASSES.Push({cls: "ArkSurvivalEvolved", title: "ARK: Survival Evolved"})
