
VERSION=$(shell git rev-parse --short HEAD)

# venv
venv:
	python3 -m venv .venv

install-requirements:
	pip install -r requirements.txt
	pip install -r dev-requirements.txt

# linter
lint:
	ruff check --preview ./main.py

# lint and fix
lint-fix:
	ruff check --preview --fix ./main.py

# build docker image
build-image:
	docker build -t stam-app .

# push docker image
push-image:
	docker tag stam-app:latest genadis23/stam-app:release-$(VERSION)
	docker push genadis23/stam-app:release-$(VERSION)