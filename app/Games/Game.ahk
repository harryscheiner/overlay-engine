Class Game {
  initialized := false
  prevWindowW := -1
  prevWindowH := -1

  __New() {
    this.offsetX := getWindowOffset("x")
    this.offsetY := getWindowOffset("y")
  }

  ; Get window position/dimensions
  getPos(hGame) {
    WinGetPos x, y, w, h, % "ahk_id " hGame
    getClientSize(hGame, w, h)
    this.windowX := x
    this.windowY := y
    this.windowW := w
    this.windowH := h
  }

  ; Init functions
  init() {
    this.initialized := true
    this.setKeys()
    this.setOverlays()
    this.setGameUIElements()
    this.setRegions()
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
  hook_Special(r) {
    ;global
    ;if (r.curState) {
    ;  if (r.specialHook = "Example") {
    ;  }
    ;}
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