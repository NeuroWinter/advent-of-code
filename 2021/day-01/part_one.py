
def main():
    data = get_input_file('input.txt')
    rst  = ["NA" if index == 0 else "+" if x > data[index-1] else "-" for index, x in enumerate(data)]
    ads  = rst.count("+") 
    print(ads)

def get_input_file(file_path):
    """
    Get the input file from AoC.
    """
    with open(file_path, 'r') as f:
        lines = f.readlines()
        lines = [int(line.rstrip()) for line in lines]
    return lines
