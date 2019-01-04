.PHONY: build
build:
	docker build -t derecerca/recutils .

.PHONY: run
run:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils /bin/bash

.PHONY: select
select:
	cat data/links.rec|grep "^%" > data/selection.rec
	echo "" >> data/selection.rec
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils recsel -t Link data/links.rec -e "Date >> '01 Aug 2018' && Date << '31 Dec 2018'" >> data/selection.rec 
	dos2unix data/selection.rec

.PHONY: convert
convert:
	echo "This is a manual step"
	echo "make run"
	echo "recfmt -f data/markdown.templ < data/selection.rec >> data/selection.md"

