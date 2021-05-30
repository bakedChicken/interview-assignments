import sys
from collections import defaultdict


if __name__ == '__main__':
    userLimit, serviceLimit, duration = [int(x) for x in sys.stdin.readline().rstrip().split(' ')]

    requests_by_userId_in_duration = defaultdict(int)

    for line in sys.stdin:
        if line.rstrip() == '-1':
            break

        time, userId = [int(x) for x in line.rstrip().split(' ')]

        requests_by_userId_in_duration[userId] += 1
        sys.stdout.flush()
