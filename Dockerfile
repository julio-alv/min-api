FROM golang:1.25.1-alpine3.22 AS build
RUN adduser --disabled-password -u 10001 user

WORKDIR /go/src/app

COPY . .
RUN go mod download
RUN go build -ldflags="-s" -o /go/bin/app -v

# Runner
FROM scratch
WORKDIR /app

COPY --from=build /go/bin/app /go/bin/app
COPY --from=build /etc/passwd /etc/passwd
USER user

EXPOSE 8080

ENTRYPOINT [ "/go/bin/app" ]