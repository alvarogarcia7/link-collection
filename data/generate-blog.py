import sys
from _pydatetime import datetime


def main(date):
    year = date.strftime('%Y')
    month_as_name_title_case = date.strftime('%B')
    month_as_name = date.strftime('%B').lower()
    month = date.strftime('%m')
    filename = f'{year}-{month}-01-self-study.markdown'

    with open('data/tags.txt', 'r') as f:
        tags = "".join(f.readlines())

    with open('data/selection.md', 'r') as f:
        links = "".join(f.readlines())

    lines = f"""\
---
categories:
- self-study-aggregation
- '{year}'
- {month_as_name}
{tags}
date: {year}-{month}-01T00:00:00+04:00
title: Self-Study in {month_as_name_title_case} {year}
url: /blog/{year}/{month}/01/self-study-{month_as_name}-{year}/
---

{links}
"""

    with open(filename, 'w') as f:
        f.write(lines)

if __name__ == '__main__':
    # Execute as sys.argv[0] "Jul 2024"
    month_year = sys.argv[1].replace(" ", "-")
    print(f"Generating blog post for {month_year}")
    date_ = datetime.strptime(f"01-{month_year}", '%d-%b-%Y')
    main(date_)