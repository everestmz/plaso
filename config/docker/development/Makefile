PLASO_REVISION := $(shell git -C ${PLASO_SRC} rev-parse HEAD)

develop: build interactive

develop_clean: build_clean interactive

env:
	./scripts/verify_environment.sh

build: env
	docker build --build-arg PLASO_REVISION=$(PLASO_REVISION) . -t plaso-dev

build_clean: env
	docker build --build-arg PLASO_REVISION=$(PLASO_REVISION) . -t plaso-dev --no-cache

check_dependencies: env
	docker run -v ${PLASO_SRC}:/root/plaso plaso-dev python utils/check_dependencies.py

test: env
	docker run -v ${PLASO_SRC}:/root/plaso plaso-dev python run_tests.py

interactive: env
	docker run -v ${PLASO_SRC}:/root/plaso -it plaso-dev /bin/bash
