.PHONY: build-linux
BINARY_NAME=server

init:
	@go get -u github.com/golang/dep/cmd/dep
	@dep ensure

run:
	@go run main.go

build-linux:
	@GOOS=linux GOARCH=amd64 go build -o $(BINARY_NAME) -v

build-mac:
	@GOOS=darwin GOARCH=amd64 go build -o $(BINARY_NAME) -v
