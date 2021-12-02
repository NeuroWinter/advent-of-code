from part_one import load_data
from typing import Dict, List

def calc_hoz(data: List[Dict[str, int]]) -> int:
    rst = 0
    for x in data:
        if list(x.keys())[0] == "forward":
            rst += x['forward']
    return rst 


def calc_depth(data: List[Dict[str, int]]) -> int:
    hoz   = 0
    depth = 0
    aim   = 0
    for x in data:
        if list(x.keys())[0] == "down":
            aim += x['down']
        if list(x.keys())[0] == "up":
            aim -= x['up']
        if list(x.keys())[0] == "forward":
            depth += aim * x['forward']
    print(aim)
    print(depth)
    return depth

def main():
    data   = load_data("in.txt")
    hoz    = calc_hoz(data)
    depth  = calc_depth(data)
    print(hoz*depth)

