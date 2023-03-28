let click = {
  mounted() {
    this.el.addEventListener("contextmenu", (e) => {
      e.preventDefault();
      this.pushEvent("flag", {
        col: Number(this.el.dataset.col),
        row: Number(this.el.dataset.row),
      });
    });

    this.el.addEventListener("mousedown", (e) => {
      if (e.button == 1) {
        e.preventDefault();

        const rowLength =
          Array.from(e.target.parentElement.parentElement.children).filter(
            (child) => child.tagName !== "HEADER"
          ).length - 1;
        const colLength = e.target.parentElement.children.length - 1;

        const col = Number(this.el.dataset.col);
        const row = Number(this.el.dataset.row);

        const cellValue = Number(e.target.innerText);

        if (isNaN(cellValue) || cellValue === 0) return;

        const neighbors = neighbors_moore(col, row, rowLength, colLength);

        const flaggedNeighbors = neighbors.filter(([col, row]) =>
          neighbors_with_class(col, row, "flagged")
        );

        if (flaggedNeighbors.length < cellValue) {
          neighbors
            .filter(([col, row]) => !neighbors_with_class(col, row, "flagged"))
            .forEach(([col, row]) => {
              document.getElementById(`${col}-${row}`).style.backgroundColor =
                "#A9A9A9";
            });
        } else {
          this.pushEvent("scroll", { col, row });
        }
      }
    });
  },
};

const neighbors_with_class = (col, row, className) =>
  document.getElementById(`${col}-${row}`).classList.contains(className);

const neighbors_moore = (col, row, rowLength, colLength) =>
  [
    [col - 1, row - 1],
    [col, row - 1],
    [col + 1, row - 1],
    [col - 1, row],
    [col + 1, row],
    [col - 1, row + 1],
    [col, row + 1],
    [col + 1, row + 1],
  ]
    .filter(
      ([col, row]) =>
        col >= 0 && col <= colLength && row >= 0 && row <= rowLength
    )
    .filter(([col, row]) => !neighbors_with_class(col, row, "revealed"));

let Hooks = { click };

export { Hooks };
