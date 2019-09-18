defmodule Vampcounter.ProducerConsumer do
  use GenStage

  require Integer

  def start_link do
    GenStage.start_link(__MODULE__, :state, name: __MODULE__ )
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [Vampcounter.Producer]}
  end

  def handle_cast({:print, {fangs,event}}, state) do
    #IO.puts "test"
    s = ["#{event}"]
    t = Enum.map(fangs, fn(x) -> [" #{Enum.at(x,0)}"," #{Enum.at(x,1)}"] end)

    IO.puts (s ++List.flatten(t))

    {:noreply, [], []}
  end
  @spec handle_events(any, any, any) :: {:noreply, any, any}
  def handle_events(events, _from, state) do

    numbers =
          events
          #|> Enum.filter(&Integer.is_even/1)
    {:noreply, numbers, state}
  end
end
