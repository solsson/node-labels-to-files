FROM golang:1.16 as builder

RUN go get honnef.co/go/tools/cmd/staticcheck

COPY . /go/src/github.com/bjhaid/node-labels-to-files
WORKDIR /go/src/github.com/bjhaid/node-labels-to-files

RUN go test \
  && staticcheck . \
  && go build -o /usr/bin/node-labels-to-files

FROM debian:buster-slim

COPY --from=builder /usr/bin/node-labels-to-files /usr/bin/

ENTRYPOINT ["/usr/bin/node-labels-to-files"]
