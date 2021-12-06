from typing import Dict, List

def load_data(in_file: str) -> List[Dict[str, int]]:
    lines = []
    with open(in_file, 'r') as f:
        lines = f.readlines()
        lines = [int(char) for char in "".join(lines).split(',') ]
    return lines

def tick(data: List[int]) -> List[int]:
    rst = []
    for x in data:
        if x == 0:
            x = 6
            rst.append(8)
            rst.append(x)
        else:
            x -= 1
            rst.append(x)
    return rst


def main():
    data = load_data(in_file="in.txt")
    days = 80
    for day in range(0, days):
        data = tick(data=data)
    print(len(data))
