defmodule MinesweeperWeb.MinesweeperLive do
  use MinesweeperWeb, :live_view
  import MinesweeperWeb.Components.Header
  alias Minesweeper.Game

  defguard game_off(game) when not game.game_started? or game.game_finished?

  # ENHANCE: make this dynamic based on board size and number of bombs
  # 191
  defguard win(game) when length(game.total_revealed) == 191

  def mount(_params, _session, socket) do
    socket = assign(socket, :game, Game.new_game(16, 12))

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
    # ENHANCE: make this dynamic based on board size and number of bombs (or user input)
    # ENHANCE: make this a function in the Game module
    # jesus christ this is ugly
    game =
      Map.update!(socket.assigns.game, :game_started?, fn _ -> true end)
      |> Map.update!(:board, fn _ -> Game.new_board(16, 12) end)
      |> Map.update!(:game_filled?, fn _ -> false end)
      |> Map.update!(:total_revealed, fn _ -> [] end)
      |> Map.update!(:game_win?, fn _ -> false end)
      |> Map.update!(:total_bombs, fn _ -> 30 end)
      |> Map.update!(:game_finished?, fn _ -> false end)
      |> Map.update!(:clock, fn _ -> %{time: ~T[00:00:00], status: :running} end)

    if socket.assigns.game.clock.status != :running, do: send(self(), :update_time)

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

    # ENHANCE: transform this into a function
    game =
      if Enum.at(Enum.at(board, y), x).flagged do
        Map.update!(socket.assigns.game, :total_bombs, fn total_bombs -> total_bombs - 1 end)
      else
        Map.update!(socket.assigns.game, :total_bombs, fn total_bombs -> total_bombs + 1 end)
      end

    game = Map.update!(game, :board, fn _ -> board end)

    socket = assign(socket, :game, game)

    {:noreply, socket}
  end

  def handle_event("scroll", %{"no_flag_neighbors" => no_flag_neighbors}, socket) do
    game = scroll_logical(socket, no_flag_neighbors)

    {:noreply, assign(socket, :game, game_status(game))}
  end

  def handle_event("reveal", %{"col" => col, "row" => row}, socket) do
    col = String.to_integer(col)
    row = String.to_integer(row)

    # ENHANCE: transform this into a function with a guard clause
    game =
      if !socket.assigns.game.game_filled? do
        num_rows = length(socket.assigns.game.board)
        num_cols = length(hd(socket.assigns.game.board))

        bombs = Game.random_bombs(num_rows, num_cols, socket.assigns.game.total_bombs, {col, row})

        board = Game.fill_board(socket.assigns.game.board, bombs)

        Map.update!(socket.assigns.game, :game_filled?, fn _ -> true end)
        |> Map.update!(:board, fn _ -> board end)
      else
        socket.assigns.game
      end

    # HACK: this solution is confusing
    game =
      with false <- Game.is_bomb?(game.board, col, row),
           around_bombs when around_bombs > 0 <-
             Game.get_num_surrounding_bombs(game.board, col, row) do
        cells = Game.reveal_cell(game.board, col, row, around_bombs)

        Map.update!(game, :board, fn _ -> cells end)
        |> Map.update!(:total_revealed, fn total_revealed -> total_revealed ++ [{col, row}] end)
      else
        true ->
          Game.game_over?(game)

        0 ->
          {board, reveled} = recursion_reval(game.board, [{col, row}], false)

          game
          |> Map.update!(:total_revealed, fn total_revealed ->
            total_revealed ++ reveled
          end)
          |> Map.update!(:board, fn _ -> board end)
      end

    socket = assign(socket, :game, game_status(game))

    {:noreply, socket}
  end

  defp scroll_logical(socket, no_flag_neighbors) do
    cells = Enum.map(no_flag_neighbors, fn [x, y] -> {x, y} end)

    {board, reveled} = recursion_reval(socket.assigns.game.board, cells, true)

    revealed_bombs? = Enum.any?(reveled, fn {col, row} -> Game.is_bomb?(board, col, row) end)

    update_game(socket, board, reveled, revealed_bombs?)
  end

  defp update_game(socket, board, reveled, revealed_bombs) when revealed_bombs == false do
    socket.assigns.game
    |> Map.update!(:total_revealed, fn total_revealed -> total_revealed ++ reveled end)
    |> Map.update!(:board, fn _ -> board end)
  end

  defp update_game(socket, _reveled, _board, _) do
    Game.game_over?(socket.assigns.game)
  end

  def game_status(game) when win(game) do
    time = Time.to_iso8601(game.clock.time)
    scores = Enum.sort([time | game.scores])

    Map.update!(game, :game_win?, fn _ -> true end)
    |> Map.update!(:scores, fn _ -> scores end)
    |> Map.update!(:game_finished?, fn _ -> true end)
    |> Map.update!(:clock, fn _ -> %{time: ~T[00:00:00], status: :stopped} end)
  end

  def game_status(game) when not win(game) do
    game
  end

  # OPTIMIZE: this function is not efficient, it should be refactored
  # implement a matriz to store the cells that are already revealed and discard them from the list of cells to reveal
  # and also see if row and col already finished to reveal
  def recursion_reval(board, cells, reveled \\ [], reveal_bombs?) do
    {revealed_cells, board} =
      Game.reveal_algorithm(cells, board, reveal_bombs?)
      |> Game.reveal_cells(board)

    reveled = revealed_cells ++ reveled

    has_no_cell_to_reveal = revealed_cells |> Enum.empty?()

    if has_no_cell_to_reveal,
      do: {board, reveled},
      else: recursion_reval(board, revealed_cells, reveled, reveal_bombs?)
  end
end
