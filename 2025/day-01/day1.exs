# Okay so there are a few things I need to do here:
# 1 Read the input file.
# 2 Split each input line into a direction (l or r) and the number.
# 3 Then go through that list and rotate the dial.
# 4 if it lands on 0 incriment a counter
# 5 return and print the counter
# NOTE the inital dial number is 50
# Also remember that the dial starts at 0 and goes to 99 and wraps around.
# eg L1 from 0 goes to 99 not -1


defmodule Day1 do

  @type direction :: :l | :r
  @type instruction :: {direction(), non_neg_integer()}
  @type dial_state :: %{
          position: non_neg_integer(),
          zero_count: non_neg_integer()
        }

  @input_file "input"
  @initial_dial_position 50


  defp read_input(file_path) do
    file_path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instruction/1)
  end

  defp parse_instruction(line) do
    <<dir::binary-size(1), num::binary>> = line
    direction = case dir do
      "L" -> :l
      "R" -> :r
    end
    {direction, String.to_integer(num)}
  end

  @spec update_dial(dial_state(), instruction()) :: dial_state()
  defp update_dial(state, {direction, steps}) do
    # just in case steps can be greater than 100 we shold normalise it to 100
    # I think ???
    steps = rem(steps, 100)
    # we need to find the new position, if its left we are minus steps and if its right we add steps
    new_position =
    case direction do
      :l -> rem(state.position + 100 - steps, 100)
      :r -> rem(state.position + steps, 100)
    end
    new_zero_count = if new_position == 0, do: state.zero_count + 1, else: state.zero_count
    %{position: new_position, zero_count: new_zero_count}
  end

  @spec update_dial(dial_state(), instruction()) :: dial_state()
  defp update_dial_v2(state, {direction, steps}) do
    # just in case steps can be greater than 100 we shold normalise it to 100
    # we got lucky here and there are no steps that are greater than 100.
    # we need to find the new position, if its left we are minus steps and if its right we add steps
    full_rotations = div(steps, 100)
    remander = rem(steps, 100)
    new_position =
    case direction do
      :l -> rem(state.position + 100 - remander, 100)
      :r -> rem(state.position + remander, 100)
    end
    # now the new zero count will be if the number passed 0 at all!
    new_zero_count =
      cond do
        # Is this even possible now that I have full_rotations?
        new_position == 0 and remander > 0 ->
          state.zero_count + 1
        state.position == new_position -> state.zero_count
        direction == :r and new_position < state.position ->
          state.zero_count + 1
        direction == :l and new_position > state.position and state.position != 0 ->
          state.zero_count + 1
        true -> state.zero_count
      end
    %{position: new_position, zero_count: new_zero_count+full_rotations}
  end

  def main_part1() do
    instructions = read_input(@input_file)
    initial_state = %{position: @initial_dial_position, zero_count: 0}
    final_state =
      Enum.reduce(instructions, initial_state, fn instr, state ->
        update_dial(state, instr)
    end)
    IO.puts("The dial landed on 0 a total of #{final_state.zero_count} times.")
  end

  def main_part2() do
    instructions = read_input(@input_file)
    initial_state = %{position: @initial_dial_position, zero_count: 0}
    final_state =
      Enum.reduce(instructions, initial_state, fn instr, state ->
        update_dial_v2(state, instr)
    end)
    IO.puts("The dial landed on 0 a total of #{final_state.zero_count} times.")
  end
end

Day1.main_part2()
