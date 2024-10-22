defmodule ExMon.Player do
  @enforce_keys [:name, :life, :move_rnd, :move_avg, :move_heal]

  defstruct [:name, :life, :move_rnd, :move_avg, :move_heal]

  def build(name, move_avg, move_rnd, move_heal) do
    %ExMon.Player{
      name: name,
      move_avg: move_avg,
      move_rnd: move_rnd,
      move_heal: move_heal,
      life: 100
    }
  end
end
