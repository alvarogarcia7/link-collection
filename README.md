## Selecting by tag

```
recsel -e "Tag ~ 'bye'" link.rec
```

Selects only the records containing bye as a tag

## ?

recsel -e '!(Tag ~ "bye")' link.rec

Selects the ones that do not include bye in the first Tag

Maybe needs to materialize tags?

## Inserting

```
recins -t Link -f Title -v "Hello World!" -f Tag -v hello -f Tag -v bye link.rec
```
# Links

https://www.gnu.org/software/recutils/manual/recutils.html

