Class Game {
  __New() {
    this.matchGame()
    this.setKeys()
    this.setOverlays()
    this.setGameUIElements()
    this.setRegions()
    SetTimer OverlayLoop, 100
  }

  ; Init functions
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

  ; Hooks
  hook_LButtonDown_AfterHold() {
  }
  hook_LButtonDown_AfterPress() {
  }
  hook_LButtonDown_AfterToggle() {
  }
  hook_LButtonDown_AfterOverlays() {
  }
  hook_LButtonUp_AfterOverlays() {
  }
  hook_MidOverlayLoop() {
  }
}