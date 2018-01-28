.PHONY: init run clean build-linux build-mac
BINARY_NAME=server

define BUILD_COMMON
	@if [ -d "build" ]; then \
		rm -rf build; \
	fi
	@mkdir build
	@cp -a views build
endef

init:
	@go get -u github.com/golang/dep/cmd/dep
	@dep ensure

run:
	@go run main.go

clean:
	@rm -rf build

build-linux:
	$(call BUILD_COMMON)
	@GOOS=linux GOARCH=amd64 go build -o build/$(BINARY_NAME) -v

build-mac:
	$(call BUILD_COMMON)
	@GOOS=darwin GOARCH=amd64 go build -o build/$(BINARY_NAME) -v
