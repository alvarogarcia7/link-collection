.PHONY: build
build:
	docker build -t derecerca/recutils .

.PHONY: run
run:
	docker run --rm -it -v ${PWD}/data:/recs/data derecerca/recutils /bin/bash

