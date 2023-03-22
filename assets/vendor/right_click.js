let RightClick = {
  mounted() {
    this.el.addEventListener("contextmenu", e => {
      e.preventDefault();
      this.pushEvent("flag", { col: this.el.dataset.col, row: this.el.dataset.row });
    });
  }
}

let ScrollClick = {
  mounted() {
    this.el.addEventListener("mousedown", e => {
      if (e.button == 1) {
        e.preventDefault();
        this.pushEvent("scroll", { x: e.clientX, y: e.clientY });
      }
    });
  }
};


let Hooks = { RightClick };
export {Hooks};
