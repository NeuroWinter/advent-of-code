defmodule Day4 do

  @input_file "input"
  @test_input_file "test_input"

  defp read_input(file_path) do
    file_path
    |> File.read!()
    |> String.split("\n", trim: true)
    # THis is good but I want to remove the positions
    |> Enum.map(fn line ->
      String.graphemes(line)
    end)
  end

  defp get_adjacent_positions(x, y) do
    for dx <- -1..1, dy <- -1..1, not (dx == 0 and dy == 0) do
      {x + dx, y + dy}
    end
  end

  defp filter_positions(positions, max_x, max_y) do
    Enum.filter(positions, fn {x, y} -> x < max_x and y < max_y end)
    |> Enum.filter( fn {x, y} -> x >= 0 and y >= 0 end)
  end

  defp get_total_rolls_of_paper_from_positions(list_of_positions, map) do
    # SO here list_of_positions is a list of differnt postiions that I need to
    # get the value of from the map THen return the total count of the hits
    # that have the char `@`
    Enum.reduce(list_of_positions, 0, fn {x, y}, acc ->
      row      = Enum.at(map, x)
      location = row && Enum.at(row, y)

      if location == "@", do: acc + 1, else: acc
    end)
  end


  def main_part1 do
    # Okay for this one I need to find all the `@` in the input
    # where they have fewer than 4 `@` in the 8 adjacent locations
    # Now I think I can just do this with basic for loops?
    input = read_input(@input_file)
    rows  = length(input)

    accessible_count =
      Enum.reduce(0..(rows - 1), 0, fn i, acc ->
        line      = Enum.at(input, i)
        line_len  = length(line)

        Enum.reduce(0..(line_len - 1), acc, fn j, acc ->
          char = Enum.at(line, j)

          total_for_position =
            get_adjacent_positions(i, j)
            |> filter_positions(rows, line_len)
            |> get_total_rolls_of_paper_from_positions(input)

          if char == "@" and total_for_position < 4 do
            acc + 1
          else
            acc
          end
        end)
      end)

    IO.inspect(accessible_count, label: "Accessible positions")
    accessible_count
  end
end


Day4.main_part1()
