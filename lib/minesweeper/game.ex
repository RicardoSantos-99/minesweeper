defmodule Minesweeper.Game do
  @type cell :: %{
          value: %{row: integer(), col: integer()},
          revealed: boolean(),
          flagged: boolean(),
          bomb: boolean(),
          num_surround_bombs: integer(),
          bomb: integer()
        }

  @type coordinates_list :: [{integer(), integer()}, ...]
  @type board :: list([cell()])

  @type game :: %{
          board: board(),
          total_bombs: integer(),
          game_started?: boolean(),
          game_finished?: boolean(),
          game_filled?: boolean(),
          time: integer(),
          scores: list()
        }

  @spec new_board(integer(), integer()) :: board()
  def new_board(num_rows, num_coll) do
    for row <- 0..num_rows do
      for col <- 0..num_coll do
        %{
          value: %{row: row, col: col},
          id: "#{col}-#{row}",
          revealed: false,
          flagged: false,
          bomb: false,
          num_surround_bombs: 0
        }
      end
    end
  end

  @spec new_game(integer(), integer()) :: game()
  def new_game(row, col) do
    %{
      board: new_board(row, col),
      total_bombs: 30,
      game_started?: false,
      game_finished?: false,
      game_win?: false,
      game_filled?: false,
      total_revealed: [],
      clock: %{time: ~T[00:00:00], status: :stopped},
      scores: []
    }
  end

  def reveal_cell(board, x, y, bombs) do
    List.update_at(board, y, fn col ->
      List.update_at(
        col,
        x,
        &(Map.update!(&1, :num_surround_bombs, fn _ -> bombs end)
          |> Map.update!(:revealed, fn _ -> true end))
      )
    end)
  end

  def reveal_all_surrounding(board, x, y) do
    cells = valid_neighborhoods(board, x, y)
    reveal_cells(cells ++ [{x, y}], board)
  end

  def get_cell(board, col, row) do
    Enum.at(Enum.at(board, row), col)
  end

  def un_revealed_neighbors(board, col, row) do
    valid_neighborhoods(board, col, row)
    |> Enum.filter(fn {col, row} -> not is_revealed?(board, col, row) end)
  end

  def un_flagged_neighbors(board, col, row) do
    un_revealed_neighbors(board, col, row)
    |> Enum.filter(fn {col, row} -> not is_flagged?(board, col, row) end)
  end

  @spec reveal(cell()) :: cell()
  def reveal(cell), do: cell |> Map.update!(:revealed, fn _ -> true end)

  @spec flag(cell()) :: cell()
  def flag(cell) when cell.revealed, do: cell
  def flag(cell), do: cell |> Map.update!(:flagged, fn _ -> true end)

  def un_flag(cell), do: cell |> Map.update!(:flagged, fn _ -> false end)

  @spec fill_board(board(), coordinates_list()) :: board()
  def fill_board(board, bombs) do
    for row <- board do
      for cell <- row do
        if is_sorted_bomb?(cell, bombs) do
          Map.update!(cell, :bomb, fn _ -> true end)
        else
          cell
        end
      end
    end
  end

  def is_sorted_bomb?(cell, bombs) do
    Enum.any?(bombs, fn {col, row} -> cell.value.col == col and cell.value.row == row end)
  end

  def random_bombs(num_rows, num_cols, bombs, {row, col}) do
    coordinates_list = for i <- 0..(num_cols - 1), j <- 0..(num_rows - 1), do: {i, j}

    Enum.shuffle(coordinates_list)
    |> Enum.filter(fn {x, y} -> x != row and y != col end)
    |> Enum.take(bombs)
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
  def random_value, do: Enum.random(1..15) < 3

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

  def reveal_algorithm(cells, board, reveal_bombs?) do
    cells =
      Enum.reduce_while(cells, cells, fn {col, row}, acc ->
        if is_bomb?(board, col, row) do
          {:halt, [{col, row} | acc]}
        else
          if get_num_surrounding_bombs(board, col, row) == 0 do
            {:cont, valid_neighborhoods(board, col, row) ++ acc}
          else
            {:cont, [{col, row} | acc]}
          end
        end
      end)
      |> Enum.uniq()

    if reveal_bombs? do
      cells
      |> Enum.filter(fn {col, row} -> not is_revealed?(board, col, row) end)
    else
      cells
      |> Enum.filter(fn {col, row} ->
        not is_revealed?(board, col, row) and not is_bomb?(board, col, row)
      end)
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
    col >= 0 and col < length(hd(board)) and row >= 0 and row < length(board)
  end

  def is_flagged?(board, col, row), do: Enum.at(Enum.at(board, row), col).flagged

  @spec has_bomb?([{number(), number()}, ...], board()) :: [boolean(), ...]
  def has_bomb?(cells, board), do: for({col, row} <- cells, do: is_bomb?(board, col, row))

  @spec is_bomb?(board(), integer(), integer()) :: boolean()
  def is_bomb?(board, col, row) do
    Enum.at(Enum.at(board, row), col).bomb
  end

  @spec is_revealed?(board(), integer(), integer()) :: any
  def is_revealed?(board, col, row), do: Enum.at(Enum.at(board, row), col).revealed

  @spec update_surrounding_bombs_cell(cell(), board()) :: cell()
  def update_surrounding_bombs_cell(cell, board) do
    num_surround_bombs = get_num_surrounding_bombs(board, cell.value.col, cell.value.row)

    Map.update!(
      cell,
      :num_surround_bombs,
      fn _ -> num_surround_bombs end
    )
  end

  @spec reveal_cells([{integer(), integer()}, ...], board()) ::
          {[{integer(), integer()}, ...], board()}
  def reveal_cells([], board), do: {[], board}

  def reveal_cells(cells, board) do
    new_board =
      for x <- board do
        for cell <- x do
          if Enum.find(cells, &(&1 === {cell.value.col, cell.value.row})) do
            num = get_num_surrounding_bombs(board, cell.value.col, cell.value.row)

            Map.update!(cell, :num_surround_bombs, fn _ -> num end)
            |> reveal()
            |> un_flag()
          else
            cell
          end
        end
      end

    {cells, new_board}
  end

  def game_over?(game) do
    Map.update!(game, :game_finished?, fn _ -> true end)
    |> Map.update!(:game_filled?, fn _ -> false end)
    |> Map.update!(:board, fn _ -> reveal_all_bombs(game.board) end)
  end

  @spec reveal_all_bombs(board()) :: board()
  def reveal_all_bombs(board) do
    for row <- board do
      for cell <- row do
        if cell.bomb, do: reveal(cell) |> un_flag(), else: cell |> un_flag()
      end
    end
  end
end
