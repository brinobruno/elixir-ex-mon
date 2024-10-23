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
end
