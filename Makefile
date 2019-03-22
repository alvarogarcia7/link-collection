.PHONY: build
build:
	docker build -t derecerca/recutils .

.PHONY: run
run:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils /bin/bash

.PHONY: select
select:
	echo "${FILE} is mandatory"
	cat data/${FILE}.rec|grep "^%" > data/selection.rec
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils recsel -t Link data/${FILE}.rec -e "Date >> '30 Jan 2019' && Date << '01 Mar 2019'" > data/selection.rec 
	dos2unix data/selection.rec
	docker run --rm -i -v ${PWD}:/recs derecerca/recutils bash ./bin/process-tags.sh < data/selection.rec > data/tags.txt

.PHONY: convert
convert:
	echo "This is a manual step"
	echo "make run"
	echo "recfmt -f data/markdown.templ < data/selection.rec > data/selection.md"

.PHONY: cleanup
cleanup:
	rm -r data/selection.md data/selection.rec data/tags.txt

