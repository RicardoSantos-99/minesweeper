defmodule Minesweeper.GameMock do
  def new_game() do
    %{
      board: [
        [
          %{
            bomb: false,
            flagged: false,
            id: "0-0",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 0}
          },
          %{
            bomb: true,
            flagged: false,
            id: "1-0",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 0}
          },
          %{
            bomb: false,
            flagged: false,
            id: "2-0",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 0}
          },
          %{
            bomb: false,
            flagged: false,
            id: "3-0",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 0}
          },
          %{
            bomb: false,
            flagged: false,
            id: "4-0",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 0}
          },
          %{
            bomb: false,
            flagged: false,
            id: "5-0",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 0}
          },
          %{
            bomb: false,
            flagged: false,
            id: "6-0",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 0}
          },
          %{
            bomb: false,
            flagged: false,
            id: "7-0",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 0}
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            id: "0-1",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 1}
          },
          %{
            bomb: false,
            flagged: false,
            id: "1-1",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 1}
          },
          %{
            bomb: false,
            flagged: false,
            id: "2-1",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 1}
          },
          %{
            bomb: false,
            flagged: false,
            id: "3-1",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 1}
          },
          %{
            bomb: false,
            flagged: false,
            id: "4-1",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 1}
          },
          %{
            bomb: true,
            flagged: false,
            id: "5-1",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 1}
          },
          %{
            bomb: false,
            flagged: false,
            id: "6-1",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 1}
          },
          %{
            bomb: false,
            flagged: false,
            id: "7-1",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 1}
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            id: "0-2",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 2}
          },
          %{
            bomb: false,
            flagged: false,
            id: "1-2",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 2}
          },
          %{
            bomb: false,
            flagged: false,
            id: "2-2",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 2}
          },
          %{
            bomb: false,
            flagged: false,
            id: "3-2",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 2}
          },
          %{
            bomb: false,
            flagged: false,
            id: "4-2",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 2}
          },
          %{
            bomb: false,
            flagged: false,
            id: "5-2",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 2}
          },
          %{
            bomb: false,
            flagged: false,
            id: "6-2",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 2}
          },
          %{
            bomb: false,
            flagged: false,
            id: "7-2",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 2}
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            id: "0-3",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 3}
          },
          %{
            bomb: false,
            flagged: false,
            id: "1-3",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 3}
          },
          %{
            bomb: false,
            flagged: false,
            id: "2-3",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 3}
          },
          %{
            bomb: false,
            flagged: false,
            id: "3-3",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 3}
          },
          %{
            bomb: false,
            flagged: false,
            id: "4-3",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 3}
          },
          %{
            bomb: true,
            flagged: false,
            id: "5-3",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 3}
          },
          %{
            bomb: true,
            flagged: false,
            id: "6-3",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 3}
          },
          %{
            bomb: false,
            flagged: false,
            id: "7-3",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 3}
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            id: "0-4",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 4}
          },
          %{
            bomb: false,
            flagged: false,
            id: "1-4",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 4}
          },
          %{
            bomb: false,
            flagged: false,
            id: "2-4",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 4}
          },
          %{
            bomb: false,
            flagged: false,
            id: "3-4",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 4}
          },
          %{
            bomb: false,
            flagged: false,
            id: "4-4",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 4}
          },
          %{
            bomb: false,
            flagged: false,
            id: "5-4",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 4}
          },
          %{
            bomb: true,
            flagged: false,
            id: "6-4",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 4}
          },
          %{
            bomb: false,
            flagged: false,
            id: "7-4",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 4}
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            id: "0-5",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 5}
          },
          %{
            bomb: false,
            flagged: false,
            id: "1-5",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 5}
          },
          %{
            bomb: false,
            flagged: false,
            id: "2-5",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 5}
          },
          %{
            bomb: false,
            flagged: false,
            id: "3-5",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 5}
          },
          %{
            bomb: false,
            flagged: false,
            id: "4-5",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 5}
          },
          %{
            bomb: false,
            flagged: false,
            id: "5-5",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 5}
          },
          %{
            bomb: true,
            flagged: false,
            id: "6-5",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 5}
          },
          %{
            bomb: false,
            flagged: false,
            id: "7-5",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 5}
          }
        ],
        [
          %{
            bomb: true,
            flagged: false,
            id: "0-6",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 6}
          },
          %{
            bomb: false,
            flagged: false,
            id: "1-6",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 6}
          },
          %{
            bomb: true,
            flagged: false,
            id: "2-6",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 6}
          },
          %{
            bomb: false,
            flagged: false,
            id: "3-6",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 6}
          },
          %{
            bomb: false,
            flagged: false,
            id: "4-6",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 6}
          },
          %{
            bomb: true,
            flagged: false,
            id: "5-6",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 6}
          },
          %{
            bomb: false,
            flagged: false,
            id: "6-6",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 6}
          },
          %{
            bomb: false,
            flagged: false,
            id: "7-6",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 6}
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            id: "0-7",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 7}
          },
          %{
            bomb: false,
            flagged: false,
            id: "1-7",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 7}
          },
          %{
            bomb: true,
            flagged: false,
            id: "2-7",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 7}
          },
          %{
            bomb: true,
            flagged: false,
            id: "3-7",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 7}
          },
          %{
            bomb: false,
            flagged: false,
            id: "4-7",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 7}
          },
          %{
            bomb: false,
            flagged: false,
            id: "5-7",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 7}
          },
          %{
            bomb: false,
            flagged: false,
            id: "6-7",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 7}
          },
          %{
            bomb: false,
            flagged: false,
            id: "7-7",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 7}
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            id: "0-8",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 8}
          },
          %{
            bomb: false,
            flagged: false,
            id: "1-8",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 8}
          },
          %{
            bomb: false,
            flagged: false,
            id: "2-8",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 8}
          },
          %{
            bomb: false,
            flagged: false,
            id: "3-8",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 8}
          },
          %{
            bomb: false,
            flagged: false,
            id: "4-8",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 8}
          },
          %{
            bomb: false,
            flagged: false,
            id: "5-8",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 8}
          },
          %{
            bomb: false,
            flagged: false,
            id: "6-8",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 8}
          },
          %{
            bomb: true,
            flagged: false,
            id: "7-8",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 8}
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            id: "0-9",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 9}
          },
          %{
            bomb: false,
            flagged: false,
            id: "1-9",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 9}
          },
          %{
            bomb: false,
            flagged: false,
            id: "2-9",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 9}
          },
          %{
            bomb: false,
            flagged: false,
            id: "3-9",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 9}
          },
          %{
            bomb: false,
            flagged: false,
            id: "4-9",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 9}
          },
          %{
            bomb: false,
            flagged: false,
            id: "5-9",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 9}
          },
          %{
            bomb: false,
            flagged: false,
            id: "6-9",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 9}
          },
          %{
            bomb: false,
            flagged: false,
            id: "7-9",
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 9}
          }
        ]
      ],
      clock: %{status: :running, time: ~T[00:00:00]},
      game_filled?: false,
      game_finished?: false,
      game_started?: true,
      total_bombs: 0
    }
  end
end
