defmodule MinesweeperWeb.MinesweeperLive do
  use MinesweeperWeb, :live_view

  alias Minesweeper.Game

  def mount(_params, _session, socket) do
    socket = assign(socket, :game, Game.new_game(9, 7))

    {:ok, socket}
  end

  def handle_event("new_game", _params, socket) do
    # game =
    #   Map.update!(socket.assigns.game, :game_started?, fn _ -> true end)
    #   |> Map.update!(:board, fn _ -> Game.new_board(9, 7) end)
    #   |> Map.update!(:board, fn board -> Game.fill_board(board) end)
    #   |> IO.inspect(label: "lib/minesweeper_web/live/minesweeper_live.ex:17")

    # socket = assign(socket, :game, game)

    socket =
      assign(socket, :game, %{
        board: [
          [
            %{
              bomb: false,
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
              bomb: false,
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
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 0, row: 5}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 0, row: 6}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 0, row: 7}
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
              bomb: false,
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
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 1, row: 5}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 1, row: 6}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 1, row: 7}
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
              bomb: false,
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
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 2, row: 5}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 2, row: 6}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 2, row: 7}
            }
          ],
          [
            %{
              bomb: false,
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
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 3, row: 2}
            },
            %{
              bomb: true,
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
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 3, row: 5}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 3, row: 6}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 3, row: 7}
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
              bomb: true,
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
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 4, row: 3}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 4, row: 4}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 4, row: 5}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 4, row: 6}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 4, row: 7}
            }
          ],
          [
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 5, row: 0}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 5, row: 1}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 5, row: 2}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 5, row: 3}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 5, row: 4}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 5, row: 5}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 5, row: 6}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 5, row: 7}
            }
          ],
          [
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 6, row: 0}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 6, row: 1}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 6, row: 2}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 6, row: 3}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 6, row: 4}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 6, row: 5}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 6, row: 6}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 6, row: 7}
            }
          ],
          [
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 7, row: 0}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 7, row: 1}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 7, row: 2}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 7, row: 3}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 7, row: 4}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 7, row: 5}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 7, row: 6}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 7, row: 7}
            }
          ],
          [
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 8, row: 0}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 8, row: 1}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 8, row: 2}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 8, row: 3}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 8, row: 4}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 8, row: 5}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 8, row: 6}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 8, row: 7}
            }
          ],
          [
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 9, row: 0}
            },
            %{
              bomb: true,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 9, row: 1}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 9, row: 2}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 9, row: 3}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 9, row: 4}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 9, row: 5}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 9, row: 6}
            },
            %{
              bomb: false,
              flagged: false,
              num_surround_bombs: 0,
              revealed: false,
              value: %{col: 9, row: 7}
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
          {board, cells} = Game.reveal_all_surrounding(board, col, row)

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
    cells = Game.get(cells, board)
    {n_cells, board} = Game.reveal_cells2(cells, board)

    if Game.get(n_cells, board) == [] do
      board
    else
      recursion_reval(board, n_cells)
    end
  end
end
