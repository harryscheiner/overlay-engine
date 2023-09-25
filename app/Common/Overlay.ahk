Class Overlay {
  curState := -1
  newState := 0
  regions := {}
  __New(opts) {
    opts.transparency := opts.hasKey("transparency") ? opts.transparency : 50

    ; Gui Setup
    Gui New, +LastFound +E0x20 +AlwaysOnTop +ToolWindow -Caption +Hwndhwnd
    WinSet, TransColor, % "0xFF00FF " opts.transparency
    Gui, Color, 0xFF00FF
    Gui, Font, s8 bold

    this.gui := hwnd
  }
  update() {
    ; Update virtual state
    if (this.curState != this.newState) {
      this.curState := this.newState

      ; Release all Toggle Region keys if Overlay not visible
      For k, v in this.regions.toggle {
        v.forceReleaseKeys()
      }
      ; Release all Hold Region keys if Overlay not visible
      For k, v in this.regions.hold {
        v.forceReleaseKeys()
      }
    }
    
    If (this.curState) {
      For regionMode, regions in this.regions {
        For k, v in regions {
          v.update()
        }
      }
    }
  }
  addRegion(id, opts) {
    opts.mode := opts.hasKey("mode") ? opts.mode : "none"
    if (!this.regions.hasKey(opts.mode))
      this.regions[opts.mode] := {}
    this.regions[opts.mode][id] := new Region(this.gui, id, opts)
  }
}