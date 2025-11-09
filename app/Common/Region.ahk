Class Region {
  curState := -1
  newState := 0
  updateColor := false
  __New(overlay, id, opts) {
    this.overlay := overlay
    this.id := id

    this.x := opts.x
    this.y := opts.y
    this.w := opts.w
    this.h := opts.h
    this.keys := opts.keys ; Array of Key objects
    this.mode := opts.mode ; `press` | `toggle` | `hold` | `special` | `timer`
    this.specialHook := opts.hasKey("specialHook") ? opts.specialHook : false

    this.hasText := opts.hasKey("text")
    this.text := this.hasText ? opts.text : ""

    this.time := opts.hasKey("time") ? opts.time : 0
    Switch (this.mode) {
      case "timer":
        this.timerFunc := ObjBindMethod(this, "timerEvent")
    }

    if (!opts.hasKey("noGuiControl"))
      this.createGuiControl(opts)
  }
  createGuiControl(opts) {
    ; Global scope is required to create GuiControl elements
    global

    ; Background color ON / OFF / TIMER (triggered when timer presses the keys)
    this.background := opts.hasKey("background") ? opts.background : "0x1DB015"
    this.backgroundOff := opts.hasKey("backgroundOff") ? opts.backgroundOff : "0xB01D15"
    this.backgroundTimer := opts.hasKey("backgroundTimer") ? opts.backgroundTimer : "0x3088F3"

    ; Foreground color
    this.value := opts.hasKey("color") ? 100 : 0
    this.color := opts.hasKey("color") ? opts.color : false
    this.colorOff := opts.hasKey("colorOff") ? opts.colorOff : opts.color
    this.colorTimer := opts.hasKey("colorTimer") ? opts.colorTimer : this.backgroundTimer

    ; Text color
    this.textColor := opts.hasKey("textColor") ? opts.textColor : "White"

    ; Create GuiControl for rectangle
    if (this.hasRect := (this.background != "transparent"))
      Gui, % this.overlay ": Add", Progress, % "X" this.x " Y" this.y " W" this.w " H" this.h " C" this.color " Background" this.background " v" this.id, % this.value
    
    ; Create GuiControl for label
    if (this.hasText := opts.hasKey("text"))
      Gui, % this.overlay ": Add", Text, % "X" this.x " Y" this.y " W" this.w " H" this.h " C" this.textColor " v" this.id "_Text +BackgroundTrans +Center 0x200", % this.text
  }
  
  update() {
    changed := false
    if (this.curState != this.newState) {
      this.curState := this.newState
      if (this.mode = "toggle" || this.mode = "timer") {
        this.updateGuiControl()
      }
      changed := true
    }
    if (this.curState && this.mode = "special") {
      GAME.hook_Special(this)
    } else {
      For k, v in this.keys {
        v.update()
      }
    }
    return changed
  }
  updateGuiControl(flash := false) {
    ; Update color based on state
    If (this.hasRect) {
      if (flash) {
        GuiControl, % this.overlay ": +Background" (this.curState ? this.backgroundTimer : this.backgroundOff) , % this.id
        this.hasKey("color")
          GuiControl, % this.overlay ": +C" (this.curState ? this.colorTimer : this.colorOff) , % this.id
      } else {
        GuiControl, % this.overlay ": +Background" (this.curState ? this.background : this.backgroundOff) , % this.id
        this.hasKey("color")
          GuiControl, % this.overlay ": +C" (this.curState ? this.color : this.colorOff) , % this.id
      }
    }
    If (this.hasText) {
      GuiControl, % this.overlay ": Hide", % this.id "_Text"
      GuiControl, % this.overlay ": Show", % this.id "_Text"
    }
  }
  updateGuiControlPosition() {
    GuiControl, % this.overlay ": MoveDraw", % this.id, % "+X" this.x " +Y" this.y
  }
  hideGuiControl() {
    If (this.hasRect)
      GuiControl, % this.overlay ": Hide", % this.id
    If (this.hasText)
      GuiControl, % this.overlay ": Hide", % this.id "_Text"
  }
  timerEvent() {
    this.updateGuiControl(true)
    this.pressKeys()
    this.updateGuiControl(false)
  }

  pressKeys() {
    For k, v in this.keys {
      key := v.key
      Switch (key) {
        case "RButton":
          Click, Right
        case "MButton":
          Click, Middle
        default:
          Send {%key%}
      }
    }
  }
  toggleKeys() {
    this.newState := !this.newState
    this.updateKeyStates(this.newState)
  }
  timerKeys() {
    this.newState := !this.newState
    timer := this.timerFunc
    If (this.newState) {
      this.timerFunc()
      SetTimer, %timer%, % this.time
    } Else {
      SetTimer, %timer%, Off
      this.releaseKeys()
    }
  }
  holdKeys() {
    this.newState := true
    this.updateKeyStates(this.newState)
  }
  releaseKeys() {
    this.newState := false
    this.updateKeyStates(this.newState)
  }
  updateKeyStates(state) {
    For k, v in this.keys {
      v.newState := state
    }
  }
  
  disableTimers() {
    this.newState := false
    timer := this.timerFunc
    SetTimer, %timer%, Off
    this.releaseKeys()
  }
  forceReleaseKeys() {
    For k, v in this.keys {
      v.forceRelease()
    }
  }
}