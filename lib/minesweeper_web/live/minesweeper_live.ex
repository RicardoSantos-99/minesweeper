defmodule MinesweeperWeb.MinesweeperLive do
  use MinesweeperWeb, :live_view

  alias Minesweeper.Game

  def mount(_params, _session, socket) do
    socket = assign(socket, :board, Game.new_board())
    socket = assign(socket, :game_started, false)
    socket = assign(socket, :board_filled, false)
    socket = assign(socket, :num_surround_bombs, 0)
    {:ok, socket}
  end

  def handle_event("new_game", _params, socket) do
    socket = assign(socket, :game_started, true)
    {:noreply, socket}
  end

  def handle_event("reveal", _params, socket) when socket.assigns.board_filled == false do
    board = Game.fill_board(socket.assigns.board)

    socket =
      assign(socket, :board, board)
      |> assign(:board_filled, true)

    {:noreply, socket}
  end

  def handle_event("reveal", %{"col" => col, "row" => row}, socket) do
    board = socket.assigns.board

    col = String.to_integer(col)
    row = String.to_integer(row)

    Game.is_bomb?(board, col, row)

    board =
      Enum.map(
        board,
        &Enum.map(&1, fn cell ->
          if Game.is_clicked_cell?(cell, col, row), do: Game.reveal(cell), else: cell
        end)
      )

    num_surround_bombs = Game.get_num_surrounding_bombs(board, col, row)

    socket = assign(socket, :board, board)
    socket = assign(socket, :num_surround_bombs, num_surround_bombs)

    {:noreply, socket}
  end
end
