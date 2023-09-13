Class Region {
  curState := -1
  newState := 0
  updateColor := false
  __New(hwnd, id, opts) {
    this.hwnd := hwnd
    this.id := id

    this.x := opts.x
    this.y := opts.y
    this.w := opts.w
    this.h := opts.h
    this.keys := opts.keys ; Array of Key objects
    this.mode := opts.mode ; `press` | `toggle` | `hold`

    if (opts.hasKey("manual"))
      this.manual := opts.manual

    if (!opts.hasKey("noGuiControl"))
      this.createGuiControl(opts)
  }
  createGuiControl(opts) {
    ; Global scope is required to create GuiControl elements
    global

    ; Background color ON / OFF
    this.background := opts.hasKey("background") ? opts.background : "0x1DB015"
    this.backgroundOff := opts.hasKey("backgroundOff") ? opts.backgroundOff : "0xB01D15"

    ; Foreground color
    opts.value := opts.hasKey("color") ? 100 : 0
    this.color := opts.hasKey("color") ? opts.color : false

    ; Create GuiControl for rectangle
    Gui, % this.hwnd ": Add", Progress, % "X" opts.x " Y" opts.y " W" opts.w " H" opts.h " C" this.color " Background" this.background " v" this.id, % opts.value
    
    ; Create GuiControl for label
    if (this.hasText := opts.hasKey("text"))
      Gui, % this.hwnd ": Add", Text, % "X" opts.x " Y" opts.y " W" opts.w " H" opts.h " CWhite v" this.id "_Text +BackgroundTrans +Center 0x200", % opts.text
  }
  
  update() {
    changed := false
    if (this.curState != this.newState) {
      this.curState := this.newState
      if (this.mode = "toggle") {
        this.updateGuiControl()
      }
      changed := true
    }
    For k, v in this.keys {
      v.update()
    }
    return changed
  }
  updateGuiControl() {
    ; Update color based on state
    GuiControl, % this.hwnd ": +Background" (this.curState ? this.background : this.backgroundOff) , % this.id
    If (this.hasText) {
      GuiControl, % this.hwnd ": Hide", % this.id "_Text"
      GuiControl, % this.hwnd ": Show", % this.id "_Text"
    }
  }

  pressKeys() {
    For k, v in this.keys {
      key := v.key
      Send {%key%}
    }
  }
  toggleKeys() {
    this.newState := !this.newState
    this.updateKeyStates(this.newState)
  }
  holdKeys() {
    If (!this.hasKey("manual") || !this.manual) {
      this.newState := true
      this.updateKeyStates(this.newState)
    } else {
      this.updateKeyStates(true)
    }
  }
  releaseKeys() {
    If (!this.hasKey("manual") || !this.manual) {
      this.newState := false
      this.updateKeyStates(this.newState)
    } else {
      this.updateKeyStates(false)
    }
  }
  updateKeyStates(state) {
    For k, v in this.keys {
      v.newState := state
    }
  }
  
  forceReleaseKeys() {
    For k, v in this.keys {
      v.forceRelease()
    }
  }
}