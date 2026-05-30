Class Key {
  curState := -1
  newState := 0
  managed := false
  __New(key) {
    this.key := key
  }
  update() {
    ; Update virtual state
    if (this.curState != this.newState)
      this.curState := this.newState

    ; Update real keypress state
    If (this.curState && !GetKeyState(this.key))
      this.down()
    If (!this.curState && this.managed && GetKeyState(this.key))
      this.up()
  }
  down() {
    this.managed := true
    key := this.key
    Send, {%key% Down}
  }
  up() {
    this.managed := false
    key := this.key
    Send, {%key% Up}
  }
  forceRelease() {
    If (GetKeyState(this.key))
      this.up()
  }
}