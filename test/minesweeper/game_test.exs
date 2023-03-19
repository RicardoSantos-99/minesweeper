defmodule Minesweeper.GameTest do
  use Minesweeper.DataCase

  alias Minesweeper.Game

  @game %{
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
  }

  test "new_board/2" do
    board = Game.new_board(4, 4)
    row = board |> List.first()
    cell = row |> List.first()

    assert length(board) == 5
    assert length(row) == 5
    assert Map.has_key?(cell, :bomb) == true
    assert Map.has_key?(cell, :flagged) == true
    assert Map.has_key?(cell, :num_surround_bombs) == true
    assert Map.has_key?(cell, :revealed) == true
    assert Map.has_key?(cell, :value) == true

    assert Map.has_key?(cell.value, :col) == true
    assert Map.has_key?(cell.value, :row) == true
  end

  test "random_value/0" do
    assert is_boolean(Game.random_value())
  end

  test "moore_neighborhood/2" do
    assert Game.moore_neighborhood(0, 0) == [
             {-1, -1},
             {0, -1},
             {1, -1},
             {-1, 0},
             {1, 0},
             {-1, 1},
             {0, 1},
             {1, 1}
           ]
  end

  test "is_valid_cell?/3" do
    board = @game.board

    assert Game.is_valid_cell?(board, 0, 0) == true
    assert Game.is_valid_cell?(board, 0, 1) == true
    assert Game.is_valid_cell?(board, 2, 2) == true
    assert Game.is_valid_cell?(board, 4, 2) == true

    assert Game.is_valid_cell?(board, 5, 2) == false
    assert Game.is_valid_cell?(board, 2, 5) == false
    assert Game.is_valid_cell?(board, -1, 2) == false
    assert Game.is_valid_cell?(board, 2, -1) == false
  end

  test "valid_neighbors/3" do
    board = @game.board
    neighbors_0_0 = Game.valid_neighborhoods(board, 0, 0)
    neighbors_1_1 = Game.valid_neighborhoods(board, 1, 1)
    neighbors_4_4 = Game.valid_neighborhoods(board, 4, 4)
    neighbors_0_4 = Game.valid_neighborhoods(board, 0, 4)
    neighbors_4_0 = Game.valid_neighborhoods(board, 4, 0)
    neighbors_4_1 = Game.valid_neighborhoods(board, 4, 1)

    assert neighbors_0_0 == [{1, 0}, {0, 1}, {1, 1}]
    assert neighbors_1_1 == [{0, 0}, {1, 0}, {2, 0}, {0, 1}, {2, 1}, {0, 2}, {1, 2}, {2, 2}]
    assert neighbors_4_4 == [{3, 3}, {4, 3}, {3, 4}]
    assert neighbors_0_4 == [{0, 3}, {1, 3}, {1, 4}]
    assert neighbors_4_0 == [{3, 0}, {3, 1}, {4, 1}]
    assert neighbors_4_1 == [{3, 0}, {4, 0}, {3, 1}, {3, 2}, {4, 2}]
  end

  test "is_clicked_cell?/3" do
    cell = @game.board |> List.first() |> List.first()

    assert Game.is_clicked_cell?(cell, 0, 0) == true
    assert Game.is_clicked_cell?(cell, 1, 0) == false
  end

  test "get_num_surrounding_bombs/3" do
    board = @game.board
    bombs_surround_0_1 = Game.get_num_surrounding_bombs(board, 0, 1)
    bombs_surround_0_2 = Game.get_num_surrounding_bombs(board, 0, 2)
    bombs_surround_1_1 = Game.get_num_surrounding_bombs(board, 1, 1)
    bombs_surround_2_2 = Game.get_num_surrounding_bombs(board, 2, 2)

    assert bombs_surround_0_1 == 2
    assert bombs_surround_0_2 == 2
    assert bombs_surround_1_1 == 3
    assert bombs_surround_2_2 == 3
  end

  test "is_bomb?/3" do
    board = @game.board
    assert Game.is_bomb?(board, 0, 0) == true
    assert Game.is_bomb?(board, 0, 3) == true
    assert Game.is_bomb?(board, 4, 3) == true
    assert Game.is_bomb?(board, 3, 2) == true

    assert Game.is_bomb?(board, 0, 1) == false
    assert Game.is_bomb?(board, 0, 2) == false
    assert Game.is_bomb?(board, 1, 1) == false
    assert Game.is_bomb?(board, 2, 2) == false
  end

  test "has_bomb/3" do
    no_bomb_cells = [{0, 2}, {1, 1}]
    bomb_cells = [{0, 0}, {0, 3}]
    cells = no_bomb_cells ++ bomb_cells
    board = @game.board

    assert Game.has_bomb?(no_bomb_cells, board) == [false, false]
    assert Game.has_bomb?(bomb_cells, board) == [true, true]
    assert Game.has_bomb?(cells, board) == [false, false, true, true]
  end

  test "update_num_surrounding_bombs/4" do
    board = @game.board

    updated_board = Game.update_num_surrounding_bombs(board, 0, 0, 2)
    assert updated_board |> List.first() |> List.first() |> Map.get(:num_surround_bombs) == 2
  end

  test "undisclosed_neighbors/3" do
    board = @game.board

    assert Game.non_bomb_neighbors_undisclosed(board, 0, 1) == [{1, 0}, {1, 1}, {0, 2}]
    assert Game.non_bomb_neighbors_undisclosed(board, 0, 2) == [{0, 1}, {1, 1}, {1, 3}]
    assert Game.non_bomb_neighbors_undisclosed(board, 4, 1) == [{4, 0}, {3, 1}, {4, 2}]
  end

  test "reveal_cells/2" do
    board = @game.board
    cells = [{0, 1}, {0, 2}, {1, 1}, {2, 2}]
    updated_board = Game.reveal_cells(cells, board)

    assert Game.reveal_cells([], board) == board

    assert updated_board |> List.first() |> List.first() |> Map.get(:revealed) == false
    assert updated_board |> List.first() |> List.last() |> Map.get(:revealed) == false
    assert updated_board |> List.last() |> List.first() |> Map.get(:revealed) == false
    assert updated_board |> List.last() |> List.last() |> Map.get(:revealed) == false

    assert updated_board |> List.first() |> Enum.at(1) |> Map.get(:revealed) == true
    assert updated_board |> List.first() |> Enum.at(2) |> Map.get(:revealed) == true
    assert updated_board |> Enum.at(1) |> Enum.at(1) |> Map.get(:revealed) == true
    assert updated_board |> Enum.at(2) |> Enum.at(2) |> Map.get(:revealed) == true
  end

  test "update_surrounding_bombs_cell/2" do
    board = @game.board

    cell_4_4 =
      board
      |> List.last()
      |> List.last()
      |> Game.update_surrounding_bombs_cell(board)

    cell_2_3 =
      board
      |> Enum.at(2)
      |> Enum.at(3)
      |> Game.update_surrounding_bombs_cell(board)

    cell_2_2 =
      board
      |> Enum.at(2)
      |> Enum.at(2)
      |> Game.update_surrounding_bombs_cell(board)

    assert cell_4_4 |> Map.get(:num_surround_bombs) == 1
    assert cell_2_3 |> Map.get(:num_surround_bombs) == 2
    assert cell_2_2 |> Map.get(:num_surround_bombs) == 3
  end

  test "reveal_all_bombs/1" do
    board = @game.board
    updated_board = Game.reveal_all_bombs(board)

    assert updated_board |> Enum.at(0) |> Enum.at(0) |> Map.get(:revealed) == true
    assert updated_board |> Enum.at(0) |> Enum.at(3) |> Map.get(:revealed) == true
    assert updated_board |> Enum.at(4) |> Enum.at(3) |> Map.get(:revealed) == true
    assert updated_board |> Enum.at(3) |> Enum.at(2) |> Map.get(:revealed) == true

    assert updated_board |> Enum.at(2) |> Enum.at(2) |> Map.get(:revealed) == false
    assert updated_board |> Enum.at(2) |> Enum.at(3) |> Map.get(:revealed) == false
    assert updated_board |> Enum.at(3) |> Enum.at(3) |> Map.get(:revealed) == false
    assert updated_board |> Enum.at(4) |> Enum.at(4) |> Map.get(:revealed) == false
  end
end
