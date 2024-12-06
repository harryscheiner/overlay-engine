Class VRising extends Game {
  ; Init functions
  matchGame() {
    global
    SetTitleMatchMode 3
    GAME_TITLE := "VRising"
    ; NOTE: All coordinates expect game to be running at 1152x720 resolution
  }
  setKeys() {
    global
    Keys.Slot1 := new Key("1")
    Keys.Slot2 := new Key("2")
    Keys.Slot3 := new Key("3")
    Keys.Slot4 := new Key("4")
    Keys.Slot5 := new Key("5")
    Keys.Slot6 := new Key("6")
    Keys.Slot7 := new Key("7")
    Keys.Slot8 := new Key("8")
    ; Skills
    Keys.PrimaryAttack := new Key("h")
    Keys.WeaponAttack1 := new Key("q")
    Keys.WeaponAttack2 := new Key("e")
    Keys.DodgeSpell := new Key("Space")
    Keys.Spell1 := new Key("r")
    Keys.Spell2 := new Key("c")
    Keys.Ultimate := new Key("t")
    ; Movement
    Keys.MoveUp := new Key("w")
    Keys.MoveLeft := new Key("a")
    Keys.MoveDown := new Key("s")
    Keys.MoveRight := new Key("d")
    Keys.RotateCamera := new Key("v")
    Keys.AutoWalk := new Key("Up")
    Keys.Teleport := new Key("Home")
    ; Misc
    Keys.Feed := new Key("f")
    Keys.Jump := new Key("z")
    Keys.Inventory := new Key("Tab")
    Keys.Map := new Key("m")
    Keys.PowerWheel := new Key("i")
    Keys.EmoteWheel := new Key("LAlt")
    Keys.AdminAuth := new Key("End")
    ; Zoom
    Keys.ZoomIn := new Key("WheelUp")
    Keys.ZoomOut := new Key("WheelDown")
    ; Inventory
    Keys.Repair := new Key("o")
    Keys.MoveItem := new Key("RButton")
    Keys.SplitItem := new Key("o")
    ; Wake Up
    Keys.Respawn := new Key("Space")
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.General := new Overlay({transparency: 120}) ; Jump, Feed, Inv, Map
    Overlays.Zoom := new Overlay({transparency: 150}) ; Zoom In / Zoom Out
    Overlays.HUD := new Overlay({}) ; Hotbar, Skills
    Overlays.HUDCenter := new Overlay({transparency: 120}) ; Primary Skill, Power Wheel, Emote Wheel
    Overlays.Movement := new Overlay({transparency: 120}) ; Move, Camera

    Overlays.UseItemsInventory := new Overlay({font: "s8", transparency: 150}) ; Use in Inventory
    Overlays.MoveItemsInventory := new Overlay({font: "s8", transparency: 200}) ; Move from Inventory
    Overlays.SplitItemsInventory := new Overlay({font: "s10", transparency: 255}) ; Split from Inventory

    Overlays.SleepWake := new Overlay({transparency: 150}) ; Wake from Sleep
  }

  setGameUIElements() {
    global
    ; Game UI Elements
    GameUIElements.HealthBar := new GameUIElement({x: 535, y: 665, w: 2, h: 2, color: 0x478f9b})
    GameUIElements.CharacterWindow := new GameUIElement({x: 156, y: 33, w: 3, h: 1, color: 0x3b050b})
    GameUIElements.EquipmentTab := new GameUIElement({x: 73, y: 80, w: 4, h: 1, color: 0x970e10, dependency: GameUIElements.CharacterWindow})
    GameUIElements.CraftingTab := new GameUIElement({x: 170, y: 80, w: 4, h: 1, color: 0x970e10, dependency: GameUIElements.CharacterWindow})
    GameUIElements.BloodPoolTab := new GameUIElement({x: 264, y: 80, w: 4, h: 1, color: 0x960e10, dependency: GameUIElements.CharacterWindow})
    GameUIElements.AttributesTab := new GameUIElement({x: 361, y: 80, w: 4, h: 1, color: 0x960e10, dependency: GameUIElements.CharacterWindow})
    GameUIElements.ApplyingCosmetic := new GameUIElement({x: 134, y: 124, w: 2, h: 2, color: 0x6a7d89, dependency: GameUIElements.EquipmentTab})
    GameUIElements.ItemDetailsBox := new GameUIElement({x: 442, y: 337, w: 2, h: 2, color: 0x172330, dependency: GameUIElements.CharacterWindow})

    GameUIElements.InteractableWindow := new GameUIElement({x: 836, y: 33, w: 2, h: 1, color: 0x1f0609, dependency: GameUIElements.CharacterWindow})
    
    GameUIElements.MapUnderline := new GameUIElement({x: 631, y: 26, w: 3, h: 1, color: 0xd8362b, dependency: GameUIElements.HealthBar, dependencyLogic: false})
    GameUIElements.SleepSpaceP := new GameUIElement({x: 537, y: 637, w: 1, h: 4, color: 0x80c6d5, dependency: GameUIElements.HealthBar, dependencyLogic: false})
  }

  setRegions() {
    global
    ; KeyReleaseRegions
    KeyReleaseOverlay := new Overlay({})
    KeyReleaseOverlay.addRegion("KeyReleaseHotbar", {noGuiControl: true, background: "0xFFB015", x: 211, y: 653, w: 299, h: 38, keys: [], mode: "none"})
    KeyReleaseOverlay.addRegion("KeyReleaseMapNav", {noGuiControl: true, background: "0xFFB015", x: 1086, y: 135, w: 64, h: 57, keys: [], mode: "none"})

    ; Overlay: Zoom
    Overlays.Zoom.addRegion("ZoomIn",  {text: "IN",  color: "0x000000", background: "0x3088F3", x: 17, y: 658, w: 34, h: 20, keys: [Keys.ZoomIn], mode: "press"})
    Overlays.Zoom.addRegion("ZoomOut", {text: "OUT", color: "0x000000", background: "0x3088F3", x: 17, y: 683, w: 34, h: 20, keys: [Keys.ZoomOut], mode: "press"})

    ; Overlay: HUD
    Overlays.HUD.addRegion("HotbarSlot1", {x: 213, y: 655, w: 34, h: 34, keys: [Keys.Slot1], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot2", {x: 250, y: 655, w: 34, h: 34, keys: [Keys.Slot2], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot3", {x: 288, y: 655, w: 34, h: 34, keys: [Keys.Slot3], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot4", {x: 325, y: 655, w: 34, h: 34, keys: [Keys.Slot4], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot5", {x: 362, y: 655, w: 34, h: 34, keys: [Keys.Slot5], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot6", {x: 400, y: 655, w: 34, h: 34, keys: [Keys.Slot6], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot7", {x: 437, y: 655, w: 34, h: 34, keys: [Keys.Slot7], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot8", {x: 474, y: 655, w: 34, h: 34, keys: [Keys.Slot8], mode: "press"})

    Overlays.HUD.addRegion("SkillWeaponAttack1", {x: 687, y: 654, w: 36, h: 36, keys: [Keys.WeaponAttack1], mode: "toggle"})
    Overlays.HUD.addRegion("SkillWeaponAttack2", {x: 730, y: 654, w: 36, h: 36, keys: [Keys.WeaponAttack2], mode: "toggle"})
    Overlays.HUD.addRegion("SkillDodgeSpell",    {x: 774, y: 654, w: 36, h: 36, keys: [Keys.DodgeSpell], mode: "toggle"})
    Overlays.HUD.addRegion("SkillSpell1",        {x: 817, y: 654, w: 36, h: 36, keys: [Keys.Spell1], mode: "toggle"})
    Overlays.HUD.addRegion("SkillSpell2",        {x: 861, y: 654, w: 36, h: 36, keys: [Keys.Spell2], mode: "toggle"})
    Overlays.HUD.addRegion("SkillUltimate",      {x: 904, y: 654, w: 36, h: 36, keys: [Keys.Ultimate], mode: "toggle"})

    Overlays.HUDCenter.addRegion("WheelPower",         {text: "Pwr", color: "0x000000", background: "0x3088F3", x: 519, y: 285, w: 30, h: 16, keys: [Keys.PowerWheel], mode: "hold"})
    ;Overlays.HUDCenter.addRegion("WheelEmote",         {text: "Emote", color: "0x000000", background: "0x3088F3", x: 616, y: 250, w: 40, h: 20, keys: [Keys.EmoteWheel], mode: "hold"})
    Overlays.HUDCenter.addRegion("SkillPrimaryAttack", {text: "Atk",  color: "0x0e550a", colorOff: "0x550e0a",   x: 603, y: 285, w: 30, h: 16, keys: [Keys.PrimaryAttack], mode: "toggle"})
    Overlays.HUDCenter.addRegion("RotateCameraLeft",   {text: "↶",   color: "0x000000", background: "0x3088F3", x: 551, y: 327, w: 24, h: 24, keys: [Keys.RotateCamera], mode: "special", specialHook: "moveMouseLeft"})
    Overlays.HUDCenter.addRegion("RotateCameraRight",  {text: "↷",   color: "0x000000", background: "0x3088F3", x: 577, y: 327, w: 24, h: 24, keys: [Keys.RotateCamera], mode: "special", specialHook: "moveMouseRight"})
    Overlays.HUDCenter.addRegion("AutoWalk",           {text: "↑↑",   color: "0x000000", background: "0x3088F3", x: 551, y: 277, w: 50, h: 16, keys: [Keys.AutoWalk], mode: "press"})
    Overlays.HUDCenter.addRegion("Teleport",           {text: "Teleport",   color: "0x000000", background: "0x3088F3", x: 551, y: 427, w: 50, h: 16, keys: [Keys.Teleport], mode: "press"})
    Overlays.HUDCenter.addRegion("AdminAuth",          {text: "* Admin *",  color: "0x000000", background: "0x3088F3", x: 551, y: 445, w: 50, h: 16, keys: [Keys.AdminAuth], mode: "special", specialHook: "AdminAuth"})

    ; Overlay: General
    Overlays.General.addRegion("SkillJump", {text: "Jump", color: "0x0e550a", colorOff: "0x550e0a", x: 519, y: 419, w: 30, h: 16, keys: [Keys.Jump], mode: "toggle"})
    Overlays.General.addRegion("SkillFeed", {text: "Feed", color: "0x0e550a", colorOff: "0x550e0a", x: 603, y: 419, w: 30, h: 16, keys: [Keys.Feed], mode: "toggle"})
    Overlays.General.addRegion("OpenInventory", {text: "Inv", color: "0x000000", background: "0x3088F3", x: 519, y: 438, w: 30, h: 16, keys: [Keys.Inventory], mode: "press"})
    Overlays.General.addRegion("OpenMap",       {text: "Map", color: "0x000000", background: "0x3088F3", x: 603, y: 438, w: 30, h: 16, keys: [Keys.Map], mode: "press"})

    ; Overlay: Movement
    Overlays.Movement.addRegion("MoveUp",           {text: "↑", color: "0x000000", background: "0x3088F3", x: 551, y: 295, w: 50, h: 30, keys: [Keys.RotateCamera, Keys.MoveUp], mode: "hold"})
    Overlays.Movement.addRegion("MoveUpRight",      {text: "↗", color: "0x000000", background: "0x3088F3", x: 603, y: 303, w: 30, h: 30, keys: [Keys.RotateCamera, Keys.MoveUp, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveRight",        {text: "→", color: "0x000000", background: "0x3088F3", x: 611, y: 335, w: 30, h: 50, keys: [Keys.RotateCamera, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveDownRight",    {text: "↘", color: "0x000000", background: "0x3088F3", x: 603, y: 387, w: 30, h: 30, keys: [Keys.RotateCamera, Keys.MoveDown, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveDown",         {text: "↓", color: "0x000000", background: "0x3088F3", x: 551, y: 395, w: 50, h: 30, keys: [Keys.RotateCamera, Keys.MoveDown], mode: "hold"})
    Overlays.Movement.addRegion("MoveDownLeft",     {text: "↙", color: "0x000000", background: "0x3088F3", x: 519, y: 387, w: 30, h: 30, keys: [Keys.RotateCamera, Keys.MoveDown, Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveLeft",         {text: "←", color: "0x000000", background: "0x3088F3", x: 511, y: 335, w: 30, h: 50, keys: [Keys.RotateCamera, Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveUpLeft",       {text: "↖", color: "0x000000", background: "0x3088F3", x: 519, y: 303, w: 30, h: 30, keys: [Keys.RotateCamera, Keys.MoveUp, Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveRotateCamera", {text: "↔", color: "0x000000", background: "0x3088F3", x: 559, y: 353, w: 34, h: 34, keys: [Keys.RotateCamera], mode: "hold"})

    ; Overlay: Use and Move Inventory Items
    GridCoordsX := [45,84,123,163,202,241,281,320,359]
    GridCoordsY := [319,367,407,446,485,525]
    Loop, % GridCoordsY.Count() {
      row := A_Index
      Loop, % GridCoordsX.Count() {
        col := A_Index
        cell := col + ((row-1) * GridCoordsX.Count())
        if (row == 1 && col == 5)
          continue
        Overlays.UseItemsInventory.addRegion("UseItemsInventorySlot" . cell,  {text: "U", background: "0x660507", x: GridCoordsX[col] + 24, y: GridCoordsY[row] + 24, w: 12, h: 12, keys: [Keys.MoveItem], mode: "press"})
        Overlays.MoveItemsInventory.addRegion("MoveItemsInventorySlot" . cell,  {text: "🡺", background: "transparent", x: GridCoordsX[col] + 24, y: GridCoordsY[row] + 24, w: 12, h: 12, keys: [Keys.MoveItem], mode: "press"})
        Overlays.SplitItemsInventory.addRegion("SplitItemsInventorySlot" . cell,  {text: "½", background: "transparent", x: GridCoordsX[col], y: GridCoordsY[row] + 24, w: 12, h: 12, keys: [Keys.SplitItem], mode: "press"})
      }
    }

    ; Wake from Sleep
    Overlays.SleepWake.addRegion("WakeFromSleep",  {color: "0x000001", background: "0x3088F3", x: 466, y: 622, w: 219, h: 31, keys: [Keys.Respawn], mode: "press"})
  }

  ; Hooks
  hook_Special(region) {
    global
    if (region.curState) {
      if (InStr(region.specialHook, "moveMouse")) {
        MouseGetPos, xpos, ypos
        For k, v in region.keys
          v.down()
        Switch (region.specialHook) {
          case "moveMouseLeft":
            MouseMove, -75, 0, 0, R
          case "moveMouseRight":
            MouseMove, +75, 0, 0, R
        }
        Sleep 10
        For k, v in region.keys
          v.up()
        MouseMove, xpos, ypos, 0
      } else if (region.specialHook = "AdminAuth") {
        region.pressKeys()
        region.hideGuiControl()
        Overlays.HUDCenter.removeRegion(region)
      }
    }
  }
  hook_LButtonDown_AfterPress() {
    global
    For k, v in Overlays.General.regions.toggle
      v.releaseKeys()
  }
  hook_LButtonDown_AfterOverlays() {
  }
  hook_LButtonUp_AfterOverlays() {
    global
    ; PrimaryAttack click fix control
    If (!ClickedRegion && Overlays.HUDCenter.regions.toggle.SkillPrimaryAttack.curState) {
      Overlays.HUDCenter.regions.toggle.SkillPrimaryAttack.forceReleaseKeys()
    }
  }
  hook_MidOverlayLoop() {
    global
    ; Check state of GameUIElements and set state of Overlays accordingly
    Overlays.General.newState := GameUIElements.HealthBar.curState && !GameUIElements.ItemDetailsBox.curState
    Overlays.Zoom.newState := !GameUIElements.CharacterWindow.curState
    Overlays.HUD.newState := GameUIElements.HealthBar.curState && !GameUIElements.CharacterWindow.curState
    Overlays.HUDCenter.newState := Overlays.HUD.newState ; Same as HUD
    Overlays.Movement.newState := GameUIElements.HealthBar.curState && !GameUIElements.ItemDetailsBox.curState

    Overlays.UseItemsInventory.newState := (GameUIElements.EquipmentTab.curState || GameUIElements.CraftingTab.curState) && !GameUIElements.InteractableWindow.curState
    Overlays.MoveItemsInventory.newState := (GameUIElements.EquipmentTab.curState || GameUIElements.CraftingTab.curState) && GameUIElements.InteractableWindow.curState
    Overlays.SplitItemsInventory.newState := (GameUIElements.EquipmentTab.curState || GameUIElements.CraftingTab.curState)

    Overlays.SleepWake.newState := !GameUIElements.HealthBar.curState && !GameUIElements.MapUnderline.curState && GameUIElements.SleepSpaceP.curState

    ; KeyReleaseRegions - check state to restore toggled keys
    MouseGetPos, xpos, ypos
    For k, v in KeyReleaseOverlay.regions.none {
      v.newState := (xpos < v.x || ypos < v.y || xpos > v.x + v.w || ypos > v.y + v.h)
      if (v.update())
        goSub ReleaseAllKeys
    }
  }
}
GAME := new VRising()