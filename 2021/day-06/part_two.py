from part_one import load_data
from typing import Dict, List
from scipy.optimize import minimize_scalar

from scipy.optimize import curve_fit

import matplotlib.pyplot as plt

import numpy as np
import matplotlib.pyplot as plt
import decimal


def convert_list_to_dic(data):
    rst = {
        0: data.count(0),
        1: data.count(1),
        2: data.count(2),
        3: data.count(3),
        4: data.count(4),
        5: data.count(5),
        6: data.count(6),
        7: data.count(7),
        8: data.count(8),
    }
    return rst 

def tick(rst):
    new_rst = {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0,
    }
    for x in rst:
        if x == 0:
            new_rst[6] += rst[x]
            new_rst[8] += rst[x]
        else:
            new_rst[x-1] += rst[x]
    return new_rst

def main():
    data = load_data(in_file="in.txt")
    rst  = convert_list_to_dic(data=data)
    
    days = range(0, 256)
    for day in days:
        rst = tick(rst=rst)
    print(rst)
    print(sum(rst.values()))
