
cat /dev/stdin |grep Tags:|cut -d: -f2|tr -d " " | sed '{s/,/\n/g}'|sort|uniq| sed '{s/^/- /}'
