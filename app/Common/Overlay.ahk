Class Overlay {
  curState := -1
  newState := 0
  regions := {}
  __New(opts) {
    opts.transparency := opts.hasKey("transparency") ? opts.transparency : 50
    opts.font := opts.hasKey("font") ? opts.font : "s8 bold"

    ; Gui Setup
    Gui New, +LastFound +E0x20 +AlwaysOnTop +ToolWindow -Caption +Hwndhwnd
    WinSet, TransColor, % "0x000001 " opts.transparency
    Gui, Color, 0x000001
    Gui, Font, % opts.font

    this.gui := hwnd
  }
  update() {
    ; Update virtual state
    if (this.curState != this.newState) {
      this.curState := this.newState

      ; Release all keys and disable all timers if Overlay not visible
      this.releaseKeys()
    }
    
    If (this.curState) {
      For regionMode, regions in this.regions {
        For k, v in regions {
          v.update()
        }
      }
    }
  }
  releaseKeys() {
    ; Release all Toggle Region keys
    For k, v in this.regions.toggle {
      v.forceReleaseKeys()
    }
    ; Release all Timer Region keys
    For k, v in this.regions.timer {
      v.disableTimers()
    }
    ; Release all Hold Region keys
    For k, v in this.regions.hold {
      v.forceReleaseKeys()
    }
  }
  addRegion(id, opts) {
    opts.mode := opts.hasKey("mode") ? opts.mode : "none"
    if (!this.regions.hasKey(opts.mode))
      this.regions[opts.mode] := {}
    this.regions[opts.mode][id] := new Region(this.gui, id, opts)
  }
  removeRegion(region) {
    this.regions[region.mode].Delete(region.id)
  }

  ; Update the position all Regions inside this Overlay and redraw them
  updateRegionPositions() {
    For regionMode, regions in this.regions {
      For k, v in regions {
        v.updateGuiControlPosition()
      }
    }
  }
}