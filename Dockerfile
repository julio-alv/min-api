FROM golang:tip-20251102-alpine3.22 AS base

WORKDIR /app

# Build source
FROM base AS builder
WORKDIR /app

COPY . .
RUN go build -o api .

# Final image
FROM alpine:3.22 AS runner
WORKDIR /app

COPY --from=builder /app/api ./

EXPOSE 8080

CMD ["./api"]