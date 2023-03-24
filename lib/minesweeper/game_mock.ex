defmodule Minesweeper.GameMock do
  def new_game() do
    %{
      board: [
        [
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 0},
            id: "0-0"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 1},
            id: "0-1"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 2},
            id: "0-2"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 3},
            id: "0-3"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 4},
            id: "0-4"
          },
          %{
            bomb: true,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 5},
            id: "0-5"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 6},
            id: "0-6"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 0, row: 7},
            id: "0-7"
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 0},
            id: "1-0"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 1},
            id: "1-1"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 2},
            id: "1-2"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 3},
            id: "1-3"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 4},
            id: "1-4"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 5},
            id: "1-5"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 6},
            id: "1-6"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 1, row: 7},
            id: "1-7"
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 0},
            id: "2-0"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 1},
            id: "2-1"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 2},
            id: "2-2"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 3},
            id: "2-3"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 4},
            id: "2-4"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 5},
            id: "2-5"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 6},
            id: "2-6"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 2, row: 7},
            id: "2-7"
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 0},
            id: "3-0"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 1},
            id: "3-1"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 2},
            id: "3-2"
          },
          %{
            bomb: true,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 3},
            id: "3-3"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 4},
            id: "3-4"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 5},
            id: "3-5"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 6},
            id: "3-6"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 3, row: 7},
            id: "3-7"
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 0},
            id: "4-0"
          },
          %{
            bomb: true,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 1},
            id: "4-1"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 2},
            id: "4-2"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 3},
            id: "4-3"
          },
          %{
            bomb: true,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 4},
            id: "4-4"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 5},
            id: "4-5"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 6},
            id: "4-6"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 4, row: 7},
            id: "4-7"
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 0},
            id: "5-0"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 1},
            id: "5-1"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 2},
            id: "5-2"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 3},
            id: "5-3"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 4},
            id: "5-4"
          },
          %{
            bomb: true,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 5},
            id: "5-5"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 6},
            id: "5-6"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 5, row: 7},
            id: "5-7"
          }
        ],
        [
          %{
            bomb: true,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 0},
            id: "6-0"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 1},
            id: "6-1"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 2},
            id: "6-2"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 3},
            id: "6-3"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 4},
            id: "6-4"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 5},
            id: "6-5"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 6},
            id: "6-6"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 6, row: 7},
            id: "6-7"
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 0},
            id: "7-0"
          },
          %{
            bomb: true,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 1},
            id: "7-1"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 2},
            id: "7-2"
          },
          %{
            bomb: true,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 3},
            id: "7-3"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 4},
            id: "7-4"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 5},
            id: "7-5"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 6},
            id: "7-6"
          },
          %{
            bomb: true,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 7, row: 7},
            id: "7-7"
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 8, row: 0},
            id: "8-0"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 8, row: 1},
            id: "8-1"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 8, row: 2},
            id: "8-2"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 8, row: 3},
            id: "8-3"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 8, row: 4},
            id: "8-4"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 8, row: 5},
            id: "8-5"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 8, row: 6},
            id: "8-6"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 8, row: 7},
            id: "8-7"
          }
        ],
        [
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 9, row: 0},
            id: "9-0"
          },
          %{
            bomb: true,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 9, row: 1},
            id: "9-1"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 9, row: 2},
            id: "9-2"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 9, row: 3},
            id: "9-3"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 9, row: 4},
            id: "9-4"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 9, row: 5},
            id: "9-5"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 9, row: 6},
            id: "9-6"
          },
          %{
            bomb: false,
            flagged: false,
            num_surround_bombs: 0,
            revealed: false,
            value: %{col: 9, row: 7},
            id: "9-7"
          }
        ]
      ],
      game_filled?: false,
      game_finished?: false,
      game_started?: true,
      time: 0,
      total_bombs: 20
    }
  end
end
