Class Game {
  initialized := false

  __New() {
    this.matchGame()
    SetTimer OverlayLoop, 100
  }

  ; Get window position/dimensions
  getPos(hGame) {
    ; Window position variables
    WinGetPos x, y, w, h, % "ahk_id " hGame
    getClientSize(hGame, w, h)
    this.windowX := x
    this.windowY := y
    this.windowW := w
    this.windowH := h

    ; Window offset variables
    this.offsetX := getWindowOffset("x")
    this.offsetY := getWindowOffset("y")
  }

  ; Init functions
  init() {
    this.initialized := true
    this.setKeys()
    this.setOverlays()
    this.setGameUIElements()
    this.setRegions()
  }
  matchGame() {
    ; EXAMPLES:
    
    ;global ; Must begin script with this
    
    ; Set the match mode
    ;SetTitleMatchMode 2 ; 1 = Starts with, 2 = Contains, 3 = Exact
    
    ; Open a new window - "New Text Document.txt - Notepad"
    ; To match by title:
    ;GAME_TITLE := "Notepad"                         ; Works with 2
    ;GAME_TITLE := "New Text Document.txt - Notepad" ; Works with 2 or 3
    ;GAME_TITLE := "New"                             ; Works with 1 or 2
    ; To match by EXE name:
    ;GAME_TITLE := "ahk_exe notepad.exe"             ; Works with 1, 2, or 3
  }
  setKeys() {
  }
  setOverlays() {
  }
  setGameUIElements() {
  }
  setRegions() {
  }
  setRegionPositions() {
  }

  ; Hooks
  hook_Special(v) {
  }
  hook_LButtonDown_AfterHold() {
  }
  hook_LButtonDown_AfterPress() {
  }
  hook_LButtonDown_AfterToggle() {
  }
  hook_LButtonDown_AfterTimer() {
  }
  hook_LButtonDown_AfterOverlays() {
  }
  hook_LButtonUp_AfterOverlays() {
  }
  hook_MidOverlayLoop() {
  }
}