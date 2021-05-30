import sys
import requests

if __name__ == '__main__':
    host = sys.stdin.readline().rstrip()
    port = sys.stdin.readline().rstrip()
    a = sys.stdin.readline().rstrip()
    b = sys.stdin.readline().rstrip()

    payload = {'a': a, 'b': b}
    r = requests.get(f'{host}:{port}', params=payload)
    response = r.json()

    for i in sorted(response):
        print(i)
