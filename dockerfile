# ==========================================
# ESTÁGIO 1: O Builder (Compilação)
# ==========================================
FROM golang:alpine AS builder

WORKDIR /app

COPY go.mod go.sum* ./

RUN go mod download

COPY . .

RUN  CGO_ENABLED=0 GOOS=linux go build -o api ./cmd/api/main.go



# ==========================================
# ESTÁGIO 2: O Runtime (Produção)
# ==========================================
FROM alpine:latest

WORKDIR /app

COPY --chmod=755 --from=builder /app/api .


EXPOSE 8080

CMD [ "./api" ]