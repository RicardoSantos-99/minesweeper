defmodule Minesweeper.Game do
  @type cell :: %{
          value: %{row: integer(), col: integer()},
          revealed: boolean(),
          flagged: boolean(),
          bomb: boolean(),
          num_surround_bombs: integer()
        }

  @type coordinates_list :: [{integer(), integer()}, ...]
  @type board :: list([cell()])

  @type game :: %{
          board: board(),
          total_bombs: integer(),
          game_started?: boolean(),
          game_finished?: boolean(),
          game_filled?: boolean(),
          time: integer()
        }

  @spec new_board(integer(), integer()) :: board()
  def new_board(num_coll, num_row) do
    for col <- 0..num_coll do
      for row <- 0..num_row do
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

  @spec new_game(integer(), integer()) :: game()
  def new_game(col, row) do
    %{
      board: new_board(col, row),
      total_bombs: 20,
      game_started?: false,
      game_finished?: false,
      game_filled?: false,
      time: 0
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
  def random_value, do: Enum.random(1..10) < 8

  @spec is_clicked_cell?(cell(), number(), number()) :: boolean()
  def is_clicked_cell?(cell, col, row) do
    cell.value.col == col and cell.value.row == row
  end

  @spec get_num_surrounding_bombs(board(), number, number) :: non_neg_integer()
  def get_num_surrounding_bombs(board, col, row) do
    if not is_bomb?(board, col, row) do
      valid_neighborhoods(board, col, row)
      |> has_bomb?(board)
      |> Enum.filter(&(&1 === true))
      |> Enum.count()
    else
      0
    end
  end

  @spec moore_neighborhood(number, number) :: coordinates_list()
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

  @spec valid_neighborhoods(board(), integer(), integer()) :: coordinates_list()
  def valid_neighborhoods(board, col, row) do
    moore_neighborhood(col, row)
    |> Enum.filter(fn {col, row} -> is_valid_cell?(board, col, row) end)
  end

  @spec is_valid_cell?(board(), integer(), integer()) :: boolean()
  def is_valid_cell?(board, col, row) do
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

  @spec is_revealed?(board(), integer(), integer()) :: any
  def is_revealed?(board, col, row) do
    Enum.at(Enum.at(board, col), row).revealed
  end

  @spec non_bomb_neighbors_undisclosed(board(), integer(), integer()) :: board()
  def non_bomb_neighbors_undisclosed(board, col, row) do
    cells_to_reveal =
      moore_neighborhood(col, row)
      |> Enum.filter(fn {col, row} -> is_valid_cell?(board, col, row) end)
      |> Enum.filter(fn {col, row} -> not is_bomb?(board, col, row) end)
      |> Enum.filter(fn {col, row} -> not is_revealed?(board, col, row) end)

    if length(cells_to_reveal) > 0 do
      cells_to_reveal
      |> reveal_cells(board)
      |> all_cells_revealed?(cells_to_reveal, [])
    else
      board
    end
  end

  def all_cells_revealed?(board, [{col, row} | tail], list) do
    cells =
      moore_neighborhood(col, row)
      |> Enum.filter(fn {col, row} -> not Enum.member?(list, {col, row}) end)
      |> Enum.filter(fn {col, row} -> is_valid_cell?(board, col, row) end)
      |> Enum.filter(fn {col, row} -> not is_bomb?(board, col, row) end)
      |> Enum.filter(fn {col, row} -> not is_revealed?(board, col, row) end)

    all_cells_revealed?(board, tail, list ++ cells)
  end

  def all_cells_revealed?(board, [], list), do: list |> reveal_cells(board)

  @spec update_surrounding_bombs_cell(cell(), board()) :: cell()
  def update_surrounding_bombs_cell(cell, board) do
    num_surround_bombs = get_num_surrounding_bombs(board, cell.value.col, cell.value.row)

    Map.update!(
      cell,
      :num_surround_bombs,
      fn _ -> num_surround_bombs end
    )
  end

  @spec reveal_cells([{integer(), integer()}, ...], board()) :: board()
  def reveal_cells([], board), do: board

  def reveal_cells(cells, board) do
    for x <- board do
      for cell <- x do
        if Enum.find(cells, &(&1 === {cell.value.col, cell.value.row})) do
          reveal(cell) |> update_surrounding_bombs_cell(board)
        else
          cell
        end
      end
    end
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
