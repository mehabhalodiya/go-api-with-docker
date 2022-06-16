FROM golang:alpine AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /go-api-with-docker

FROM alpine:latest

WORKDIR /

COPY --from=build /go-api-with-docker /go-api-with-docker

EXPOSE 8081

ENTRYPOINT ["/go-api-with-docker"]