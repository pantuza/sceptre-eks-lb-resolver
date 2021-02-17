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
	@echo "release               Releases a new version on PyPI Index"
	@echo "clean                 Cleans the project build and release files"
	@echo
	@echo "twine_check           Tries validating all build files with twine"
	@echo "test_release          Tries releasing a new version to Test Pypi"
	@echo "check                 Runs linters and checkers of files"
	@echo

bump_patch:
	bumpversion patch --verbose

bump_minor:
	bumpversion minor --verbose

bump_major:
	bumpversion major --verbose


.PHONY: build
build:
	python3 setup.py sdist bdist_wheel

release:
	twine upload dist/*

clean:
	rm -rf build/ dist/ sceptre_eks_lb_resolver.egg-info/ .eggs/


twine_check:
	twine check dist/*

test_release:
	twine upload --repository-url https://test.pypi.org/legacy/ dist/*

check:
	@pycodestyle	
