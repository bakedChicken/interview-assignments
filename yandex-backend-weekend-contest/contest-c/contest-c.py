import sys
import json
import operator

if __name__ == '__main__':
    count = int(sys.stdin.readline().rstrip())

    feeds = []

    for i in range(count):
        feeds.append(json.loads(sys.stdin.readline().rstrip()))

    result_feed = []

    for feed in feeds:
        for offer in feed['offers']:
            result_feed.append(offer)

    sorted_offers = sorted(result_feed, key=operator.itemgetter('price', 'offer_id'))

    print(json.dumps({'offers': sorted_offers}))

