defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Bruno", :superkick, :superpunch, :superheal)
      computer = Player.build("Robotinik", :goodkick, :goodpunch, :goodheal)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Bruno", :superkick, :superpunch, :superheal)
      computer = Player.build("Robotinik", :goodkick, :goodpunch, :goodheal)

      Game.start(computer, player)

      expected_response = %{
        player: %Player{
          life: 100,
          moves: %{move_avg: :superkick, move_heal: :superheal, move_rnd: :superpunch},
          name: "Bruno"
        },
        computer: %Player{
          life: 100,
          moves: %{move_avg: :goodkick, move_heal: :goodheal, move_rnd: :goodpunch},
          name: "Robotinik"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "updates the game state" do
      player = Player.build("Bruno", :superkick, :superpunch, :superheal)
      computer = Player.build("Robotinik", :goodkick, :goodpunch, :goodheal)

      Game.start(computer, player)

      expected_response = %{
        player: %Player{
          life: 100,
          moves: %{move_avg: :superkick, move_heal: :superheal, move_rnd: :superpunch},
          name: "Bruno"
        },
        computer: %Player{
          life: 100,
          moves: %{move_avg: :goodkick, move_heal: :goodheal, move_rnd: :goodpunch},
          name: "Robotinik"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        player: %Player{
          life: 85,
          moves: %{move_avg: :superkick, move_heal: :superheal, move_rnd: :superpunch},
          name: "Bruno"
        },
        computer: %Player{
          life: 50,
          moves: %{move_avg: :goodkick, move_heal: :goodheal, move_rnd: :goodpunch},
          name: "Robotinik"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  # todo:
  # - player
  # - turn
  # - fetch_player
end
