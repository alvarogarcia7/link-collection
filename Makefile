.PHONY: build
build:
	docker build -t derecerca/recutils .

.PHONY: run-generic
run-generic:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils /bin/bash

.PHONY: run-crafts
run-crafts:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils ./bin/insert-craftsmanship.sh

.PHONY: run-finance
run-finance:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils ./bin/insert-finance.sh

.PHONY: select
select:
	echo "Parameter FILE ${FILE} is mandatory. Note make FILE=.... select"
	cat data/${FILE}.rec|grep "^%" > data/selection.rec
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils recsel -t Link data/${FILE}.rec -e "Date >> '01 March 2019' && Date << '01 Apr 2019'" > data/selection.rec 
	dos2unix data/selection.rec
	docker run --rm -i -v ${PWD}:/recs derecerca/recutils bash ./bin/process-tags.sh < data/selection.rec > data/tags.txt

.PHONY: convert
convert:
	@echo "This is a manual step"
	@echo "make run"
	echo "recfmt -f data/markdown.templ < data/selection.rec | perl -p -e 's/\\n/\n/g' > data/selection.md"
	$(MAKE) run

.PHONY: cleanup
cleanup:
	rm -f data/selection.md data/selection.rec data/tags.txt

.PHONY: save
save:
	git add .
	git commit -m "Save progress"

.PHONY: sync
sync:
	git pull
	git push

