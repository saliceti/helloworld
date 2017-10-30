FROM golang:1.8.5-alpine3.6

RUN mkdir -p $GOPATH/src/github.com/${HUB_ACCOUNT}/helloworld

WORKDIR $GOPATH/src/github.com/${HUB_ACCOUNT}/helloworld

COPY . .

RUN go install

CMD ["/go/bin/helloworld"]
