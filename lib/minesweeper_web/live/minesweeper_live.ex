defmodule MinesweeperWeb.MinesweeperLive do
  use MinesweeperWeb, :live_view
  import MinesweeperWeb.Components.Header
  alias Minesweeper.Game

  defguard game_off(game) when not game.game_started? or game.game_finished?

  def mount(_params, _session, socket) do
    socket = assign(socket, :game, Game.new_game(19, 14))

    {:ok, socket}
  end

  def handle_info(:update_time, socket) when not game_off(socket.assigns.game) do
    game = socket.assigns.game
    Process.send_after(self(), :update_time, 10_00)

    assigns =
      Map.update!(game, :clock, fn _ ->
        %{time: Time.add(game.clock.time, 1, :second), status: :running}
      end)

    {:noreply, assign(socket, :game, assigns)}
  end

  def handle_info(:update_time, socket) do
    assigns =
      Map.update!(socket.assigns.game, :clock, fn _ -> %{time: ~T[00:00:00], status: :stopped} end)

    {:noreply, assign(socket, :game, assigns)}
  end

  def handle_event("new_game", _params, socket) do
    game =
      Map.update!(socket.assigns.game, :game_started?, fn _ -> true end)
      |> Map.update!(:board, fn _ -> Game.new_board(19, 14) end)
      # FIXME: remove this line when implemented in the first click
      |> Map.update!(:board, fn board -> Game.fill_board(board) end)
      |> Map.update!(:game_finished?, fn _ -> false end)
      |> Map.update!(:clock, fn _ -> %{time: ~T[00:00:00], status: :running} end)

    # game =
    #   Minesweeper.GameMock.new_game()
    #   |> Map.update!(:clock, fn _ -> %{time: ~T[00:00:00], status: :running} end)

    # socket = assign(socket, :game, game)

    if socket.assigns.game.clock.status != :running, do: send(self(), :update_time)
    # {:noreply, socket}
    {:noreply, socket |> assign(:game, game)}
  end

  def handle_event(_, _params, socket) when game_off(socket.assigns.game) do
    {:noreply, socket}
  end

  def handle_event("flag", %{"col" => x, "row" => y}, socket) do
    board = socket.assigns.game.board

    board =
      List.update_at(board, y, fn row ->
        List.update_at(row, x, fn cell ->
          if cell.flagged, do: Game.un_flag(cell), else: Game.flag(cell)
        end)
      end)

    game = Map.update!(socket.assigns.game, :board, fn _ -> board end)

    socket = assign(socket, :game, game)

    {:noreply, socket}
  end

  def handle_event("scroll", %{"no_flag_neighbors" => no_flag_neighbors}, socket) do
    game = scroll_logical(socket, no_flag_neighbors)

    {:noreply, assign(socket, :game, game)}
  end

  def handle_event("reveal", %{"col" => col, "row" => row}, socket) do
    # TODO: fill board with bombs in the first click
    board = socket.assigns.game.board

    col = String.to_integer(col)
    row = String.to_integer(row)

    # HACK: this solution is confusing
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

  defp scroll_logical(socket, no_flag_neighbors) do
    cells = Enum.map(no_flag_neighbors, fn [x, y] -> {x, y} end)

    {board, reveled} = recursion_reval(socket.assigns.game.board, cells, true)

    revealed_bombs? = Enum.any?(reveled, fn {col, row} -> Game.is_bomb?(board, col, row) end)

    update_game(socket, board, revealed_bombs?)
  end

  defp update_game(socket, board, revealed_bombs) when revealed_bombs == false do
    Map.update!(socket.assigns.game, :board, fn _ -> board end)
  end

  defp update_game(socket, _board, _) do
    Game.game_over?(socket.assigns.game)
  end

  # OPTIMIZE: this function is not efficient
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
