defmodule Vampcounter.Producer do
  use GenStage

  def start_link(init \\ 0) do
    GenStage.start_link(__MODULE__,init, name: __MODULE__)

  end
  def init([counter,fin]) do
    #IO.inspect ([counter, fin])
    {:producer, [counter, fin]}
  end

  def handle_demand(demand \\ 1000, [state,finstate]) do
    :observer.start
    cond do
      # state >= finstate ->
      #   IO.puts state
      #   :timer.sleep(1000)
      #   :init.stop
      (state+demand) <= finstate ->
        events = Enum.to_list(state..state+demand-1)
        {:noreply, events, [(state+demand),finstate]}
      (state+demand) > finstate && (state <= finstate)->
        events = Enum.to_list(state..finstate)
        {:noreply, events, [(state+demand),finstate]}
      (state) > finstate ->
        #events = Enum.to_list(state..finstate)
        {:noreply, [], [(state+demand),finstate]}
    end
  end

end
