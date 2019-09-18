defmodule Vampcounter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  defp getargs do
    [n,k] = System.argv
    n = String.to_integer(n)
    k = String.to_integer(k)
    # IO.inspect ([n,k])
    # IO.puts "test"
    [n,k]
  end
  def start(_type, [_start, _finstate]) do
    import Supervisor.Spec, warn: false
    children = [

      worker(Vampcounter.Producer, [getargs()]),
      worker(Vampcounter.ProducerConsumer, []),
      worker(Vampcounter.Consumer, [], id: :a ),
      worker(Vampcounter.Consumer, [], id: :b ),
      worker(Vampcounter.Consumer, [], id: :c ),
      worker(Vampcounter.Consumer, [], id: :d ),
      worker(Vampcounter.Consumer, [], id: :e ),
      worker(Vampcounter.Consumer, [], id: :f ),
      worker(Vampcounter.Consumer, [], id: :i ),
      worker(Vampcounter.Consumer, [], id: :b1 ),
      # worker(Vampcounter.Consumer, [], id: :b2 ),
      # worker(Vampcounter.Consumer, [], id: :b3 ),
      # worker(Vampcounter.Consumer, [], id: :b4 ),
      # worker(Vampcounter.Consumer, [], id: :b5 ),
      # worker(Vampcounter.Consumer, [], id: :b6 ),
      # worker(Vampcounter.Consumer, [], id: :b7 ),
      # worker(Vampcounter.Consumer, [], id: :b8 ),
      # worker(Vampcounter.Consumer, [], id: :b9 ),
      # worker(Vampcounter.Consumer, [], id: :b12 ),
      # worker(Vampcounter.Consumer, [], id: :b13),
      # worker(Vampcounter.Consumer, [], id: :b14),
      # Starts a worker by calling: Vampcounter.Worker.start_link(arg)
      # {Vampcounter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Vampcounter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
