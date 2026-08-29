SHELL := /bin/bash

default: help;
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# ======================================================================================

##@ Prepare
prepare: ## Prepare the Hugo environment
	@git submodule update --init --recursive

##@ Run
serve: ## serve the hugo page locally
	@hugo server

##@ Release
# accept either `make tag VERSION=v1.2.3` (used by the git-flows release prompt)
# or the aether-style lowercase `make tag version=v1.2.3`
VERSION ?= $(version)

.PHONY: check-branch
check-branch:
	@[ "$$(git symbolic-ref --short HEAD)" = "main" ] || ( echo "Error: must be on 'main' to tag a release"; exit 1 )

.PHONY: check-git-clean
check-git-clean:
	@git diff --quiet && git diff --cached --quiet || ( echo "Error: git repo has uncommitted changes"; exit 1 )

.PHONY: tag
tag: check-git-clean check-branch ## tag the current commit (VERSION=v1.2.3) and push it to publish a release
	@[ "$(VERSION)" ] || ( echo ">> VERSION is not set, usage: make tag VERSION=\"v1.2.3\""; exit 1 )
	@git tag -d $(VERSION) || true
	@git tag -a $(VERSION) -m "Release version: $(VERSION)"
	@git push --delete origin $(VERSION) || true
	@git push origin $(VERSION)

##@ Help
.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
