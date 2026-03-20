# Stage 1: Build
FROM golang:1.22 AS builder

WORKDIR /app
COPY . .

RUN go mod tidy
RUN go build -o main .

# Stage 2: Run (lightweight)
FROM gcr.io/distroless/base

WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/static ./static

EXPOSE 9090

CMD ["./main"]