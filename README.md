# Link Collection

Data repository for links.

Previously, this repository contained a suite of Perl tools to CRUD data. As of 2024-08, they have been removed (see commit [365b8374](https://github.com/alvarogarcia7/link-collection/commit/365b837406a12e884f31ba62d5b222960c1ed56f)).

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

Read the goals `make select`, `make convert`, `make put-together`.

For a general reference, see `make generate-all`.

# Links

https://www.gnu.org/software/recutils/manual/recutils.html

# Misc

## Generating tags

use `make select`, see 'tags.txt' file

Remember that the tags are automatically generated when you `generate-all`.

## Massive import

Use something like

```
# Start a new container with bash
echo "30529727" | ./bin/insert-import-auto.pl "craftsmanship" ; sleep 3
(many lines)
```

and let it run for a while. It works as of 2023-03-13.

In todoist-integration there is a file called `hackernews_massive_importer.py`.


