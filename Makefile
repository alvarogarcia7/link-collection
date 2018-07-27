.PHONY: build
build:
	docker build -t derecerca/recutils .

.PHONY: run
run:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils /bin/bash

.PHONY: publish
publish:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils recsel -t Link data/links.rec -e "Date >> '01 Jun 2018'" -e "Date << '01 Jul 2018'"

