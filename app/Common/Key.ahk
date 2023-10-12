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
    If (this.curState && !GetKeyState(this.key))
      this.down()
    If (!this.curState && GetKeyState(this.key))
      this.up()
  }
  down() {
    key := this.key
    Send {%key% Down}
  }
  up() {
    key := this.key
    Send {%key% Up}
  }
  forceRelease() {
    If (GetKeyState(this.key))
      this.up()
  }
}