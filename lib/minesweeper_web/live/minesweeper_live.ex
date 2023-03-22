defmodule MinesweeperWeb.MinesweeperLive do
  use MinesweeperWeb, :live_view

  alias Minesweeper.Game

  def mount(_params, _session, socket) do
    socket = assign(socket, :game, Game.new_game(9, 7))

    {:ok, socket}
  end

  def handle_event("new_game", _params, socket) do
    game =
      Map.update!(socket.assigns.game, :game_started?, fn _ -> true end)
      |> Map.update!(:board, fn _ -> Game.new_board(9, 7) end)
      |> Map.update!(:board, fn board -> Game.fill_board(board) end)

    socket = assign(socket, :game, game)
    # socket = assign(socket, :game, GameMock.new_game())

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

  def handle_event("scroll", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("reveal", _params, socket) when socket.assigns.game.game_started? == false do
    {:noreply, socket}
  end

  def handle_event("reveal", %{"col" => col, "row" => row}, socket) do
    board = socket.assigns.game.board

    col = String.to_integer(col)
    row = String.to_integer(row)

    game =
      with false <- Game.is_bomb?(board, col, row),
           around_bombs when around_bombs > 0 <-
             Game.get_num_surrounding_bombs(board, col, row) do
        Game.reveal_cell(board, col, row, around_bombs)
        |> then(&Map.update!(socket.assigns.game, :board, fn _ -> &1 end))
      else
        true ->
          game_over?(socket.assigns.game)

        0 ->
          {cells, board} = Game.reveal_all_surrounding(board, col, row)

          update_b = recursion_reval(board, cells)

          Map.update!(socket.assigns.game, :board, fn _ -> update_b end)
      end

    socket = assign(socket, :game, game)

    {:noreply, socket}
  end

  def game_over?(game) do
    Map.update!(game, :game_finished?, fn _ -> true end)
    |> Map.update!(:board, fn _ -> Game.reveal_all_bombs(game.board) end)
  end

  def recursion_reval(board, cells) do
    {revealed_cells, board} = Game.reveal_algorithm(cells, board) |> Game.reveal_cells(board)

    if Game.reveal_algorithm(revealed_cells, board) |> Enum.empty?() do
      board
    else
      recursion_reval(board, revealed_cells)
    end
  end
end
