install-requirements:
	pip install -r requirements.txt
	pip install -r dev-requirements.txt

# linter
lint:
	ruff check --preview ./main.py

# lint and fix
lint-fix:
	ruff check --preview --fix ./main.py