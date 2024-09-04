import datetime
import sys
from _pydatetime import datetime as _dt

if __name__ == '__main__':
    # Execute as sys.argv[0] "Jul 2024"
    month_year = sys.argv[1]
    date_ = _dt.strptime(f"01 {month_year}", '%d %b %Y')
    if date_.month == 12:
        date_ = datetime.date(date_.year + 1, 1, date_.day)
    else:
        date_ = datetime.date(date_.year, date_.month + 1, date_.day)
    print(date_.strftime('%d %b %Y'))
