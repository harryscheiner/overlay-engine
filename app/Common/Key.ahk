Class Key {
  curState := -1
  newState := 0
  __New(key) {
    this.key := key
  }
  update() {
    ; Update virtual state
    if (this.curState != this.newState)
      this.curState := this.newState

    ; Update real keypress state
    key := this.key
    If (this.curState && !GetKeyState(key))
      Send {%key% Down}
    If (!this.curState && GetKeyState(key))
      Send {%key% Up}
  }

  forceRelease() {
    key := this.key
    If (GetKeyState(key))
      Send {%key% Up}
  }
}