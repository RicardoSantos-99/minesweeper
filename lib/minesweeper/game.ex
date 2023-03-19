defmodule Minesweeper.Game do
  @type cell :: %{
          value: %{row: integer(), col: integer()},
          revealed: boolean(),
          flagged: boolean(),
          bomb: boolean()
        }

  @type board :: list([cell()])
  @type game :: %{
          board: board(),
          total_bombs: integer(),
          game_started?: boolean(),
          game_finished?: boolean(),
          game_filled?: boolean()
        }

  @spec new_board :: board()
  def new_board do
    for col <- 0..9 do
      for row <- 0..12 do
        %{
          value: %{row: row, col: col},
          revealed: false,
          flagged: false,
          bomb: false,
          num_surround_bombs: 0
        }
      end
    end
  end

  @spec new_game :: game()
  def new_game do
    %{
      board: new_board(),
      total_bombs: 20,
      game_started?: false,
      game_finished?: false,
      game_filled?: false
    }
  end

  @spec reveal(cell()) :: cell()
  def reveal(cell), do: cell |> Map.update!(:revealed, fn _ -> true end)

  @spec flag(cell()) :: cell()
  def flag(cell), do: cell |> Map.update!(:flagged, fn _ -> true end)

  @spec fill_board(board()) :: board()
  def fill_board(board) do
    for col <- board do
      for row <- col do
        Map.update(row, :bomb, random_value(), fn _ -> random_value() end)
      end
    end
  end

  @spec update_num_surrounding_bombs(board(), integer(), integer(), integer()) :: board()
  def update_num_surrounding_bombs(board, col, row, num_surround_bombs) do
    Enum.map(
      board,
      &Enum.map(&1, fn cell ->
        if is_clicked_cell?(cell, col, row),
          do: Map.update!(cell, :num_surround_bombs, fn _ -> num_surround_bombs end),
          else: cell
      end)
    )
  end

  @spec random_value :: boolean()
  def random_value do
    if Enum.random(1..10) < 3, do: true, else: false
  end

  @spec is_clicked_cell?(cell(), number(), number()) :: boolean()
  def is_clicked_cell?(cell, col, row) do
    cell.value.col == col and cell.value.row == row
  end

  @spec get_num_surrounding_bombs(board(), number, number) :: non_neg_integer()
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

  @spec valid_cell?(board(), integer(), integer()) :: boolean()
  def valid_cell?(board, col, row) do
    col >= 0 and col < length(board) and row >= 0 and row < length(hd(board))
  end

  @spec has_bomb?([{number(), number()}, ...], board()) :: [boolean(), ...]
  def has_bomb?(cells, board) do
    for {col, row} <- cells, do: is_bomb?(board, col, row)
  end

  @spec is_bomb?(board(), integer(), integer()) :: boolean()
  def is_bomb?(board, col, row) do
    Enum.at(Enum.at(board, col), row).bomb
  end

  def reveal_non_bombs(board, col, row, revealed_cells \\ []) do
    moore_neighborhood(col, row)
    |> dbg()
    |> Enum.filter(fn {col, row} -> valid_cell?(board, col, row) end)
    |> Enum.filter(fn {col, row} -> not is_bomb?(board, col, row) end)
    |> Enum.filter(fn {col, row} -> not is_revealed?(board, col, row) end)
    |> IO.inspect(label: "lib/minesweeper/game.ex:122")
    |> reveal_cells(board)
  end

  @spec is_revealed?(board(), integer(), integer()) :: any
  def is_revealed?(board, col, row) do
    Enum.at(Enum.at(board, col), row).revealed
  end

  def reveal_cells([], board), do: board

  def reveal_cells(cells, board) do
    new_board =
      for x <- board do
        for cell <- x do
          if Enum.find(cells, &(&1 === {cell.value.col, cell.value.row})) do
            Map.update!(cell, :revealed, fn _ -> true end)
            |> Map.update!(:num_surround_bombs, fn _ ->
              get_num_surrounding_bombs(board, cell.value.col, cell.value.col)
            end)
          else
            cell
          end
        end
      end

    Enum.map(cells, fn {col, row} ->
      if get_num_surrounding_bombs(new_board, col, row) === 0 do
        IO.inspect("Revealing non-bombs")
        reveal_non_bombs(new_board, col, row, cells)
      else
        new_board
      end
    end)

    new_board
  end

  @spec reveal_all_bombs(board()) :: board()
  def reveal_all_bombs(board) do
    for col <- board do
      for row <- col do
        if row.bomb, do: reveal(row), else: row
      end
    end
  end
end
