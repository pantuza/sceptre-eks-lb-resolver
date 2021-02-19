#
# Makefile to control project tasks and work flows
#


help:
	@echo "Sceptre EKS Load Balancer URI resolver"
	@echo
	@echo "Available target rules:"
	@echo
	@echo "bump_patch            Bumps the patch part of the current version"
	@echo "bump_minor            Bumps the minor part of the current version"
	@echo "bump_major            Bumps the major part of the current version"
	@echo
	@echo "build                 Builds the project as a python wheel"
	@echo "dry_release           Runs all steps for releasing but sends to test PyPi"
	@echo "release               Releases a new version on PyPI Index"
	@echo "clean                 Cleans the project build and release files"
	@echo
	@echo "twine_check           Tries validating all build files with twine"
	@echo "test_release          Tries releasing a new version to Test Pypi"
	@echo "check                 Runs linters and checkers of files"
	@echo "test                  Runs Python tests using pytest"
	@echo "deps                  Install requirements.txt dependencies"
	@echo

bump_patch:
	bumpversion patch --verbose
	git push origin main --tags

bump_minor:
	bumpversion minor --verbose
	git push origin main --tags

bump_major:
	bumpversion major --verbose
	git push origin main --tags


.PHONY: build
build:
	python3 setup.py sdist bdist_wheel

dry_release: clean check build twine_check test_release

release: clean check build twine_check
	twine upload dist/*

clean:
	rm -rf build/ dist/ sceptre_eks_lb_resolver.egg-info/ .eggs/


twine_check:
	twine check dist/*

test_release:
	twine upload --repository-url https://test.pypi.org/legacy/ dist/*

check:
	@pycodestyle	

test:
	pytest -ra -q -v tests/*.py

deps: requirements.txt
	pip3 install -r $<
