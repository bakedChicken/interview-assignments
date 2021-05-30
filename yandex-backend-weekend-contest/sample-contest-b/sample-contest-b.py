import sys

if __name__ == '__main__':
    inputs = []

    with open('input.txt') as file:
        for line in file:
            inputs.append([int(x) for x in line.split(' ')])

    with open('output.txt', 'w') as file:
        file.write(str(sum(inputs[0])))
