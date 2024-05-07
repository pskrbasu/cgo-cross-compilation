OUTPUT_DIR := .
PACKAGE_NAME          := github.com/pskrbasu/cgo-cross-compilation
GOLANG_CROSS_VERSION  ?= v1.21.5

.PHONY: build
build:
	go build -o $(OUTPUT_DIR)/cgo .

.PHONY: release-dry-run
release-dry-run:
	@docker run \
		--rm \
		-e CGO_ENABLED=1 \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v `pwd`:/go/src/cgo-cross-compilation \
		-w /go/src/cgo-cross-compilation \
		ghcr.io/goreleaser/goreleaser-cross:${GOLANG_CROSS_VERSION} \
		--clean --skip-validate --skip-publish --snapshot --rm-dist
 