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

        rowLength = e.target.parentElement.parentElement.children.length - 1;
        colLength = e.target.parentElement.children.length;
        console.log("colLength", colLength);
        console.log("rowLength", rowLength);

        col = Number(this.el.dataset.col);
        row = Number(this.el.dataset.row);
        console.log("col", col);
        console.log("row", row);

        const cellValue = Number(e.target.innerText);

        if (isNaN(cellValue) || cellValue === 0) return;

        let neighbors = neighbors_moore(col, row, colLength, rowLength);

        let flaggedNeighbors = neighbors.filter(([col, row]) =>
          neighbors_with_class(col, row, "flagged")
        );

        if (flaggedNeighbors.length === cellValue) {
          this.pushEvent("scroll", { col, row });
        } else {
          const neighborsNotFlagged = neighbors.filter(
            (neighbor) =>
              !flaggedNeighbors.some((flag) =>
                flag.every((valor, i) => valor === neighbor[i])
              )
          );

          neighborsNotFlagged.forEach(([col, row]) => {
            button = document.querySelector(
              `[data-col="${col}"][data-row="${row}"]`
            ).style.backgroundColor = "#A9A9A9";
          });
        }
      }
    });
  },
};

const neighbors_with_class = (col, row, className) => {
  document.getElementById(`${col}-${row}`)?.classList.contains(className);
};

const neighbors_moore = (col, row, rowLength, colLength) => {
  const neighbors = [
    [col - 1, row - 1],
    [col, row - 1],
    [col + 1, row - 1],
    [col - 1, row],
    [col + 1, row],
    [col - 1, row + 1],
    [col, row + 1],
    [col + 1, row + 1],
  ].filter(([col, row]) => {
    console.log(
      "row",
      row,
      " é menor que ",
      rowLength,
      " e ",
      "col",
      col,
      " é menor que ",
      colLength
    );
    return col >= 0 && row >= 0 && col <= colLength && row <= rowLength;
  });
  // .filter(([col, row]) => !neighbors_with_class(col, row, "revealed"));

  // console.log(neighbors);
  return neighbors;
};

let Hooks = { click };

export { Hooks };
