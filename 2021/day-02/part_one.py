# for each down, add x
# for each up, minus x
# Sum the fowards


# First lets do the fwds

from typing import Dict, List

def calc_fwds(data: List[Dict[str, int]]) -> int:
    rst = 0
    for x in data:
        if list(x.keys())[0] == "forward":
            rst += x['forward']
    return rst 

def calc_up_down(data) -> int:
    rst = 0
    for x in data:
        if list(x.keys())[0] == "up":
            rst -= x['up']
        elif list(x.keys())[0] == "down":
            rst += x["down"]
    return rst 


def load_data(in_file: str) -> List[Dict[str, int]]:
    lines = []
    with open(in_file, 'r') as f:
        lines = f.readlines()
        lines = [{str(x.split(' ')[0]): int(x.split(' ')[1])} for x in lines ]
    return lines

def main():
    data = load_data("in.txt")
    fwds = calc_fwds(data)
    depth = calc_up_down(data)
    print(fwds * depth)
    return fwds * depth

