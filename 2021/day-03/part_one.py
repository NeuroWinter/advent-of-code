from typing import List
# I need to split the input into colums not rows
def read_input(file_name: str) -> List[List[str]]:
    lines = []
    with open(file_name, 'r') as f:
        lines = f.readlines()
        lines = [list(line.rstrip()) for line in lines]
    return lines

def get_common_bit(*, n: int, data: List[List[str]]) -> str:
    one  = 0
    zero = 0
    for x in data:
        if int(x[n]) == 1:
            one += 1
        elif int(x[n]) == 0:
            zero += 1
    return 0 if one < zero else 1

def get_lest_common_bit(*, n: int, data: List[List[str]]) -> str:
    one  = 0
    zero = 0
    for x in data:
        if int(x[n]) == 1:
            one += 1
        elif int(x[n]) == 0:
            zero += 1
    return 1 if one < zero else 0

def main():
    data = read_input("in.txt")
    eps = ""
    gam = ""
    for bit_n in range(0, len(data[0])):
        eps += str(get_common_bit(n=bit_n, data = data))
        gam += str(get_lest_common_bit(n=bit_n, data = data))

    print(int(eps,2) * int(gam,2))
