DEV_VENV?=""

.PHONY: deps
deps:
	poetry install

.PHONY: build
build:
	poetry build

.PHONY: publish
publish:
	@echo "Pretending to publish to pypi"

.PHONY: isort-check
isort-check:
	poetry run isort --profile black --diff --check-only ./gitlab_cd_example ./tests

.PHONY: black-check
black-check:
	poetry run black --diff --check ./gitlab_cd_example ./tests/

.PHONY: pylint
pylint:
	poetry run pylint ./gitlab_cd_example ./tests/

.PHONY: flake8 
flake8:
	poetry run flake8 ./gitlab_cd_example ./tests/

.PHONY: lint
lint: isort-check black-check flake8 pylint

.PHONY: mypy
mypy:
	poetry run mypy --namespace-packages --show-error-codes gitlab_cd_example/

.PHONY: fmt
fmt: isort black

.PHONY: black
black:
	poetry run black gitlab_cd_example tests

.PHONY: isort
isort:
	poetry run isort --profile black ./gitlab_cd_example ./tests

.PHONY: test
test:
	poetry run pytest tests/

.PHONY: test-with-cov
test-with-cov:
	poetry run coverage erase
	poetry run pytest --cov gitlab_cd_example --cov-append --cov-branch --cov-report='' --junit-xml=test_results/results.xml tests/
	poetry run coverage report --show-missing
	poetry run coverage xml
