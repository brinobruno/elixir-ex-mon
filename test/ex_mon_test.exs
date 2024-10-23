defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Player}

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :superkick, move_heal: :superheal, move_rnd: :superpunch},
        name: "Bruno"
      }

      assert expected_response == ExMon.create_player("Bruno", :superkick, :superpunch, :superheal)
    end
  end

  describe "start_game/1" do
    test "when the game has started, returns a message" do
      player = Player.build("Bruno", :superkick, :superpunch, :superheal)

      messages = capture_io(fn ->
        assert ExMon.start_game(player) == :ok
      end)

      # =~ regex
      assert messages =~ "The game has started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Bruno", :superkick, :superpunch, :superheal)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      # to enforce setup is successful for failure cases, return :ok
      :ok
    end

    test "when the move is valid, make the move and then, computer makes a move" do
      messages = capture_io(fn ->
        ExMon.make_move(:superkick)
      end)

      assert messages =~ "The player attacked the computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      invalid_move = :wrong

      messages = capture_io(fn ->
        ExMon.make_move(invalid_move)
      end)

      assert messages =~ "\n===== Invalid move: #{invalid_move}. =====\n\n"
    end
  end
end
