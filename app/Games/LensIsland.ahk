Class LensIsland extends Game {
  ; Init functions
  matchGame() {
    global
    SetTitleMatchMode 3
    GAME_TITLE := "Len's Island"
    ; NOTE: All coordinates expect game to be running at 1128x634 resolution with Large UI Scale
  }
  setKeys() {
    global
    ; Hotbar
    Keys.Slot1 := new Key("1")
    Keys.Slot2 := new Key("2")
    Keys.Slot3 := new Key("3")
    Keys.Slot4 := new Key("4")
    Keys.Slot5 := new Key("5")
    Keys.Slot6 := new Key("6")
    ; Movement
    Keys.MoveUp := new Key("w")
    Keys.MoveLeft := new Key("a")
    Keys.MoveDown := new Key("s")
    Keys.MoveRight := new Key("d")
    Keys.Jump := new Key("Space")
    Keys.Dodge := new Key("LShift")
    ; Build
    Keys.AltKey := new Key("LAlt")
    Keys.MWheelUp := new Key("WheelUp")
    Keys.MWheelDown := new Key("WheelDown")
    ; Map
    Keys.RClick := new Key("RButton")
    ; Misc
    Keys.PauseMenu := new Key("Esc")
    Keys.Build := new Key("f")
    Keys.Inventory := new Key("Tab")
    Keys.Skills := new Key("c")
    Keys.Map := new Key("m")
    ; Camera
    Keys.CameraUp := new Key("Up")
    Keys.CameraLeft := new Key("Left")
    Keys.CameraDown := new Key("Down")
    Keys.CameraRight := new Key("Right")
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.Cursor := new Overlay({transparency: 255}) ; Faux Cursor
    Overlays.General := new Overlay({font: "s7", transparency: 100}) ; Craft/Inv
    Overlays.GeneralNoBuild := new Overlay({font: "s7", transparency: 100}) ; Skills/Map/Pause
    Overlays.Movement := new Overlay({transparency: 100}) ; Player Movement
    Overlays.ExtraMovement := new Overlay({font: "s7", transparency: 100}) ; Jump and Dodge
    Overlays.Camera := new Overlay({transparency: 100}) ; Camera Control
    Overlays.Hotbar := new Overlay({font: "s7", transparency: 100}) ; Tool selection
    Overlays.Build := new Overlay({transparency: 100}) ; Build menu
    Overlays.Map := new Overlay({transparency: 100}) ; Map menu
    
    ;Overlays.TestInventoryOpen := new Overlay({transparency: 120})
    ;Overlays.TestBuildMenuOpen := new Overlay({transparency: 120})
    ;Overlays.TestSkillsOpen := new Overlay({transparency: 120})
    ;Overlays.TestMapOpen := new Overlay({transparency: 120})
  }

  setGameUIElements() {
    global
    ; Game UI Elements
    GameUIElements.InventoryTop1 := new GameUIElement({x: 80, y: 10, w: 1, h: 1, color: 0x916342})
    GameUIElements.InventoryTop2 := new GameUIElement({x: 93, y: 10, w: 1, h: 1, color: 0x9e724c, dependency: GameUIElements.InventoryTop1})
    GameUIElements.BuildMenuTop1 := new GameUIElement({x: 13, y: 13, w: 1, h: 1, color: 0xfefefe})
    GameUIElements.BuildMenuTop2 := new GameUIElement({x: 20, y: 12, w: 1, h: 1, color: 0xf8fcfd, dependency: GameUIElements.BuildMenuTop1})
    GameUIElements.SkillsBottom1 := new GameUIElement({x: 246, y: 507, w: 1, h: 1, color: 0x56676e})
    GameUIElements.SkillsBottom2 := new GameUIElement({x: 258, y: 507, w: 1, h: 1, color: 0x506267, dependency: GameUIElements.SkillsBottom1})
    GameUIElements.MapBottom1 := new GameUIElement({x: 267, y: 502, w: 1, h: 1, color: 0xad9a75})
    GameUIElements.MapBottom2 := new GameUIElement({x: 273, y: 502, w: 1, h: 1, color: 0xb09c79, dependency: GameUIElements.MapBottom1})
    GameUIElements.PauseTop1 := new GameUIElement({x: 417, y: 213, w: 1, h: 1, color: 0xa8482c})
    GameUIElements.PauseTop2 := new GameUIElement({x: 417, y: 221, w: 1, h: 1, color: 0x09161c, dependency: GameUIElements.PauseTop1})
  }

  setRegions() {
    global
    ; TEST
    ;Overlays.TestInventoryOpen.addRegion("TestInventoryOpen", {text: "INV", color: "0x000000", background: "0x3088F3", x: 1020, y: 500, w: 100, h: 20, keys: [], mode: "none"})
    ;Overlays.TestBuildMenuOpen.addRegion("TestBuildMenuOpen", {text: "BUILD", color: "0x000000", background: "0x3088F3", x: 1020, y: 525, w: 100, h: 20, keys: [], mode: "none"})
    ;Overlays.TestSkillsOpen.addRegion("TestSkillsOpen",       {text: "SKILLS", color: "0x000000", background: "0x3088F3", x: 1020, y: 550, w: 100, h: 20, keys: [], mode: "none"})
    ;Overlays.TestMapOpen.addRegion("TestMapOpen",             {text: "MAP", color: "0x000000", background: "0x3088F3", x: 1020, y: 575, w: 100, h: 20, keys: [], mode: "none"})

    ; Overlay: Movement
    Overlays.Movement.addRegion("MoveUp",           {text: "▲", color: "0x000000", background: "0x3088F3", x: 649, y: 282, w: 30, h: 20, keys: [Keys.MoveUp], mode: "hold"})
    Overlays.Movement.addRegion("MoveUpRight",      {text: "◥", color: "0x000000", background: "0x3088F3", x: 679, y: 286, w: 16, h: 16, keys: [Keys.MoveUp, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveRight",        {text: "▶", color: "0x000000", background: "0x3088F3", x: 679, y: 302, w: 20, h: 30, keys: [Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveDownRight",    {text: "◢", color: "0x000000", background: "0x3088F3", x: 679, y: 332, w: 16, h: 16, keys: [Keys.MoveDown, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveDown",         {text: "▼", color: "0x000000", background: "0x3088F3", x: 649, y: 332, w: 30, h: 20, keys: [Keys.MoveDown], mode: "hold"})
    Overlays.Movement.addRegion("MoveDownLeft",     {text: "◣", color: "0x000000", background: "0x3088F3", x: 633, y: 332, w: 16, h: 16, keys: [Keys.MoveDown, Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveLeft",         {text: "◀", color: "0x000000", background: "0x3088F3", x: 629, y: 302, w: 20, h: 30, keys: [Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveUpLeft",       {text: "◤", color: "0x000000", background: "0x3088F3", x: 633, y: 286, w: 16, h: 16, keys: [Keys.MoveUp, Keys.MoveLeft], mode: "hold"})

    ; Overlay: Extra Movement
    Overlays.ExtraMovement.addRegion("LongJump",    {text: "L J", color: "0x000000", background: "0x3088F3", x: 649, y: 252, w: 30, h: 15, keys: [], mode: "special", specialHook: "longJump"})
    Overlays.ExtraMovement.addRegion("JumpUp",      {text: "Jump", color: "0x000000", background: "0x3088F3", x: 649, y: 267, w: 30, h: 15, keys: [Keys.Jump, Keys.MoveUp], mode: "hold"})
    Overlays.ExtraMovement.addRegion("DodgeDown",   {text: "Dodge", color: "0x000000", background: "0x3088F3", x: 649, y: 317, w: 30, h: 15, keys: [Keys.Dodge, Keys.MoveDown], mode: "hold"})

    ; Overlay: Camera
    Overlays.Camera.addRegion("CameraUp",           {text: "+", color: "0x000000", background: "0x3088F3", x: 703, y: 302, w: 14, h: 14, keys: [Keys.CameraUp], mode: "hold"})
    Overlays.Camera.addRegion("CameraRight",        {text: "↶", color: "0x000000", background: "0x3088F3", x: 649, y: 302, w: 15, h: 15, keys: [Keys.CameraRight], mode: "hold"})
    Overlays.Camera.addRegion("CameraLeft",         {text: "↷", color: "0x000000", background: "0x3088F3", x: 664, y: 302, w: 15, h: 15, keys: [Keys.CameraLeft], mode: "hold"})
    Overlays.Camera.addRegion("CameraDown",         {text: "-", color: "0x000000", background: "0x3088F3", x: 703, y: 318, w: 14, h: 14, keys: [Keys.CameraDown], mode: "hold"})

    ; Overlay: Hotbar
    Overlays.Hotbar.addRegion("HotbarSlot1", {text: "1", color: "0x000000", background: "0x3088F3", x: 628, y: 352, w: 12, h: 15, keys: [Keys.Slot1], mode: "press"})
    Overlays.Hotbar.addRegion("HotbarSlot2", {text: "2", color: "0x000000", background: "0x3088F3", x: 640, y: 352, w: 12, h: 15, keys: [Keys.Slot2], mode: "press"})
    Overlays.Hotbar.addRegion("HotbarSlot3", {text: "3", color: "0x000000", background: "0x3088F3", x: 652, y: 352, w: 12, h: 15, keys: [Keys.Slot3], mode: "press"})
    Overlays.Hotbar.addRegion("HotbarSlot4", {text: "4", color: "0x000000", background: "0x3088F3", x: 664, y: 352, w: 12, h: 15, keys: [Keys.Slot4], mode: "press"})
    Overlays.Hotbar.addRegion("HotbarSlot5", {text: "5", color: "0x000000", background: "0x3088F3", x: 676, y: 352, w: 12, h: 15, keys: [Keys.Slot5], mode: "press"})
    Overlays.Hotbar.addRegion("HotbarSlot6", {text: "6", color: "0x000000", background: "0x3088F3", x: 688, y: 352, w: 12, h: 15, keys: [Keys.Slot6], mode: "press"})
    
    ; Overlay: General
    Overlays.General.addRegion("OpenBuildMenu", {text: "Build", color: "0x000000", background: "0x3088F3", x: 565, y: 409, w: 30, h: 14, keys: [Keys.Build], mode: "press"})
    Overlays.General.addRegion("OpenInventory", {text: "Inv", color: "0x000000", background: "0x3088F3", x: 533, y: 409, w: 30, h: 14, keys: [Keys.Inventory], mode: "press"})
    Overlays.GeneralNoBuild.addRegion("OpenSkills", {text: "Skill", color: "0x000000", background: "0x3088F3", x: 517, y: 425, w: 30, h: 14, keys: [Keys.Skills], mode: "press"})
    Overlays.GeneralNoBuild.addRegion("OpenMap",    {text: "Map", color: "0x000000", background: "0x3088F3", x: 549, y: 425, w: 30, h: 14, keys: [Keys.Map], mode: "press"})
    Overlays.GeneralNoBuild.addRegion("PauseGame",  {text: "Esc", color: "0x000000", background: "0x3088F3", x: 581, y: 425, w: 30, h: 14, keys: [Keys.PauseMenu], mode: "press"})

    ; Overlay: Build
    Overlays.Build.addRegion("BuildCloseCenter", {text: "Close / Cancel", color: "0x000000", background: "0x3088F3", x: 514, y: 441, w: 100, h: 20, keys: [Keys.Build], mode: "press"})
    Overlays.Build.addRegion("BuildCloseBottom", {text: "Close / Cancel", color: "0x000000", background: "0x3088F3", x: 150, y: 561, w: 100, h: 20, keys: [Keys.Build], mode: "press"})
    
    Overlays.Build.addRegion("BuildRotateLeft",  {text: "↶", color: "0x000000", background: "0x3088F3", x: 533, y: 425, w: 14, h: 14, keys: [Keys.MWheelDown], mode: "press"})
    Overlays.Build.addRegion("BuildRotateRight", {text: "↷", color: "0x000000", background: "0x3088F3", x: 549, y: 425, w: 14, h: 14, keys: [Keys.MWheelUp], mode: "press"})
    ; TODO: Add a way to include a modifier on "press" like ALT, using "hold" for now
    Overlays.Build.addRegion("BuildRaise",       {text: "▲", color: "0x000000", background: "0x3088F3", x: 565, y: 425, w: 14, h: 14, keys: [Keys.AltKey, Keys.MWheelUp], mode: "hold"})
    Overlays.Build.addRegion("BuildLower",       {text: "▼", color: "0x000000", background: "0x3088F3", x: 581, y: 425, w: 14, h: 14, keys: [Keys.AltKey, Keys.MWheelDown], mode: "hold"})
    
    ; Overlay: Map
    Overlays.Map.addRegion("MapZoomIn",       {text: "+", color: "0x000000", background: "0x3088F3", x: 576, y: 367, w: 19, h: 19, keys: [Keys.MWheelUp], mode: "press"})
    Overlays.Map.addRegion("MapZoomOut",      {text: "-", color: "0x000000", background: "0x3088F3", x: 576, y: 388, w: 19, h: 19, keys: [Keys.MWheelDown], mode: "press"})
    Overlays.Map.addRegion("MapDeleteMarker", {text: "🚫", background: "0x660507", x: 533, y: 367, w: 40, h: 40, keys: [Keys.RClick], mode: "press"})
    
    ;Overlays.Cursor.addRegion("FauxCursor", {background: "0xFFFF00", x: 1128, y: 634, w: 1, h: 1, keys: [], mode: "none"})
  }

  ; Hooks
  hook_Special(region) {
    global
    if (region.curState) {
      if (region.specialHook = "longJump") {
        For k, v in [Keys.MoveUp, Keys.Jump]
          v.down()
        Sleep 180
        Keys.Dodge.down()
        Sleep 200
        For k, v in [Keys.MoveUp, Keys.Jump]
          v.up()
        Keys.Dodge.up()
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
    ;Overlays.Cursor.newState := false ; Always visible
    Overlays.General.newState := true ; Always visible
    Overlays.Movement.newState := !GameUIElements.MapBottom2.curState && !GameUIElements.SkillsBottom2.curState && !GameUIElements.PauseTop2.curState
    Overlays.ExtraMovement.newState := Overlays.Movement.newState
    Overlays.Camera.newState := Overlays.Movement.newState
    Overlays.Hotbar.newState := Overlays.Movement.newState && !GameUIElements.BuildMenuTop2.curState
    Overlays.Build.newState := GameUIElements.BuildMenuTop2.curState && !GameUIElements.PauseTop2.curState
    Overlays.GeneralNoBuild.newState := !Overlays.Build.newState
    Overlays.Map.newState := GameUIElements.MapBottom2.curState

    ; Faux cursor since the game cursor can be a little funny sometimes
    ;MouseGetPos, xpos, ypos
    ;Overlays.Cursor.regions.none.FauxCursor.x := xpos
    ;Overlays.Cursor.regions.none.FauxCursor.y := ypos
    ;Overlays.Cursor.regions.none.FauxCursor.updateGuiControlPosition()
    
    ; TEST
    ;Overlays.TestInventoryOpen.newState := GameUIElements.InventoryTop2.curState
    ;Overlays.TestBuildMenuOpen.newState := GameUIElements.BuildMenuTop2.curState
    ;Overlays.TestSkillsOpen.newState := GameUIElements.SkillsBottom2.curState
    ;Overlays.TestMapOpen.newState := GameUIElements.MapBottom2.curState
  }
}
GAME := new LensIsland()