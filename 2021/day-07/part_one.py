from typing import Dict, List

def load_data(in_file: str) -> List[int]:
    lines = []
    with open(in_file, 'r') as f:
        lines = f.readlines()
        lines = [int(char) for char in "".join(lines).split(',') ]
    return lines


def get_fuel_burn(*, n: int, data: List[int]) -> int:
    total = 0
    for crab in data:
        total += abs(n - crab)
    return total


def main():
    data = load_data('in.txt')
    fuel_burn_list = []
    for x in range(0, max(data)):
        fuel_burn_list.append(get_fuel_burn(n=x, data=data))
    print(min(fuel_burn_list))

main()
