defmodule MinesweeperWeb.MinesweeperLive do
  use MinesweeperWeb, :live_view
  import MinesweeperWeb.Components.Header
  alias Minesweeper.Game

  defguard game_off(game) when not game.game_started? or game.game_finished?

  def mount(_params, _session, socket) do
    socket = assign(socket, :game, Game.new_game(9, 7))

    {:ok, socket}
  end

  def handle_info(:update_time, socket) do
    new_time = socket.assigns.game.time + 1

    socket = assign(socket, game: %{socket.assigns.game | time: new_time})

    send_update(MinesweeperWeb.Components.Header, id: "header", assigns: socket.assigns.game)

    {:noreply, socket}
  end

  def handle_event("new_game", _params, socket) do
    game =
      Map.update!(socket.assigns.game, :game_started?, fn _ -> true end)
      |> Map.update!(:board, fn _ -> Game.new_board(9, 7) end)
      |> Map.update!(:board, fn board -> Game.fill_board(board) end)
      |> Map.update!(:game_finished?, fn _ -> false end)

    socket = assign(socket, :game, game)
    # socket = assign(socket, :game, GameMock.new_game())

    :timer.send_after(1000, self(), :update_time)

    {:noreply, socket}
  end

  def handle_event(_, _params, socket) when game_off(socket.assigns.game) do
    {:noreply, socket}
  end

  def handle_event("flag", %{"col" => x, "row" => y}, socket) do
    board = socket.assigns.game.board

    x = String.to_integer(x)
    y = String.to_integer(y)

    board =
      List.update_at(board, x, fn row ->
        List.update_at(row, y, fn cell ->
          if cell.flagged, do: Game.un_flag(cell), else: Game.flag(cell)
        end)
      end)

    game = Map.update!(socket.assigns.game, :board, fn _ -> board end)

    socket = assign(socket, :game, game)

    {:noreply, socket}
  end

  def handle_event("scroll", %{"col" => x, "row" => y}, socket) do
    board = socket.assigns.game.board

    x = String.to_integer(x)
    y = String.to_integer(y)

    surround_bombs = Game.get_cell(board, x, y).num_surround_bombs

    un_revealed_neighbors = Game.un_revealed_neighbors(board, x, y)

    surround_flagged =
      un_revealed_neighbors
      |> Enum.filter(fn {col, row} -> Game.get_cell(board, col, row).flagged end)
      |> Enum.count()

    game =
      if surround_bombs == surround_flagged and Game.is_revealed?(board, x, y) do
        cells = Game.un_flagged_neighbors(board, x, y)

        {board, reaveled} = recursion_reval(board, cells, true)

        revealed_bombs = Enum.any?(reaveled, fn {col, row} -> Game.is_bomb?(board, col, row) end)

        if revealed_bombs do
          Game.game_over?(socket.assigns.game)
        else
          Map.update!(socket.assigns.game, :board, fn _ -> board end)
        end
      else
        socket.assigns.game
      end

    socket = assign(socket, :game, game)
    {:noreply, socket}
  end

  def handle_event("reveal", %{"col" => col, "row" => row}, socket) do
    board = socket.assigns.game.board

    col = String.to_integer(col)
    row = String.to_integer(row)

    game =
      with false <- Game.is_bomb?(board, col, row),
           around_bombs when around_bombs > 0 <- Game.get_num_surrounding_bombs(board, col, row) do
        Game.reveal_cell(board, col, row, around_bombs)
        |> then(&Map.update!(socket.assigns.game, :board, fn _ -> &1 end))
      else
        true ->
          Game.game_over?(socket.assigns.game)

        0 ->
          {board, _} = recursion_reval(board, [{col, row}], false)

          Map.update!(socket.assigns.game, :board, fn _ -> board end)
      end

    socket = assign(socket, :game, game)

    {:noreply, socket}
  end

  def recursion_reval(board, cells, reveled \\ [], reveal_bombs?) do
    {revealed_cells, board} =
      Game.reveal_algorithm(cells, board, reveal_bombs?) |> Game.reveal_cells(board)

    reveled = revealed_cells ++ reveled

    has_no_cell_to_reveal = revealed_cells |> Enum.empty?()

    if has_no_cell_to_reveal,
      do: {board, reveled},
      else: recursion_reval(board, revealed_cells, reveled, reveal_bombs?)
  end
end
