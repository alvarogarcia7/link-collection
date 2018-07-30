.PHONY: build
build:
	docker build -t derecerca/recutils .

.PHONY: run
run:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils /bin/bash

.PHONY: select
select:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils recsel -t Link data/links.rec -e "Date >> '01 Jul 2018' && Date << '01 Aug 2018'" > data/july.rec 

.PHONY: convert
convert:
	echo "make run"
	echo "recfmt -f data/markdown.templ < data/selection.recutils"

