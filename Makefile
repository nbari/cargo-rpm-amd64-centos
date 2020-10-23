.PHONY: all build push

TAG := $(shell docker images cargo-rpm-amd64-centos8:latest -q)

all: build

build:
	docker build -t cargo-rpm-amd64-centos8 .

push:
	@docker tag ${TAG} nbari/cargo-rpm-amd64-centos:latest
	@docker push nbari/cargo-rpm-amd64-centos:latest
