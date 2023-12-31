﻿Class VRising extends Game {
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
    Keys.AutoWalk := new Key("Up")
    Keys.Teleport := new Key("Home")
    ; Misc
    Keys.Feed := new Key("f")
    Keys.Jump := new Key("z")
    Keys.ActionWheel := new Key("i")
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
    Overlays.General := new Overlay({transparency: 120}) ; Jump, Feed
    Overlays.Zoom := new Overlay({transparency: 150}) ; Zoom In / Zoom Out
    Overlays.HUD := new Overlay({}) ; Hotbar, Skills
    Overlays.HUDCenter := new Overlay({transparency: 120}) ; Primary Skill, Action Wheel, Emote Wheel
    Overlays.Movement := new Overlay({transparency: 120}) ; Move, Camera
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

    Overlays.MoveItemsBagAInventorySmall := new Overlay({transparency: 255}) ; Move from Bag A (Small)
    Overlays.MoveItemsBagAInventoryMedium := new Overlay({transparency: 255}) ; Move from Bag A (Medium)
    Overlays.MoveItemsBagAInventoryLarge := new Overlay({transparency: 255}) ; Move from Bag A (Large)
    Overlays.MoveItemsBagAInventoryGrand := new Overlay({transparency: 255}) ; Move from Bag A (Grand)

    Overlays.MoveItemsBagBInventorySmall := new Overlay({transparency: 255}) ; Move from Bag B (Small)
    Overlays.MoveItemsBagBInventoryMedium := new Overlay({transparency: 255}) ; Move from Bag B (Medium)
    Overlays.MoveItemsBagBInventoryLarge := new Overlay({transparency: 255}) ; Move from Bag B (Large)
    Overlays.MoveItemsBagBInventoryGrand := new Overlay({transparency: 255}) ; Move from Bag B (Grand)

    Overlays.MoveItemsBagCInventorySmall := new Overlay({transparency: 255}) ; Move from Bag C (Small)
    Overlays.MoveItemsBagCInventoryMedium := new Overlay({transparency: 255}) ; Move from Bag C (Medium)
    Overlays.MoveItemsBagCInventoryLarge := new Overlay({transparency: 255}) ; Move from Bag C (Large)
    Overlays.MoveItemsBagCInventoryGrand := new Overlay({transparency: 255}) ; Move from Bag C (Grand)

    Overlays.MoveItemsBagDInventorySmall := new Overlay({transparency: 255}) ; Move from Bag D (Small)
    Overlays.MoveItemsBagDInventoryMedium := new Overlay({transparency: 255}) ; Move from Bag D (Medium)
    Overlays.MoveItemsBagDInventoryLarge := new Overlay({transparency: 255}) ; Move from Bag D (Large)
    Overlays.MoveItemsBagDInventoryGrand := new Overlay({transparency: 255}) ; Move from Bag D (Grand)

    Overlays.SleepWake := new Overlay({transparency: 150}) ; Wake from Sleep
  }

  setGameUIElements() {
    global
    ; Game UI Elements
    GameUIElements.HealthBar := new GameUIElement({x: 208, y: 653, w: 2, h: 4, color: 0x007283})
    GameUIElements.InventoryOrCraftingWindow := new GameUIElement({x: 302, y: 44, w: 2, h: 3, color: 0xd70b0e})
    GameUIElements.InventoryWindow := new GameUIElement({x: 123, y: 78, w: 2, h: 3, color: 0x940a0e, dependency: GameUIElements.InventoryOrCraftingWindow})
    GameUIElements.BagInventory := new GameUIElement({x: 123, y: 382, w: 2, h: 3, color: 0x010101, dependency: GameUIElements.InventoryWindow})
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
    
    ; TODO: BagAInventory etc checks are the same as BagInventory checks for now.
    ;       Should be fixed because it leaves extra arrows when fewer than 4 bags are equipped.
    GameUIElements.BagAInventory       := new GameUIElement({x: 123, y: 382, w: 2, h: 3, color: 0x010101, dependency: GameUIElements.BagInventory})
    GameUIElements.BagAInventorySmall  := new GameUIElement({x: 287, y: 285, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagAInventoryMedium})
    GameUIElements.BagAInventoryMedium := new GameUIElement({x: 206, y: 325, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagAInventoryLarge})
    GameUIElements.BagAInventoryLarge  := new GameUIElement({x: 287, y: 325, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagAInventory})
    
    GameUIElements.BagBInventory       := new GameUIElement({x: 123, y: 382, w: 2, h: 3, color: 0x010101, dependency: GameUIElements.BagInventory})
    GameUIElements.BagBInventorySmall  := new GameUIElement({x: 470, y: 285, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagBInventoryMedium})
    GameUIElements.BagBInventoryMedium := new GameUIElement({x: 378, y: 325, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagBInventoryLarge})
    GameUIElements.BagBInventoryLarge  := new GameUIElement({x: 470, y: 325, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagBInventory})
    
    GameUIElements.BagCInventory       := new GameUIElement({x: 123, y: 382, w: 2, h: 3, color: 0x010101, dependency: GameUIElements.BagInventory})
    GameUIElements.BagCInventorySmall  := new GameUIElement({x: 287, y: 157, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagCInventoryMedium})
    GameUIElements.BagCInventoryMedium := new GameUIElement({x: 206, y: 198, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagCInventoryLarge})
    GameUIElements.BagCInventoryLarge  := new GameUIElement({x: 287, y: 198, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagCInventory})
    
    GameUIElements.BagDInventory       := new GameUIElement({x: 123, y: 382, w: 2, h: 3, color: 0x010101, dependency: GameUIElements.BagInventory})
    GameUIElements.BagDInventorySmall  := new GameUIElement({x: 470, y: 157, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagDInventoryMedium})
    GameUIElements.BagDInventoryMedium := new GameUIElement({x: 378, y: 198, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagDInventoryLarge})
    GameUIElements.BagDInventoryLarge  := new GameUIElement({x: 470, y: 198, w: 1, h: 1, color: 0x0b0a0d, dependency: GameUIElements.BagDInventory})

    GameUIElements.MapZoomMouse := new GameUIElement({x: 446, y: 690, w: 3, h: 1, color: 0x7b797b, dependency: GameUIElements.HealthBar, dependencyLogic: false})
    GameUIElements.SleepSpaceP := new GameUIElement({x: 537, y: 638, w: 1, h: 2, color: 0x82c9d9, dependency: GameUIElements.HealthBar, dependencyLogic: false})
  }

  setRegions() {
    global
    ; KeyReleaseRegions
    KeyReleaseOverlay := new Overlay({})
    KeyReleaseOverlay.addRegion("KeyReleaseHotbar",  {noGuiControl: true, background: "0xFFB015", x: 163, y: 670, w: 344, h: 44, keys: [], mode: "none"})
    KeyReleaseOverlay.addRegion("KeyReleaseSidebar", {noGuiControl: true, background: "0xFFB015", x: 1043, y: 138, w: 110, h: 303, keys: [], mode: "none"})

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

    Overlays.HUD.addRegion("SkillWeaponAttack1", {x: 691, y: 669, w: 36, h: 36, keys: [Keys.WeaponAttack1], mode: "toggle"})
    Overlays.HUD.addRegion("SkillWeaponAttack2", {x: 730, y: 669, w: 36, h: 36, keys: [Keys.WeaponAttack2], mode: "toggle"})
    Overlays.HUD.addRegion("SkillDodgeSpell",    {x: 779, y: 669, w: 36, h: 36, keys: [Keys.DodgeSpell], mode: "toggle"})
    Overlays.HUD.addRegion("SkillSpell1",        {x: 828, y: 669, w: 36, h: 36, keys: [Keys.Spell1], mode: "toggle"})
    Overlays.HUD.addRegion("SkillSpell2",        {x: 867, y: 669, w: 36, h: 36, keys: [Keys.Spell2], mode: "toggle"})
    Overlays.HUD.addRegion("SkillUltimate",      {x: 916, y: 669, w: 36, h: 36, keys: [Keys.Ultimate], mode: "toggle"})

    Overlays.HUDCenter.addRegion("WheelAction",        {text: "Ctrl", color: "0x000000", background: "0x3088F3", x: 519, y: 285, w: 30, h: 16, keys: [Keys.ActionWheel], mode: "hold"})
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

    ; Overlay: Move Bag Items
    GridCoordsX := [154,194,235,275,336,378,418,459]
    GridCoordsY := [274,314,146,187]
    BagLabelSize := ["Small","Small","Small","Medium","Medium","Large","Large","Grand"]
    BagLabelPosition := ["A","B","C","D"]
    halfColCount := Round(GridCoordsX.Count() / 2)
    halfRowCount := Round(GridCoordsY.Count() / 2)
    Loop, % GridCoordsY.Count() {
      row := A_Index
      Loop, % GridCoordsX.Count() {
        col := A_Index
        cell := Mod(col-1, halfColCount) + ((Mod(row-1, halfRowCount)) * halfColCount) + 1
        
        ; I hate this but it works
        if (col <= halfColCount && row <= halfRowCount)
          position := 1
        else if (col > halfColCount && row <= halfRowCount)
          position := 2
        else if (col <= halfColCount && row > halfRowCount)
          position := 3
        else if (col > halfColCount && row > halfRowCount)
          position := 4

        moveID := "MoveItemsBag" . BagLabelPosition[position] . "Inventory" . BagLabelSize[cell]
        Overlays[moveID].addRegion(moveID . "Slot" . cell,  {text: "🡇", background: "transparent", x: GridCoordsX[col], y: GridCoordsY[row], w: 14, h: 14, keys: [Keys.MoveItem], mode: "press"})
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
    Overlays.General.newState := GameUIElements.HealthBar.curState
    Overlays.Zoom.newState := !GameUIElements.InventoryOrCraftingWindow.curState
    Overlays.HUD.newState := GameUIElements.HealthBar.curState && !GameUIElements.InventoryOrCraftingWindow.curState
    Overlays.HUDCenter.newState := Overlays.HUD.newState ; Same as HUD
    Overlays.Movement.newState := GameUIElements.HealthBar.curState
    Overlays.Repair.newState := GameUIElements.InventoryWindow.curState && !GameUIElements.BagInventory.curState

    Overlays.UseItemsInventory.newState := GameUIElements.InventoryOrCraftingWindow.curState && !GameUIElements.InteractableWindow.curState
    Overlays.MoveItemsInventory.newState := GameUIElements.InventoryOrCraftingWindow.curState && GameUIElements.InteractableWindow.curState
    Overlays.SplitItemsInventory.newState := GameUIElements.InventoryOrCraftingWindow.curState

    Overlays.MoveItemsWorkbench.newState := GameUIElements.WorkbenchContainerA.curState
    Overlays.MoveItemsProcessor.newState := GameUIElements.ProcessorArrow.curState

    Overlays.SplitItemsWorkbench.newState := GameUIElements.WorkbenchContainerA.curState
    Overlays.SplitItemsProcessor.newState := GameUIElements.ProcessorArrow.curState

    Overlays.MoveItemsStashRow1.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow1Box.curState
    Overlays.MoveItemsStashRow2.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow2Box.curState
    Overlays.MoveItemsStashRow3.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow3Box.curState
    Overlays.MoveItemsStashRow4.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow4Box.curState
    Overlays.MoveItemsStashRow5.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow5Box.curState
    Overlays.MoveItemsStashRow6.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow6Box.curState

    Overlays.SplitItemsStashRow1.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow1Box.curState
    Overlays.SplitItemsStashRow2.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow2Box.curState
    Overlays.SplitItemsStashRow3.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow3Box.curState
    Overlays.SplitItemsStashRow4.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow4Box.curState
    Overlays.SplitItemsStashRow5.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow5Box.curState
    Overlays.SplitItemsStashRow6.newState := !GameUIElements.WorkbenchContainerA.curState && !GameUIElements.ProcessorArrow.curState && GameUIElements.StashRow6Box.curState

    Overlays.MoveItemsBagAInventorySmall.newState := GameUIElements.BagAInventory.curState
    Overlays.MoveItemsBagAInventoryMedium.newState := GameUIElements.BagAInventory.curState && !GameUIElements.BagAInventorySmall.curState
    Overlays.MoveItemsBagAInventoryLarge.newState := GameUIElements.BagAInventory.curState && !GameUIElements.BagAInventoryMedium.curState
    Overlays.MoveItemsBagAInventoryGrand.newState := GameUIElements.BagAInventory.curState && !GameUIElements.BagAInventoryLarge.curState

    Overlays.MoveItemsBagBInventorySmall.newState := GameUIElements.BagBInventory.curState
    Overlays.MoveItemsBagBInventoryMedium.newState := GameUIElements.BagBInventory.curState && !GameUIElements.BagBInventorySmall.curState
    Overlays.MoveItemsBagBInventoryLarge.newState := GameUIElements.BagBInventory.curState && !GameUIElements.BagBInventoryMedium.curState
    Overlays.MoveItemsBagBInventoryGrand.newState := GameUIElements.BagBInventory.curState && !GameUIElements.BagBInventoryLarge.curState
    
    Overlays.MoveItemsBagCInventorySmall.newState := GameUIElements.BagCInventory.curState
    Overlays.MoveItemsBagCInventoryMedium.newState := GameUIElements.BagCInventory.curState && !GameUIElements.BagCInventorySmall.curState
    Overlays.MoveItemsBagCInventoryLarge.newState := GameUIElements.BagCInventory.curState && !GameUIElements.BagCInventoryMedium.curState
    Overlays.MoveItemsBagCInventoryGrand.newState := GameUIElements.BagCInventory.curState && !GameUIElements.BagCInventoryLarge.curState
    
    Overlays.MoveItemsBagDInventorySmall.newState := GameUIElements.BagDInventory.curState
    Overlays.MoveItemsBagDInventoryMedium.newState := GameUIElements.BagDInventory.curState && !GameUIElements.BagDInventorySmall.curState
    Overlays.MoveItemsBagDInventoryLarge.newState := GameUIElements.BagDInventory.curState && !GameUIElements.BagDInventoryMedium.curState
    Overlays.MoveItemsBagDInventoryGrand.newState := GameUIElements.BagDInventory.curState && !GameUIElements.BagDInventoryLarge.curState

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