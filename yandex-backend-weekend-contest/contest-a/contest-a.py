import sys
from datetime import date, timedelta


def last_day_of_month(date):
    next_month = date.replace(day=28) + timedelta(days=4)
    return next_month - timedelta(days=next_month.day)


def last_day_of_week(date):
    next_week = date + timedelta(days=6)
    return next_week - timedelta(days=date.weekday())


def last_day_of_quarter(date):
    if date.replace(month=1, day=1) <= date < date.replace(month=3, day=1):
        return last_day_of_month(date.replace(month=3))
    elif date.replace(month=4, day=1) <= date < date.replace(month=6, day=1):
        return last_day_of_month(date.replace(month=6))
    elif date.replace(month=7, day=1) <= date < date.replace(month=9, day=1):
        return last_day_of_month(date.replace(month=9))
    else:
        return last_day_of_month(date.replace(month=12))

def last_day_of_review(date):
    if date.replace(month=4, day=1) <= date < date.replace(month=3, day=1):
        return last_day_of_month(date.replace(month=3))
    elif date.replace(month=4, day=1) <= date < date.replace(month=6, day=1):
        return last_day_of_month(date.replace(month=6))
    elif date.replace(month=7, day=1) <= date < date.replace(month=9, day=1):
        return last_day_of_month(date.replace(month=9))
    else:
        return last_day_of_month(date.replace(month=12))

def get_intervals(type: str, start: date, end: date):
    intervals = []

    if type == 'WEEK':
        start_bite = last_day_of_week(start) - start
        intervals.append((start, start + start_bite))
        temp = start + start_bite + timedelta(days=1)

        while temp <= end:
            intervals.append((temp, last_day_of_week(temp)))
            temp = last_day_of_week(temp) + timedelta(days=1)

        intervals[len(intervals) - 1] = (intervals[len(intervals) - 1][0], end)
    elif type == 'MONTH':
        start_bite = last_day_of_month(start) - start
        intervals.append((start, start + start_bite))
        temp = start + start_bite + timedelta(days=1)

        while temp <= end:
            intervals.append((temp, last_day_of_month(temp)))
            temp = last_day_of_month(temp) + timedelta(days=1)

        intervals[len(intervals) - 1] = (intervals[len(intervals) - 1][0], end)
    elif type == 'QUARTER':
        start_bite = last_day_of_quarter(start) - start
        intervals.append((start, start + start_bite))
        temp = start + start_bite + timedelta(days=1)

        while temp <= end:
            intervals.append((temp, last_day_of_quarter(temp)))
            temp = last_day_of_quarter(temp) + timedelta(days=1)

        intervals[len(intervals) - 1] = (intervals[len(intervals) - 1][0], end)
    elif type == 'YEAR':
        start_bite = start.replace(month=12, day=31) - start
        intervals.append((start, start + start_bite))
        temp = start + start_bite + timedelta(days=1)

        while temp <= end:
            intervals.append((temp, temp.replace(month=12, day=31)))
            temp = temp.replace(month=12, day=31) + timedelta(days=1)

        intervals[len(intervals) - 1] = (intervals[len(intervals) - 1][0], end)
    elif type == 'REVIEW':
        pass

    return intervals

if __name__ == '__main__':
    period_type = sys.stdin.readline().rstrip()
    start, end = [date.fromisoformat(x.rstrip()) for x in sys.stdin.readline().split(' ')]

    for i in get_intervals(period_type, start, end):
        print(i)
