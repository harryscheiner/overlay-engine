Class VRising extends Game {
  ; Init functions
  matchGame() {
    global
    SetTitleMatchMode 3
    GAME_TITLE := "VRising"
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
    Keys.Slot9 := new Key("9")
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
    ; Misc
    Keys.Feed := new Key("f")
    Keys.Jump := new Key("z")
    Keys.ActionWheel := new Key("i")
    Keys.EmoteWheel := new Key("LAlt")
    ; Zoom
    Keys.ZoomIn := new Key("WheelUp")
    Keys.ZoomOut := new Key("WheelDown")
    ; Inventory
    Keys.Repair := new Key("o")
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.General := new Overlay({transparency: 100}) ; Jump, Feed
    Overlays.Zoom := new Overlay({transparency: 150}) ; Zoom In / Zoom Out
    Overlays.HUD := new Overlay({}) ; Hotbar, Skills, Action Wheel, Emote Wheel
    Overlays.Movement := new Overlay({}) ; Move, Camera
    Overlays.Inventory := new Overlay({transparency: 150}) ; Repair
  }

  setGameUIElements() {
    global
    ; Game UI Elements
    GameUIElements.HealthBar := new GameUIElement({x: 208, y: 653, w: 2, h: 4, color: 0x007283})
    GameUIElements.InventoryWindow := new GameUIElement({x: 123, y: 78, w: 2, h: 3, color: 0x940a0e})
    GameUIElements.CraftingWindow := new GameUIElement({x: 314, y: 78, w: 2, h: 4, color: 0x660507})
  }

  setRegions() {
    global
    ; KeyReleaseRegions
    KeyReleaseOverlay := new Overlay({})
    KeyReleaseOverlay.addRegion("KeyReleaseHotbar",  {noGuiControl: true, background: "0xFFB015", x: 163, y: 670, w: 344, h: 44, keys: [], mode: "none"})
    KeyReleaseOverlay.addRegion("KeyReleaseSidebar", {noGuiControl: true, background: "0xFFB015", x: 1043, y: 138, w: 110, h: 303, keys: [], mode: "none"})

    ; Overlay: General
    Overlays.General.addRegion("SkillFeed", {x: 611, y: 669, w: 29, h: 36, keys: [Keys.Feed], mode: "toggle"})
    Overlays.General.addRegion("SkillJump", {text: "JUMP", x: 554, y: 624, w: 44, h: 22, keys: [Keys.Jump], mode: "toggle"})

    ; Overlay: Zoom
    Overlays.Zoom.addRegion("ZoomIn",  {text: "IN",  color: "0x000000", background: "0x3088F3", x: 17, y: 658, w: 34, h: 20, keys: [Keys.ZoomIn], mode: "press"})
    Overlays.Zoom.addRegion("ZoomOut", {text: "OUT", color: "0x000000", background: "0x3088F3", x: 17, y: 683, w: 34, h: 20, keys: [Keys.ZoomOut], mode: "press"})

    ; Overlay: HUD
    Overlays.HUD.addRegion("HotbarSlot1", {x: 164, y: 671, w: 32, h: 32, keys: [Keys.Slot1], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot2", {x: 203, y: 671, w: 32, h: 32, keys: [Keys.Slot2], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot3", {x: 242, y: 671, w: 32, h: 32, keys: [Keys.Slot3], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot4", {x: 280, y: 671, w: 32, h: 32, keys: [Keys.Slot4], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot5", {x: 319, y: 671, w: 32, h: 32, keys: [Keys.Slot5], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot6", {x: 358, y: 671, w: 32, h: 32, keys: [Keys.Slot6], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot7", {x: 396, y: 671, w: 32, h: 32, keys: [Keys.Slot7], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot8", {x: 435, y: 671, w: 32, h: 32, keys: [Keys.Slot8], mode: "press"})
    Overlays.HUD.addRegion("HotbarSlot9", {x: 474, y: 671, w: 32, h: 32, keys: [Keys.Slot9], mode: "press"})

    Overlays.HUD.addRegion("SkillPrimaryAttack", {x: 652, y: 669, w: 36, h: 36, keys: [Keys.PrimaryAttack], mode: "toggle", manual: true})
    Overlays.HUD.addRegion("SkillWeaponAttack1", {x: 691, y: 669, w: 36, h: 36, keys: [Keys.WeaponAttack1], mode: "toggle"})
    Overlays.HUD.addRegion("SkillWeaponAttack2", {x: 730, y: 669, w: 36, h: 36, keys: [Keys.WeaponAttack2], mode: "toggle"})
    Overlays.HUD.addRegion("SkillDodgeSpell",    {x: 779, y: 669, w: 36, h: 36, keys: [Keys.DodgeSpell], mode: "toggle"})
    Overlays.HUD.addRegion("SkillSpell1",        {x: 828, y: 669, w: 36, h: 36, keys: [Keys.Spell1], mode: "toggle"})
    Overlays.HUD.addRegion("SkillSpell2",        {x: 867, y: 669, w: 36, h: 36, keys: [Keys.Spell2], mode: "toggle"})
    Overlays.HUD.addRegion("SkillUltimate",      {x: 916, y: 669, w: 36, h: 36, keys: [Keys.Ultimate], mode: "toggle"})

    Overlays.HUD.addRegion("WheelAction",      {text: "Action", color: "0x000000", background: "0x3088F3", x: 496, y: 450, w: 40, h: 20, keys: [Keys.ActionWheel], mode: "hold"})
    Overlays.HUD.addRegion("WheelEmote",       {text: "Emote", color: "0x000000", background: "0x3088F3", x: 616, y: 450, w: 40, h: 20, keys: [Keys.EmoteWheel], mode: "hold"})

    ; Overlay: Movement
    Overlays.Movement.addRegion("MoveUp",           {color: "0x000000", background: "0x3088F3", x: 546, y: 270, w: 60, h: 40, keys: [Keys.RotateCamera, Keys.MoveUp], mode: "hold"})
    Overlays.Movement.addRegion("MoveUpRight",      {color: "0x000000", background: "0x3088F3", x: 616, y: 280, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveUp, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveRight",        {color: "0x000000", background: "0x3088F3", x: 626, y: 330, w: 40, h: 60, keys: [Keys.RotateCamera, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveDownRight",    {color: "0x000000", background: "0x3088F3", x: 616, y: 400, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveDown, Keys.MoveRight], mode: "hold"})
    Overlays.Movement.addRegion("MoveDown",         {color: "0x000000", background: "0x3088F3", x: 546, y: 410, w: 60, h: 40, keys: [Keys.RotateCamera, Keys.MoveDown], mode: "hold"})
    Overlays.Movement.addRegion("MoveDownLeft",     {color: "0x000000", background: "0x3088F3", x: 496, y: 400, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveDown, Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveLeft",         {color: "0x000000", background: "0x3088F3", x: 486, y: 330, w: 40, h: 60, keys: [Keys.RotateCamera, Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveUpLeft",       {color: "0x000000", background: "0x3088F3", x: 496, y: 280, w: 40, h: 40, keys: [Keys.RotateCamera, Keys.MoveUp, Keys.MoveLeft], mode: "hold"})
    Overlays.Movement.addRegion("MoveRotateCamera", {color: "0x000000", background: "0x3088F3", x: 536, y: 320, w: 80, h: 80, keys: [Keys.RotateCamera], mode: "hold"})

    ; Overlay: Inventory Repair
    Overlays.Inventory.addRegion("RepairHelmet", {text: "R", x: 205, y:  96, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
    Overlays.Inventory.addRegion("RepairChest",  {text: "R", x: 207, y: 143, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
    Overlays.Inventory.addRegion("RepairGloves", {text: "R", x: 278, y: 202, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
    Overlays.Inventory.addRegion("RepairPants",  {text: "R", x: 207, y: 210, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
    Overlays.Inventory.addRegion("RepairBoots",  {text: "R", x: 207, y: 297, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
    Overlays.Inventory.addRegion("RepairCloak",  {text: "R", x: 145, y: 111, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
    Overlays.Inventory.addRegion("RepairRing",   {text: "R", x: 145, y: 199, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
    Overlays.Inventory.addRegion("RepairSlot1",  {text: "R", x: 122, y: 397, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
    Overlays.Inventory.addRegion("RepairSlot2",  {text: "R", x: 162, y: 397, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
    Overlays.Inventory.addRegion("RepairSlot3",  {text: "R", x: 203, y: 397, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
    Overlays.Inventory.addRegion("RepairSlot4",  {text: "R", x: 244, y: 397, w: 16, h: 16, keys: [Keys.Repair], mode: "press"})
  }

  ; Hooks
  hook_LButtonDown_AfterPress() {
    global
    For k, v in Overlays.General.regions.toggle
      v.releaseKeys()
  }
  hook_LButtonDown_AfterOverlays() {
    global
    If (Overlays.HUD.curState) {
      ; PrimaryAttack manual control
      If (!ClickedRegion && !Overlays.HUD.regions.toggle.SkillPrimaryAttack.curState && !Overlays.HUD.regions.toggle.SkillPrimaryAttack.manual) {
        Overlays.HUD.regions.toggle.SkillPrimaryAttack.manual := true
        Overlays.HUD.regions.toggle.SkillPrimaryAttack.holdKeys()
      }
    }
  }
  hook_LButtonUp_AfterOverlays() {
    global
    ; PrimaryAttack manual control
    If (!ClickedRegion && Overlays.HUD.regions.toggle.SkillPrimaryAttack.manual) {
      Overlays.HUD.regions.toggle.SkillPrimaryAttack.manual := false
      Overlays.HUD.regions.toggle.SkillPrimaryAttack.releaseKeys()
    }
  }
  hook_MidOverlayLoop() {
    global
    ; Check state of GameUIElements and set state of Overlays accordingly
    Overlays.General.newState := GameUIElements.HealthBar.curState
    Overlays.Zoom.newState := !GameUIElements.InventoryWindow.curState && !GameUIElements.CraftingWindow.curState
    Overlays.HUD.newState := GameUIElements.HealthBar.curState && !GameUIElements.InventoryWindow.curState && !GameUIElements.CraftingWindow.curState
    Overlays.Movement.newState := GameUIElements.HealthBar.curState
    Overlays.Inventory.newState := GameUIElements.InventoryWindow.curState
    
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