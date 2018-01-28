FROM golang:1.8-alpine AS go-build
ENV GOOS=linux \
    GOARCH=amd64
ADD . /go/src/golang-echo
WORKDIR /go/src/golang-echo
RUN dep ensure && \
    go build -o server maint.go

FROM alpine:latest
COPY --from=go-build /go/src/golang-echo/server .
ENV PORT=8080
CMD ["./server"]
