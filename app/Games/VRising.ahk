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
    Keys.MoveItem := new Key("RButton")
    Keys.SplitItem := new Key("o")
    ; Wake Up
    Keys.Respawn := new Key("Space")
  }

  setOverlays() {
    global
    ; Overlays
    Overlays.General := new Overlay({transparency: 100}) ; Jump, Feed
    Overlays.Zoom := new Overlay({transparency: 150}) ; Zoom In / Zoom Out
    Overlays.HUD := new Overlay({}) ; Hotbar, Skills, Action Wheel, Emote Wheel
    Overlays.Movement := new Overlay({}) ; Move, Camera
    Overlays.Repair := new Overlay({transparency: 150}) ; Repair

    Overlays.UseItemsInventory := new Overlay({transparency: 150}) ; Use in Inventory
    Overlays.MoveItemsInventory := new Overlay({transparency: 200}) ; Move from Inventory
    Overlays.SplitItemsInventory := new Overlay({font: "s10", transparency: 255}) ; Split from Inventory

    Overlays.MoveItemsWorkbench := new Overlay({transparency: 255}) ; Move from Workbench
    Overlays.MoveItemsProcessor := new Overlay({transparency: 255}) ; Move from Processor

    Overlays.SplitItemsWorkbench := new Overlay({font: "s10", transparency: 255}) ; Split from Workbench
    Overlays.SplitItemsProcessor := new Overlay({font: "s10", transparency: 255}) ; Split from Processor
    
    Overlays.MoveItemsStashRow1 := new Overlay({transparency: 255}) ; Move from Stash Row 1
    Overlays.MoveItemsStashRow2 := new Overlay({transparency: 255}) ; Move from Stash Row 2
    Overlays.MoveItemsStashRow3 := new Overlay({transparency: 255}) ; Move from Stash Row 3
    Overlays.MoveItemsStashRow4 := new Overlay({transparency: 255}) ; Move from Stash Row 4
    Overlays.MoveItemsStashRow5 := new Overlay({transparency: 255}) ; Move from Stash Row 5
    Overlays.MoveItemsStashRow6 := new Overlay({transparency: 255}) ; Move from Stash Row 6

    Overlays.SplitItemsStashRow1 := new Overlay({font: "s10", transparency: 255}) ; Split from Stash Row 1
    Overlays.SplitItemsStashRow2 := new Overlay({font: "s10", transparency: 255}) ; Split from Stash Row 2
    Overlays.SplitItemsStashRow3 := new Overlay({font: "s10", transparency: 255}) ; Split from Stash Row 3
    Overlays.SplitItemsStashRow4 := new Overlay({font: "s10", transparency: 255}) ; Split from Stash Row 4
    Overlays.SplitItemsStashRow5 := new Overlay({font: "s10", transparency: 255}) ; Split from Stash Row 5
    Overlays.SplitItemsStashRow6 := new Overlay({font: "s10", transparency: 255}) ; Split from Stash Row 6

    Overlays.SleepWake := new Overlay({transparency: 150}) ; Wake from Sleep
  }

  setGameUIElements() {
    global
    ; Game UI Elements
    GameUIElements.HealthBar := new GameUIElement({x: 208, y: 653, w: 2, h: 4, color: 0x007283})
    GameUIElements.InventoryOrCraftingWindow := new GameUIElement({x: 302, y: 44, w: 2, h: 3, color: 0xd70b0e})
    GameUIElements.InventoryWindow := new GameUIElement({x: 123, y: 78, w: 2, h: 3, color: 0x940a0e, dependency: GameUIElements.InventoryOrCraftingWindow})
    ; May not need this anymore!
    ;GameUIElements.CraftingWindow := new GameUIElement({x: 314, y: 78, w: 2, h: 4, color: 0x660507, dependency: GameUIElements.InventoryOrCraftingWindow})

    GameUIElements.InteractableWindow := new GameUIElement({x: 848, y: 44, w: 3, h: 3, color: 0xd50b0e, dependency: GameUIElements.InventoryOrCraftingWindow})
    GameUIElements.ProcessorArrow := new GameUIElement({x: 846, y: 483, w: 2, h: 2, color: 0x4b6773, dependency: GameUIElements.InteractableWindow})
    GameUIElements.WorkbenchContainerA := new GameUIElement({x: 853, y: 502, w: 1, h: 3, color: 0x505d63, dependency: GameUIElements.InteractableWindow})
    
    GameUIElements.StashRow1Box := new GameUIElement({x: 709, y: 85, w: 1, h: 2, color: 0x3b2316, dependency: GameUIElements.InteractableWindow})
    GameUIElements.StashRow2Box := new GameUIElement({x: 709, y: 126, w: 1, h: 2, color: 0x3b2316, dependency: GameUIElements.InteractableWindow})
    GameUIElements.StashRow3Box := new GameUIElement({x: 709, y: 167, w: 1, h: 2, color: 0x3b2316, dependency: GameUIElements.InteractableWindow})
    GameUIElements.StashRow4Box := new GameUIElement({x: 709, y: 208, w: 1, h: 2, color: 0x3b2316, dependency: GameUIElements.InteractableWindow})
    GameUIElements.StashRow5Box := new GameUIElement({x: 709, y: 249, w: 1, h: 2, color: 0x3b2316, dependency: GameUIElements.InteractableWindow})
    GameUIElements.StashRow6Box := new GameUIElement({x: 709, y: 289, w: 1, h: 2, color: 0x3b2316, dependency: GameUIElements.InteractableWindow})

    GameUIElements.MapZoomMouse := new GameUIElement({x: 446, y: 690, w: 3, h: 1, color: 0x7b797b, dependency: GameUIElements.HealthBar, dependencyLogic: false})
    GameUIElements.SleepSpaceP := new GameUIElement({x: 537, y: 638, w: 1, h: 2, color: 0x82c9d9, dependency: GameUIElements.HealthBar, dependencyLogic: false})
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

    Overlays.HUD.addRegion("SkillPrimaryAttack", {x: 652, y: 669, w: 36, h: 36, keys: [Keys.PrimaryAttack], mode: "toggle"})
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
    Overlays.Repair.addRegion("RepairHelmet", {text: "R", x: 205, y:  96, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})
    Overlays.Repair.addRegion("RepairChest",  {text: "R", x: 207, y: 143, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})
    Overlays.Repair.addRegion("RepairGloves", {text: "R", x: 278, y: 202, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})
    Overlays.Repair.addRegion("RepairPants",  {text: "R", x: 207, y: 210, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})
    Overlays.Repair.addRegion("RepairBoots",  {text: "R", x: 207, y: 297, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})
    Overlays.Repair.addRegion("RepairCloak",  {text: "R", x: 145, y: 111, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})
    Overlays.Repair.addRegion("RepairRing",   {text: "R", x: 145, y: 199, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})
    Overlays.Repair.addRegion("RepairSlot1",  {text: "R", x: 122, y: 397, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})
    Overlays.Repair.addRegion("RepairSlot2",  {text: "R", x: 162, y: 397, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})
    Overlays.Repair.addRegion("RepairSlot3",  {text: "R", x: 203, y: 397, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})
    Overlays.Repair.addRegion("RepairSlot4",  {text: "R", x: 244, y: 397, w: 14, h: 14, keys: [Keys.Repair], mode: "press"})

    ; Overlay: Use and Move Inventory Items
    GridCoordsX := [122,162,203,244,285,326,366,407,448]
    GridCoordsY := [419,460,501,541]
    Loop, % GridCoordsY.Count() {
      row := A_Index
      Loop, % GridCoordsX.Count() {
        col := A_Index
        cell := col + ((row-1) * GridCoordsX.Count())
        Overlays.UseItemsInventory.addRegion("UseItemsInventorySlot" . cell,  {text: "U", background: "0x660507", x: GridCoordsX[col] + 20, y: GridCoordsY[row], w: 14, h: 14, keys: [Keys.MoveItem], mode: "press"})
        Overlays.MoveItemsInventory.addRegion("MoveItemsInventorySlot" . cell,  {text: "🡆", background: "transparent", x: GridCoordsX[col] + 20, y: GridCoordsY[row], w: 14, h: 14, keys: [Keys.MoveItem], mode: "press"})
        if (row > 1)
          Overlays.SplitItemsInventory.addRegion("SplitItemsInventorySlot" . cell,  {text: "½", background: "transparent", x: GridCoordsX[col], y: GridCoordsY[row], w: 14, h: 14, keys: [Keys.SplitItem], mode: "press"})
      }
    }

    ; Overlay: Move Stash Items
    GridCoordsX := [710,750,791,832,872,913,954]
    GridCoordsY := [90,131,171,212,252,293]
    Loop, % GridCoordsY.Count() {
      row := A_Index
      moveID := "MoveItemsStashRow" . row
      splitID := "SplitItemsStashRow" . row
      Loop, % GridCoordsX.Count() {
        col := A_Index
        cell := col + ((row-1) * GridCoordsX.Count())
        Overlays[moveID].addRegion(moveID . "Slot" . cell,  {text: "🡄", background: "transparent", x: GridCoordsX[col] + 20, y: GridCoordsY[row], w: 14, h: 14, keys: [Keys.MoveItem], mode: "press"})
        Overlays[splitID].addRegion(splitID . "Slot" . cell,  {text: "½", background: "transparent", x: GridCoordsX[col], y: GridCoordsY[row], w: 14, h: 14, keys: [Keys.SplitItem], mode: "press"})
      }
    }

    ; Overlay: Move Workbench Items
    GridCoordsX := [689,730,771,812,852,893,933,974]
    GridCoordsY := [540]
    Loop, % GridCoordsY.Count() {
      row := A_Index
      Loop, % GridCoordsX.Count() {
        col := A_Index
        cell := col + ((row-1) * GridCoordsX.Count())
        Overlays.MoveItemsWorkbench.addRegion("MoveItemsWorkbenchSlot" . cell,  {text: "🡄", background: "transparent", x: GridCoordsX[col] + 20, y: GridCoordsY[row], w: 14, h: 14, keys: [Keys.MoveItem], mode: "press"})
        Overlays.SplitItemsWorkbench.addRegion("SplitItemsWorkbenchSlot" . cell,  {text: "½", background: "transparent", x: GridCoordsX[col], y: GridCoordsY[row], w: 14, h: 14, keys: [Keys.SplitItem], mode: "press"})
      }
    }

    ; Overlay: Move Processor Items
    GridCoordsX := [673,715,757,799,863,905,947,989]
    GridCoordsY := [476,518]
    Loop, % GridCoordsY.Count() {
      row := A_Index
      Loop, % GridCoordsX.Count() {
        col := A_Index
        cell := col + ((row-1) * GridCoordsX.Count())
        Overlays.MoveItemsProcessor.addRegion("MoveItemsProcessorSlot" . cell,  {text: "🡄", background: "transparent", x: GridCoordsX[col] + 20, y: GridCoordsY[row], w: 14, h: 14, keys: [Keys.MoveItem], mode: "press"})
        Overlays.SplitItemsProcessor.addRegion("SplitItemsProcessorSlot" . cell,  {text: "½", background: "transparent", x: GridCoordsX[col], y: GridCoordsY[row], w: 14, h: 14, keys: [Keys.SplitItem], mode: "press"})
      }
    }

    ; Wake from Sleep
    Overlays.SleepWake.addRegion("WakeFromSleep",  {color: "0x000001", background: "0x3088F3", x: 466, y: 622, w: 219, h: 31, keys: [Keys.Respawn], mode: "press"})
  }

  ; Hooks
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
    If (!ClickedRegion && Overlays.HUD.regions.toggle.SkillPrimaryAttack.curState) {
      Overlays.HUD.regions.toggle.SkillPrimaryAttack.forceReleaseKeys()
    }
  }
  hook_MidOverlayLoop() {
    global
    ; Check state of GameUIElements and set state of Overlays accordingly
    Overlays.General.newState := GameUIElements.HealthBar.curState
    Overlays.Zoom.newState := !GameUIElements.InventoryOrCraftingWindow.curState
    Overlays.HUD.newState := GameUIElements.HealthBar.curState && !GameUIElements.InventoryOrCraftingWindow.curState
    Overlays.Movement.newState := GameUIElements.HealthBar.curState
    Overlays.Repair.newState := GameUIElements.InventoryWindow.curState

    Overlays.UseItemsInventory.newState := GameUIElements.InventoryOrCraftingWindow.curState && !GameUIElements.InteractableWindow.curState
    Overlays.MoveItemsInventory.newState := GameUIElements.InventoryOrCraftingWindow.curState && GameUIElements.InteractableWindow.curState
    Overlays.SplitItemsInventory.newState := GameUIElements.InventoryOrCraftingWindow.curState

    Overlays.MoveItemsWorkbench.newState := GameUIElements.WorkbenchContainerA.curState
    Overlays.MoveItemsProcessor.newState := GameUIElements.ProcessorArrow.curState

    Overlays.SplitItemsWorkbench.newState := GameUIElements.WorkbenchContainerA.curState
    Overlays.SplitItemsProcessor.newState := GameUIElements.ProcessorArrow.curState

    Overlays.MoveItemsStashRow1.newState := GameUIElements.StashRow1Box.curState
    Overlays.MoveItemsStashRow2.newState := GameUIElements.StashRow2Box.curState
    Overlays.MoveItemsStashRow3.newState := GameUIElements.StashRow3Box.curState
    Overlays.MoveItemsStashRow4.newState := GameUIElements.StashRow4Box.curState
    Overlays.MoveItemsStashRow5.newState := GameUIElements.StashRow5Box.curState
    Overlays.MoveItemsStashRow6.newState := GameUIElements.StashRow6Box.curState

    Overlays.SplitItemsStashRow1.newState := GameUIElements.StashRow1Box.curState
    Overlays.SplitItemsStashRow2.newState := GameUIElements.StashRow2Box.curState
    Overlays.SplitItemsStashRow3.newState := GameUIElements.StashRow3Box.curState
    Overlays.SplitItemsStashRow4.newState := GameUIElements.StashRow4Box.curState
    Overlays.SplitItemsStashRow5.newState := GameUIElements.StashRow5Box.curState
    Overlays.SplitItemsStashRow6.newState := GameUIElements.StashRow6Box.curState

    Overlays.SleepWake.newState := !GameUIElements.HealthBar.curState && !GameUIElements.MapZoomMouse.curState && GameUIElements.SleepSpaceP.curState

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