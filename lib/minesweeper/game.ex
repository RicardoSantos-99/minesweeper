defmodule Minesweeper.Game do
  @type cell :: %{
          value: %{row: integer(), col: integer()},
          revealed: boolean(),
          flagged: boolean(),
          bomb: boolean()
        }

  @spec new_board :: [[cell()]]
  def new_board do
    for col <- 0..9 do
      for row <- 0..12 do
        %{value: %{row: row, col: col}, revealed: false, flagged: false, bomb: false}
      end
    end
  end

  @spec reveal(cell()) :: cell()
  def reveal(cell), do: cell |> Map.update!(:revealed, fn _ -> true end)

  @spec flag(cell()) :: cell()
  def flag(cell), do: cell |> Map.update!(:flagged, fn _ -> true end)

  @spec fill_board([[cell()]]) :: [[cell()]]
  def fill_board(board) do
    for col <- board do
      for row <- col do
        Map.update(row, :bomb, random_value(), fn _ -> random_value() end)
      end
    end
  end

  @spec random_value :: boolean()
  def random_value do
    if Enum.random(1..10) < 4, do: true, else: false
  end

  @spec is_clicked_cell?(cell(), number(), number()) :: boolean()
  def is_clicked_cell?(cell, col, row) do
    cell.value.col == col and cell.value.row == row
  end

  def get_num_surrounding_bombs(board, col, row) do
    moore_neighborhood(col, row)
    |> Enum.filter(fn {col, row} -> valid_cell?(board, col, row) end)
    |> has_bomb?(board)
    |> Enum.filter(fn bomb -> bomb == true end)
    |> Enum.count()
  end

  @spec moore_neighborhood(number, number) :: [{number, number}, ...]
  def moore_neighborhood(col, row) do
    [
      {col - 1, row - 1},
      {col, row - 1},
      {col + 1, row - 1},
      {col - 1, row},
      {col + 1, row},
      {col - 1, row + 1},
      {col, row + 1},
      {col + 1, row + 1}
    ]
  end

  @spec valid_cell?([[cell()]], integer(), integer()) :: boolean()
  def valid_cell?(board, col, row) do
    col >= 0 and col < length(board) and row >= 0 and row < length(hd(board))
  end

  @spec has_bomb?([{number(), number()}, ...], [[cell()]]) :: [boolean(), ...]
  def has_bomb?(cells, board) do
    for {col, row} <- cells, do: is_bomb?(board, col, row)
  end

  @spec is_bomb?([[cell()]], integer(), integer()) :: boolean()
  def is_bomb?(board, col, row) do
    Enum.at(Enum.at(board, col), row).bomb
  end
end
