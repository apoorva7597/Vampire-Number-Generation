defmodule Vampcounter.Consumer do
  use GenStage

  alias Vampcounter.FangsCalculator
  def start_link do
    GenStage.start_link(__MODULE__, :state)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [Vampcounter.ProducerConsumer]}
  end

  defp getfinalevent do
    [_n,k] = System.argv
    String.to_integer(k)
  end
  def handle_events(events, _from, state) do

    for event <- events do
      #IO.inspect {self(), event, state}
      fangs = FangsCalculator.fangs(event)


      cond do
        fangs == [] -> nil
        fangs != [] ->
          #IO.inspect fangs, charlists: :as_lists
          GenServer.cast(Vampcounter.ProducerConsumer, {:print, {fangs, event}})
          # s = ["#{event}"]
          # t = Enum.map(fangs, fn(x) -> [" #{Enum.at(x,0)}"," #{Enum.at(x,1)}"] end)

          # IO.puts (s ++List.flatten(t))

      end
      if event == getfinalevent() do
        :timer.sleep(3000)
        :init.stop
      end
    end
    {:noreply, [], state}
  end
end
