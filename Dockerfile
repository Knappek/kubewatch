FROM golang:alpine AS builder
MAINTAINER "Andy Knapp  (andy.knapp.ak@gmail.com)"

RUN apk update && \
    apk add git build-base && \
    rm -rf /var/cache/apk/* && \
    mkdir -p "$GOPATH/src/github.com/bitnami-labs/kubewatch"

ADD . "$GOPATH/src/github.com/bitnami-labs/kubewatch"

RUN cd "$GOPATH/src/github.com/bitnami-labs/kubewatch" && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a --installsuffix cgo --ldflags="-s" -o /kubewatch

FROM alpine:3.4
RUN apk add --update ca-certificates

COPY --from=builder /kubewatch /bin/kubewatch

ENTRYPOINT ["/bin/kubewatch"]
