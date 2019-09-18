defmodule Vampcounter.FangsCalculator do

    require Integer
    def fangs(number) do
        s = Integer.to_string(number)
        case Integer.is_odd(String.length(s)) do
            :true -> []
            :false -> get_fangs(permutations(Integer.digits(number)),number)

        end

    end

    def get_fangs(list, number) do

        fangs = Enum.filter(split(list), fn([a,b]) -> a*b == number end)
        fangsUniq = Enum.uniq(fangs)
        Enum.slice(fangsUniq, 0,round(length(fangsUniq)/2))
    end

    defp split(list) do
        list2 = Enum.map(list, fn(x) -> Enum.chunk_every(x,round(length(x)/2)) end)
        concatList = Enum.map(list2, fn(x) -> Enum.map(x, fn(y) -> Enum.join(y,"") end) end)
        intList = Enum.map(concatList, fn(x) -> Enum.map(x, fn(y) ->  Integer.parse(y) end)end)
        Enum.map(intList, fn(x) -> Enum.map(x, fn({k,_v}) -> k end)end)

    end

    def permutations([]), do: [[]]
    def permutations(list), do: for elem <- list, rest <- permutations(list--[elem]), do: [elem|rest]
end
