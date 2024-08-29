.PHONY: build
build:
	docker build -t derecerca/recutils .

.PHONY: run-generic
run-generic:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils /bin/bash

bash: run-generic

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

.PHONY: run-fitness
run-fitness:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils ./bin/insert-generic.pl "fitness"

.PHONY: import-crafts
import-crafts:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils ./bin/insert-import.pl "craftsmanship"

.PHONY: import-crafts-auto
import-crafts-auto:
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils ./bin/insert-import-auto.pl "craftsmanship"

.PHONY: categories
categories:
	@echo "existing categories are:"
	@cat data/links.rec|grep "^Category"|sort|uniq|cut -d: -f2|tr -d " "|paste -sd " " -

.PHONY: select
select: categories
	@if [ -z "${CATEGORY}" ]; then echo "Parameter CATEGORY ${CATEGORY} is mandatory. Note make select ... CATEGORY=...."; exit 1; fi
	echo "Parameter CATEGORY ${CATEGORY} is mandatory. Note make CATEGORY=.... select"
	rm -f data/selection.rec
	cat data/links.rec|grep "^%" >> data/selection.rec
	wc -l data/selection.rec
	docker run --rm -it -v ${PWD}:/recs derecerca/recutils recsel -t Link data/links.rec -e "Date >> '01 Jun 2024' && Date << '30 Jun 2024' && Category = '${CATEGORY}'" >> data/selection.rec
	wc -l data/selection.rec
	dos2unix data/selection.rec
	wc -l data/selection.rec
	rm -f data/tags.txt
	docker run --rm -i -v ${PWD}:/recs derecerca/recutils bash ./bin/process-tags.sh < data/selection.rec >> data/tags.txt
	wc -l data/tags.txt

.PHONY: convert
convert:
#	@echo "This is a manual step"
#	@echo "make run-generic"
#	@echo "copy-paste the following line inside docker:"
	#echo "recfmt -f data/markdown.templ < data/selection.rec | perl -p -e 's/\\n/\n/g' > data/selection.md" > /dev/null
	docker run --rm -i -v ${PWD}:/recs derecerca/recutils bash -c "recfmt -f data/markdown.templ < data/selection.rec | perl -p -e 's/\\n/\n/g' > data/selection.md"
	@echo "Tests passed"

.PHONY: cleanup
cleanup:
	rm -f data/selection.md data/selection.rec data/tags.txt

.PHONY: save
save:
	git add .
	git cc "Save progress"

.PHONY: sync
sync:
	git pull
	git push

update-software:
	cp ../link-collection-cli-rust/target/release/lc bin/
.PHONY: update-software
