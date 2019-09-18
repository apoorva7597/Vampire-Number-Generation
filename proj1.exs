# defmodule Mix.Tasks.Proj1 do

#   use Mix.Task

#   def run(arg1,arg2) do

#     IO.puts "test"
#     System.no_halt(true)
#     Vampcounter.Application.start(:perm, [arg1, arg2])

#   end
# end
[n,k] = System.argv
n = String.to_integer(n)
k = String.to_integer(k)
Vampcounter.Application.start(:sample,[n,k])
