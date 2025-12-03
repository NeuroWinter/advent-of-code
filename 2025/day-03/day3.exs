# Day 3!!! lets go
defmodule Day2 do

  @input_file "input"
  @test_inpuit_file "test_input"

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

  defp pick_best_subsequence(digits, needed) do
    # IO.inspect(digits, label: "digits")
    # IO.inspect(needed, label: "needed")
    do_pick(digits, needed, [])
  end

  defp do_pick(_digits, 0, acc) do
    Enum.reverse(acc)
  end

  defp do_pick(digits, needed, acc) do
    IO.inspect(acc, label: "acc")
    # WTF why am I geting things like \b\a\b etc?!
    {next_digit, rest} = choose_next_digit(digits, needed)

    do_pick(rest, needed - 1, [next_digit | acc])
  end

  defp choose_next_digit(digits, needed) do
    max_index = length(digits) - needed

    window = Enum.slice(digits, 0..max_index)

    {chosen_one, index} =
      window
      |> Enum.with_index()
      |> Enum.max_by(fn {digit, _index} -> digit end)

    rest_of_list = Enum.slice(digits, index + 1, length(digits) - (index + 1))

    {chosen_one, rest_of_list}
  end



  defp part2_algo(list_of_ints) do
    # okay now I need to only use 12 digits
    # in order and find the highest number in a line
    # Lets first by trying to generate a list of all possible
    # 12 digit combinations, these do not need to be in order.
    # Okay that was a waste of time, as that gets massive quick.
    #
    # Time to think about a better way to do this.
    #I know that I need the highest number in the first of the 12
    # then if there is a 9 to the right of that, it can be the 2
    # and repeat.
    #
    # I think I can use head and tail here?
    # IF  we will just need to make sure the tail is > what we need to fill
    # ie if we have 6 digits already we need to make sure the tail is >= 6
    #
    # Well that didnt work, time to think about it as some form of sliding window, I think
    # greedy algorithm?
    list_of_ints
      |> pick_best_subsequence(12)
      |> Enum.map(&Integer.to_string/1)
      |> Enum.join("")
      |> String.to_integer()
  end

  def main_part1() do
# This seems to be a two pointer problem!
# Good thing I read about this recently.
# Basically I need to go through each line
# and keep track of two positions.
# If the position reads as a high number from left to right
# then save that as the answer for that row
# Then SUM all of the highest numbers
    input = read_input(@input_file)
    parsed_lines = Enum.map(input, &parse_line/1)
    max_pairs_per_line = Enum.map(parsed_lines, &two_pointer_algorithm/1)

    total =
      max_pairs_per_line
      |> Enum.sum
    IO.inspect(total, label: "SUM of max pairs")
  end

  def main_part2() do
    input = read_input(@input_file)
    parsed_lines = Enum.map(input, &parse_line/1)
    max_pairs_per_line = Enum.map(parsed_lines, &part2_algo/1)
    IO.inspect(max_pairs_per_line, label: "max 12 digits per line")

    total =
      max_pairs_per_line
      |> Enum.sum
    IO.inspect(total, label: "SUM of max 12 digits")

  end

end

Day2.main_part2()
