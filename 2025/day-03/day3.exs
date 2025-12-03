# Day 3!!! lets go
# This seems to be a two pointer problem!
# Good thing I read about this recently.
# Basically I need to go through each line
# and keep track of two positions.
# If the position reads as a high number from left to right
# then save that as the answer for that row
# Then SUM all of the highest numbers
defmodule Day2 do

  @input_file "input"

  defp read_input(file_path) do
    file_path
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  defp parse_line(line) do
    # convert line to list of integers
    list_of_ints =
      line
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
    #IO.inspect(list_of_ints, label: "list_of_ints")
  end

  defp two_pointer_algorithm(list_of_ints) do
    len = length(list_of_ints)

    pairs =
      for i <- 0..(len - 2),
          j <- (i + 1)..(len - 1) do
        str_i = Integer.to_string(Enum.at(list_of_ints, i))
        str_j = Integer.to_string(Enum.at(list_of_ints, j))
        String.to_integer(str_i <> str_j)
      end

    max_pair = Enum.max(pairs)
    IO.inspect(max_pair, label: "max_pair")
    max_pair
  end

  def main_part1() do
    input = read_input(@input_file)
    parsed_lines = Enum.map(input, &parse_line/1)
    max_pairs_per_line = Enum.map(parsed_lines, &two_pointer_algorithm/1)

    total =
      max_pairs_per_line
      |> Enum.sum
    IO.inspect(total, label: "SUM of max pairs")
  end

end

Day2.main_part1()
