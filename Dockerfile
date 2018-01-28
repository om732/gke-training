FROM golang:1.8-alpine AS go-build
RUN apk add --no-cache git make
WORKDIR /go/src/golang-echo
ADD ./app /go/src/golang-echo
RUN make init && \
    make build-linux

FROM alpine:latest
COPY --from=go-build /go/src/golang-echo/build /app
WORKDIR /app
CMD ["./app"]
