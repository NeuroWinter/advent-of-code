defmodule Day5 do
  @input_file "input"
  @test_input_file "test_input"

  defp read_input(file \\ @input_file) do
    File.read!(file)
    |> String.split("\n") # had to not use trim here as we needed that empty line
  end

  defp process_id_ranges(range_strings) do
    Enum.map(range_strings, fn range_string ->
      [start_str, end_str] = String.split(range_string, "-")
      String.to_integer(start_str)..String.to_integer(end_str)
    end)
    |> IO.inspect()
  end

  defp fresh?(id, ranges) do
    Enum.any?(ranges, fn range -> id in range end)
  end

  defp process_input(input) do
    # SO there are 2 types of lines one has a - which is the "fresh_ids"
    # and then after the blank line are the ids that are in stock
    {range_lines, stock_lines} = Enum.split_while(input, fn line -> line != "" end)
    processed_ranges = process_id_ranges(range_lines)
    IO.inspect(processed_ranges, label: "Processed Ranges")
    IO.inspect(stock_lines)
    {processed_ranges, stock_lines}
  end

  def main_part1() do
    input = read_input()
    IO.inspect(length(input), label: "Total number of input lines")
    {fresh_ids, stock_ids} = process_input(input)
    IO.inspect(length(fresh_ids), label: "fresh idss")
    IO.inspect(length(stock_ids), label: "stock ids")
    # Now I need to see how mnay stock ids are also i the fresh ids
    # I think that is called the union? Nope intersection
    overlap_count =
      stock_ids
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&String.to_integer/1)
      |> Enum.count(fn id -> fresh?(id, fresh_ids) end)
    IO.inspect(overlap_count, label: "Part 1: Number of overlapping IDs")
  end
end

Day5.main_part1()
