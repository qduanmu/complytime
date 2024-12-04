GO_BUILD_PACKAGES := ./cmd/...
GO_BUILD_BINDIR :=./bin
GIT_COMMIT := $(or $(SOURCE_GIT_COMMIT),$(shell git rev-parse --short HEAD))
GIT_TAG :="$(shell git tag | sort -V | tail -1)"

GO_LD_EXTRAFLAGS :=-X github.com/complytime/complytime/version.version="$(GIT_TAG)" \
				   -X github.com/complytime/complytime/version.gitTreeState=$(shell test -n "`git status --porcelain`" && echo "dirty" || echo "clean") \
				   -X github.com/complytime/complytime/version.commit="$(GIT_COMMIT)" \
				   -X github.com/complytime/complytime/version.buildDate="$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')"

dev-setup: dev-setup-commit-hooks
.PHONY: dev-setup

dev-setup-commit-hooks:
	pre-commit install --hook-type pre-commit --hook-type pre-push
.PHONY: dev-setup-commit-hooks

build: prep-build-dir
	go build -o $(GO_BUILD_BINDIR)/ -ldflags="$(GO_LD_EXTRAFLAGS)" $(GO_BUILD_PACKAGES)
.PHONY: build

prep-build-dir:
	mkdir -p ${GO_BUILD_BINDIR}
.PHONY: prep-build-dir

vendor:
	go mod tidy
	go mod verify
	go mod vendor
.PHONY: vendor

clean:
	@rm -rf ./$(GO_BUILD_BINDIR)/*
.PHONY: clean

test-unit:
	go test -race -v -coverprofile=coverage.out ./...
.PHONY: test-unit

sanity: vendor format vet
	git diff --exit-code
.PHONY: sanity

format:
	go fmt ./...
.PHONY: format

vet:
	go vet ./...
.PHONY: vet

all: clean vendor test-unit build
.PHONY: all
