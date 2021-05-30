import sys

if __name__ == '__main__':
    inputs = []

    for line in sys.stdin:
        inputs.append([int(x) for x in line.split(' ')])

    print(sum(inputs[0]))
