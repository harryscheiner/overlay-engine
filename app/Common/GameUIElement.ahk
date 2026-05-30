Class GameUIElement {
  curState := -1
  newState := 0
  __New(opts) {
    this.x := opts.x
    this.y := opts.y
    this.w := opts.w
    this.h := opts.h
    this.dependency := opts.hasKey("dependency") ? opts.dependency : false
    this.dependencyLogic := opts.hasKey("dependencyLogic") ? opts.dependencyLogic : true

    if (opts.hasKey("image")) {
      this.image := opts.image
      this.variance := opts.hasKey("variance") ? opts.variance : 20
      this.trans := opts.hasKey("trans") ? opts.trans : false
    } else {
      this.color := opts.color
      this.variance := opts.hasKey("variance") ? opts.variance : 2
    }
  }
  update() {
    ; Dependency checking
    AllowCheck := false
    if (this.dependencyLogic) {
      if (!this.dependency || this.dependency.curState)
        AllowCheck := true
    } else {
      if (!this.dependency || !this.dependency.curState)
        AllowCheck := true
    }

    if (AllowCheck) {
      if (this.hasKey("image")) {
        imgOpts := "*" this.variance
        if (this.trans)
          imgOpts := "*Trans" this.trans " " imgOpts
        ImageSearch, Px, Py, this.x, this.y, this.x + this.w, this.y + this.h, % imgOpts " " this.image
        this.newState := !ErrorLevel
      } else {
        ; Check to see if the UI Element is visible
        PixelSearch, Px, Py, this.x, this.y, this.x + this.w, this.y + this.h, this.color, this.variance, Fast RGB
        this.newState := !ErrorLevel
      }
    } else {
      this.newState := false
    }
    ; Update virtual state
    if (this.curState != this.newState)
      this.curState := this.newState
  }
}