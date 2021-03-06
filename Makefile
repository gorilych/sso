version := "v1.0.0"

commit := $(shell git rev-parse --short HEAD)

build: dist/sso-auth dist/sso-proxy

dist/sso-auth:
	mkdir -p dist
	go generate ./...
	go build -o dist/sso-auth ./cmd/sso-auth

dist/sso-proxy:
	mkdir -p dist
	go generate ./...
	go build -o dist/sso-proxy ./cmd/sso-proxy

test:
	./scripts/test

clean:
	rm -r dist

imagepush:
	docker build -t gorilych/sso:latest -t gorilych/sso:$(commit) .
	docker push gorilych/sso:$(commit)
	docker push gorilych/sso:latest
