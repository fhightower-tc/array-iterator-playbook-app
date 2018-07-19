.PHONY: clean clean-test clean-pyc clean-build docs help
.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: clean-tcx clean-build clean-pyc clean-test ## remove all tcex, build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/

clean-tcx: ## remove tcx artifacts
	rm -fr ./array_iterator/array_iterator-package.log
	rm -fr ./array_iterator/array_iterator-libs.log

lib: clean ## download required packages into a lib directory
	cd ./array_iterator && tclib

pack: clean ## package the app for deployment to TC
	cd ./array_iterator && tcpackage --outdir ../

run: clean ## run the app locally... the project name must be lower cased as done here: https://github.com/ThreatConnect-Inc/tcex/blob/master/bin/tcprofile#L106
	cd ./array_iterator && tcrun --profile array-iterator

profile: clean ## create a tcex.json profile for the app
	cd ./array_iterator && tcprofile --outfile tcex.json

test: clean ## run tests on the app
	pytest ./tests
