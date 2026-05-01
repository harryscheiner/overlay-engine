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
    Overlays.Movement.addRegion("MoveUp",           {text: "↑", color: "0x000000", background: "0x3088F3", x: 775, y: 340, w: 50, h: 50, keys: [Keys.MoveUp], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpRight",      {text: "↗", color: "0x000000", background: "0x3088F3", x: 824, y: 357, w: 44, h: 44, keys: [Keys.MoveUp, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveRight",        {text: "→", color: "0x000000", background: "0x3088F3", x: 835, y: 400, w: 50, h: 50, keys: [Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownRight",    {text: "↘", color: "0x000000", background: "0x3088F3", x: 824, y: 449, w: 44, h: 44, keys: [Keys.MoveDown, Keys.MoveRight], mode: "hover"})
    Overlays.Movement.addRegion("MoveDown",         {text: "↓", color: "0x000000", background: "0x3088F3", x: 775, y: 460, w: 50, h: 50, keys: [Keys.MoveDown], mode: "hover"})
    Overlays.Movement.addRegion("MoveDownLeft",     {text: "↙", color: "0x000000", background: "0x3088F3", x: 732, y: 449, w: 44, h: 44, keys: [Keys.MoveDown, Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveLeft",         {text: "←", color: "0x000000", background: "0x3088F3", x: 715, y: 400, w: 50, h: 50, keys: [Keys.MoveLeft], mode: "hover"})
    Overlays.Movement.addRegion("MoveUpLeft",       {text: "↖", color: "0x000000", background: "0x3088F3", x: 732, y: 357, w: 44, h: 44, keys: [Keys.MoveUp, Keys.MoveLeft], mode: "hover"})
  }

  ; Hooks
  hook_MidOverlayLoop() {
    global
    Overlays.Movement.newState := true ; Always visible
  }
}
GAME_CLASSES.Push({cls: "ArkSurvivalEvolved", title: "ARK: Survival Evolved"})
