.PHONY: build
build:
	docker build -t derecerca/recutils .

.PHONY: run-generic
run-generic:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils /bin/bash

.PHONY: run-crafts
run-crafts:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils ./bin/insert-generic.pl "craftsmanship"

.PHONY: run-finance
run-finance:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils ./bin/insert-generic.pl "finance"

.PHONY: run-psychology
run-psychology:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils ./bin/insert-generic.pl "psychology"

.PHONY: run-philosophy
run-philosophy:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils ./bin/insert-generic.pl "philosophy"

.PHONY: categories
categories:
	@echo "existing categories are:"
	@cat data/links.rec|grep "^Category"|sort|uniq|cut -d: -f2|tr -d " "|paste -sd " " -

.PHONY: select
select: categories
	echo "Parameter CATEGORY ${CATEGORY} is mandatory. Note make CATEGORY=.... select"
	cat data/links.rec|grep "^%" > data/selection.rec
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils recsel -t Link data/links.rec -e "Date >> '01 Jan 2021' && Date << '01 Feb 2021' && Category = '${CATEGORY}'" > data/selection.rec
	dos2unix data/selection.rec
	docker run --rm -i -v ${PWD}:/recs derecerca/recutils bash ./bin/process-tags.sh < data/selection.rec > data/tags.txt

.PHONY: convert
convert:
	@echo "This is a manual step"
	@echo "make run-generic"
	@echo "copy-paste the following line inside docker:"
	echo "recfmt -f data/markdown.templ < data/selection.rec | perl -p -e 's/\\n/\n/g' > data/selection.md" > /dev/null
	$(MAKE) run-generic

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

