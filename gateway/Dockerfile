FROM golang:1.15.2-alpine as builder
COPY . /build/
WORKDIR /build
RUN CGO_ENABLED=0 go build -o gateway

FROM scratch
COPY --from=builder /build/gateway /gateway

ENTRYPOINT ["/gateway"]