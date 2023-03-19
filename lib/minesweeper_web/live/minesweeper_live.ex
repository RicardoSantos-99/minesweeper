defmodule MinesweeperWeb.MinesweeperLive do
  use MinesweeperWeb, :live_view

  alias Minesweeper.Game

  def mount(_params, _session, socket) do
    socket = assign(socket, :game, Game.new_game(4, 4))

    {:ok, socket}
  end

  def handle_event("new_game", _params, socket) do
    # game =
    #   Map.update!(socket.assigns.game, :game_started?, fn _ -> true end)
    #   |> Map.update!(:board, fn _ -> Game.new_board(6, 6) end)
    #   |> Map.update!(:board, fn board -> Game.fill_board(board) end)

    # socket = assign(socket, :game, game)
    socket =
      assign(socket, :game, %{
        board: [
          [
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 0, row: 0}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 0, row: 1}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 0, row: 2}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 0, row: 3}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 0, row: 4}
            }
          ],
          [
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 1, row: 0}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 1, row: 1}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 1, row: 2}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 1, row: 3}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 1, row: 4}
            }
          ],
          [
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 2, row: 0}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 2, row: 1}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 2, row: 2}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 2, row: 3}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 2, row: 4}
            }
          ],
          [
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 3, row: 0}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 3, row: 1}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 3, row: 2}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 3, row: 3}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 3, row: 4}
            }
          ],
          [
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 4, row: 0}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 4, row: 1}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 4, row: 2}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 4, row: 3}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 4, row: 4}
            }
          ]
        ],
        game_filled?: false,
        game_finished?: false,
        game_started?: true,
        time: 0,
        total_bombs: 20
      })

    {:noreply, socket}
  end

  def handle_event("reveal", _params, socket) when socket.assigns.game.game_started? == false do
    {:noreply, socket}
  end

  def handle_event("reveal", %{"col" => col, "row" => row}, socket) do
    board = socket.assigns.game.board

    col = String.to_integer(col)
    row = String.to_integer(row)

    is_bomb? = Game.is_bomb?(board, col, row)

    if not is_bomb? do
      updated_board = Game.non_bomb_neighbors_undisclosed(board, col, row)

      game = Map.update!(socket.assigns.game, :board, fn _ -> updated_board end)

      socket = assign(socket, :game, game)

      {:noreply, socket}
    else
      game = game_over?(socket.assigns.game)

      socket = assign(socket, :game, game)

      {:noreply, socket}
    end
  end

  def game_over?(game) do
    Map.update!(game, :game_finished?, fn _ -> true end)
    |> Map.update!(:board, fn _ -> Game.reveal_all_bombs(game.board) end)
  end
end
