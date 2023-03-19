defmodule MinesweeperWeb.MinesweeperLive do
  use MinesweeperWeb, :live_view

  alias Minesweeper.Game

  def mount(_params, _session, socket) do
    socket = assign(socket, :game, Game.new_game())

    {:ok, socket}
  end

  def handle_event("new_game", _params, socket) do
    game =
      Map.update!(socket.assigns.game, :game_started?, fn _ -> true end)
      |> Map.update!(:board, fn _ -> Game.new_board() end)

    socket = assign(socket, :game, game)

    {:noreply, socket}
  end

  def handle_event("reveal", _params, socket) when socket.assigns.game.game_filled? == false do
    board = Game.fill_board(socket.assigns.game.board)

    game =
      socket.assigns.game
      |> Map.update!(:game_filled?, fn _ -> true end)
      |> Map.update!(:game_started?, fn _ -> true end)
      |> Map.update!(:board, fn _ -> board end)

    socket = assign(socket, :game, game)

    {:noreply, socket}
  end

  def handle_event("reveal", %{"col" => col, "row" => row}, socket) do
    board = socket.assigns.game.board

    col = String.to_integer(col)
    row = String.to_integer(row)

    is_bomb? = Game.is_bomb?(board, col, row)

    if not is_bomb? do
      board =
        Enum.map(
          board,
          &Enum.map(&1, fn cell ->
            if Game.is_clicked_cell?(cell, col, row), do: Game.reveal(cell), else: cell
          end)
        )

      revel_board = Game.reveal_non_bombs(board, col, row)

      # num_surround_bombs = Game.get_num_surrounding_bombs(board, col, row)

      # board = Game.update_num_surrounding_bombs(board, col, row, num_surround_bombs)

      game =
        socket.assigns.game
        |> Map.update!(:board, fn _ -> revel_board end)

      socket = assign(socket, :game, game)

      {:noreply, socket}
    else
      game =
        Map.update!(socket.assigns.game, :game_finished?, fn _ -> true end)
        |> Map.update!(:board, fn _ -> Game.reveal_all_bombs(board) end)

      socket = assign(socket, :game, game)

      {:noreply, socket}
    end
  end
end
