from part_one import get_input_file

def _generate_trigram_sum(data: list) -> int:
    """
    Get a list of 3 elements from the passed in data, return the sum
    """
    return data[0] + data[1] + data[2]

def sliding_window(data: list, n: int):
    for index in range(len(data) - n + 1):
        yield data[index: index + n]

def main():
    data = []
    for window in sliding_window(data=get_input_file("input.txt"), n=3):
        data.append(_generate_trigram_sum(window))
    rst  = ["NA" if index == 0 else "+" if x > data[index-1] else "-" for index, x in enumerate(data)]
    print(rst.count("+"))
