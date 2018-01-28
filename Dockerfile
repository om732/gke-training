FROM golang:1.8-alpine AS go-build
ADD . /go/src/golang-echo
WORKDIR /go/src/golang-echo
RUN apk add --no-cache git make && \
    make init && \
    make build-linux

FROM alpine:latest
COPY --from=go-build /go/src/golang-echo/build /app
WORKDIR /app
CMD ["./server"]
