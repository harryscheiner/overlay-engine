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
    this.mode := opts.mode ; `press` | `toggle` | `hold` | `special` | `timer`
    this.specialHook := opts.hasKey("specialHook") ? opts.specialHook : false

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
    opts.value := opts.hasKey("color") ? 100 : 0
    this.color := opts.hasKey("color") ? opts.color : false
    this.colorOff := opts.hasKey("colorOff") ? opts.colorOff : opts.color
    this.colorTimer := opts.hasKey("colorTimer") ? opts.colorTimer : this.backgroundTimer

    ; Text color
    this.textColor := opts.hasKey("textColor") ? opts.textColor : "White"

    ; Create GuiControl for rectangle
    if (this.hasRect := (this.background != "transparent"))
      Gui, % this.hwnd ": Add", Progress, % "X" opts.x " Y" opts.y " W" opts.w " H" opts.h " C" this.color " Background" this.background " v" this.id, % opts.value
    
    ; Create GuiControl for label
    if (this.hasText := opts.hasKey("text"))
      Gui, % this.hwnd ": Add", Text, % "X" opts.x " Y" opts.y " W" opts.w " H" opts.h " C" this.textColor " v" this.id "_Text +BackgroundTrans +Center 0x200", % opts.text
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
        GuiControl, % this.hwnd ": +Background" (this.curState ? this.backgroundTimer : this.backgroundOff) , % this.id
        this.hasKey("color")
          GuiControl, % this.hwnd ": +C" (this.curState ? this.colorTimer : this.colorOff) , % this.id
      } else {
        GuiControl, % this.hwnd ": +Background" (this.curState ? this.background : this.backgroundOff) , % this.id
        this.hasKey("color")
          GuiControl, % this.hwnd ": +C" (this.curState ? this.color : this.colorOff) , % this.id
      }
    }
    If (this.hasText) {
      GuiControl, % this.hwnd ": Hide", % this.id "_Text"
      GuiControl, % this.hwnd ": Show", % this.id "_Text"
    }
  }
  updateGuiControlPosition() {
    xpos := this.x
    ypos := this.y
    width := this.w
    height := this.height
    GuiControl, % this.hwnd ": MoveDraw", % this.id, x%xpos% y%ypos%
  }
  hideGuiControl() {
    If (this.hasRect)
      GuiControl, % this.hwnd ": Hide", % this.id
    If (this.hasText)
      GuiControl, % this.hwnd ": Hide", % this.id "_Text"
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
  
  forceReleaseKeys() {
    For k, v in this.keys {
      v.forceRelease()
    }
  }
}