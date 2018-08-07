FROM golang:1.10.2 as builder
RUN mkdir -p src/github.com/prometheus/pushgateway
COPY . src/github.com/prometheus/pushgateway/
WORKDIR src/github.com/prometheus/pushgateway
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o pushgateway .


FROM  quay.io/prometheus/busybox:latest
LABEL maintainer "Kevin Yang <cn.kevin.home@gmail.com>"
COPY --from=builder /go/src/github.com/prometheus/pushgateway/pushgateway /bin/pushgateway
EXPOSE     9091
RUN mkdir -p /pushgateway
WORKDIR    /pushgateway
ENTRYPOINT [ "/bin/pushgateway" ]
