from part_one import read_input, get_common_bit, get_lest_common_bit
from typing import List


def get_oxy_numbers(*, n: int, data: List[str]):
    rst = []
    most_common = get_common_bit(n = n, data = data)
    for x in data:
        if int(x[n]) == most_common:
            rst.append(x)
    # go though all the
    return rst 

def get_co_numbers(*, n: int, data: List[str]):
    rst         = []
    lest_common = get_lest_common_bit(n = n, data = data)
    for x in data:
        if int(x[n]) == lest_common:
            rst.append(x)
    # go though all the
    return rst 


def main():
    data = read_input("in.txt")
    n    = 0
    oxy  = get_oxy_numbers(n= 0, data = data)
    while len(oxy) >= 1:
        n  += 1
        # print(len(oxy))
        if len(oxy) == 1:
            break
        oxy = get_oxy_numbers(n = n, data = oxy)


    data = read_input("in.txt")
    n  = 0
    co = get_co_numbers(n = n, data = data)
    print(f"co: {co}")
    while len(co) >= 1:
        n += 1
        # print(len(co))
        if len(co) == 1:
            break
        co = get_co_numbers(n = n, data=co)

    print(oxy[0])
    print(int("".join(oxy[0]),2))
    print(co[0])
    print(int("".join(co[0]),2))
    print(int("".join(oxy[0]), 2) * int("".join(co[0]),2))
