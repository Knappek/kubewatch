.PHONY: default build docker-image test stop clean-images clean

BINARY = kubewatch

VERSION?=latest
BUILD=

PKG            = github.com/bitnami-labs/kubewatch
TRAVIS_COMMIT ?= `git describe --tags`
GOCMD          = go
BUILD_DATE     = `date +%FT%T%z`
GOFLAGS       ?= $(GOFLAGS:)
LDFLAGS       := "-X '$(PKG)/cmd.gitCommit=$(TRAVIS_COMMIT)' \
		          -X '$(PKG)/cmd.buildDate=$(BUILD_DATE)'"
GITHUB_USERNAME=knappek

default: build test

build:
	"$(GOCMD)" build ${GOFLAGS} -ldflags ${LDFLAGS} -o "${BINARY}"

docker-image:
	@docker build -t $(GITHUB_USERNAME)/$(BINARY):$(VERSION) .

docker-push: docker-image
	docker push $(GITHUB_USERNAME)/$(BINARY):$(VERSION)

test:
	"$(GOCMD)" test -race -v $(shell go list ./... | grep -v '/vendor/')

stop:
	@docker stop "$(GITHUB_USERNAME)/${BINARY}"

clean-images: stop
	@docker rmi "${BUILDER}" "${BINARY}"

clean:
	"$(GOCMD)" clean -i
