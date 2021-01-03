# Link Collection

## Installation

```
make build
```

## Selecting by tag

```
recsel -e "Tag ~ 'bye'" link.rec
```

Selects only the records containing bye as a tag

## Other notes

```
recsel -e '!(Tag ~ "bye")' link.rec
```

Selects the ones that do not include bye in the first Tag

Maybe needs to materialize tags?

## Inserting

use `make run`, then `./bin/insert.pl`, follow the wizard

raw:

```
recins -t Link -f Title -v "Hello World!" -f Tag -v hello -f Tag -v bye link.rec
```

## Exporting (e.g., for markdown)

```
make convert
```

# Links

https://www.gnu.org/software/recutils/manual/recutils.html

# Misc

## Generating tags

use `make select`, see 'tags.txt' file

