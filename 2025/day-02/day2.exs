# Now here is the calange 
# Read the file in
# extract the ranges of product ids.
# for each range, find all the possible repeated groups in the range.
# eg 11 is re repetition of 1, 12341234 is a repetition of 1234
# Once I find a repetition I need to add that ID to the total, not the count but the ID itself.


defmodule Day2 do

  @type product_range :: {non_neg_integer(), non_neg_integer()}
  @type repetition_count :: non_neg_integer()
  @type repetition_map :: %{non_neg_integer() => repetition_count() | nil}

  @input_file "input"

  @spec read_input(String.t()) :: [product_range()]
  defp read_input(file_path) do
    File.read!(file_path)
    |> String.replace("\n", "")
    |> String.split(",", trim: true)
  end

  @spec find_repetitions_in_range(non_neg_integer(), non_neg_integer()) :: repetition_map()
  defp find_repetitions_in_range(start_id, end_id) do
    Enum.reduce(start_id..end_id, %{}, fn id, acc ->
      id_str = Integer.to_string(id)
      len = String.length(id_str)

      if rem(len, 2) != 0 do
        # odd length cant have repetitions
        Map.put(acc, id, nil)
      else
        half = div(len, 2)

        # even length check for repetitions ie first half == second half
          if String.slice(id_str, 0, half) == String.slice(id_str, half, half) do
            # fuck yea we have a repetition
            Map.put(acc, id, div(len, 2))
          else
            # No rep
            Map.put(acc, id, nil)
          end
      end
    end)
  end

  @spec find_repetitions_in_range_v2(non_neg_integer(), non_neg_integer()) :: repetition_map()
  defp find_repetitions_in_range_v2(start_id, end_id) do
    Enum.reduce(start_id..end_id, %{}, fn id, acc ->
      id_str = Integer.to_string(id)
      len = String.length(id_str)
      if len < 2 do
        Map.put(acc, id, nil)
      else
        repetition =
        Enum.find(1..div(len, 2), fn sub_len ->
          base = String.slice(id_str, 0, sub_len)
          repeated = String.duplicate(base, div(len, sub_len))
          repeated == id_str
        end)

        if repetition do
          Map.put(acc, id, repetition)
        else
          acc
        end
      end
    end)
  end

  @spec main() :: :ok
  def main do
    product_ranges =
      read_input(@input_file)
      |> Enum.map(fn line ->
        [start_str, end_str] = String.split(line, "-", trim: true)
        {String.to_integer(start_str), String.to_integer(end_str)}
      end)
    # get all the repetitions
    repetitions =
      Enum.reduce(product_ranges, %{}, fn {start_id, end_id}, acc ->
        Map.merge(acc, find_repetitions_in_range(start_id, end_id))
      end)
    IO.inspect(repetitions)
    # Now add all the ids up
    total = Enum.reduce(repetitions, 0, fn {id, reps}, acc ->
      if reps != nil do
        acc + id
      else
        acc
      end
    end)
    IO.inspect(total, label: "Total sum of reps")
  end

  @spec main_part2() :: :ok
  def main_part2() do
    product_ranges =
      read_input(@input_file)
      |> Enum.map(fn line ->
        [start_str, end_str] = String.split(line, "-", trim: true)
        {String.to_integer(start_str), String.to_integer(end_str)}
      end)
    # get all the repetitions
    repetitions =
      Enum.reduce(product_ranges, %{}, fn {start_id, end_id}, acc ->
        Map.merge(acc, find_repetitions_in_range_v2(start_id, end_id))
      end)
    IO.inspect(repetitions, limit: :infinity)
    # Now add all the ids up
    total = Enum.reduce(repetitions, 0, fn {id, reps}, acc ->
      if reps != nil do
        acc + id
      else
        acc
      end
    end)
    IO.puts("AHH")
    IO.inspect(total, label: "Total sum of reps")

  end

end
Day2.main_part2()
