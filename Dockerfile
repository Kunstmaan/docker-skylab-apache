FROM alpine:latest

RUN apk --update add apache2 apache2-proxy-html apache2-proxy apache2-utils && \
    rm -rf /var/cache/apk/*  && \
    mkdir /app && \
    chown -R apache:apache /app && \
    mkdir -p /scripts/pre-exec.d && \
    mkdir -p /scripts/pre-init.d && \
    chmod -R 755 /scripts

ADD run.sh /scripts/run.sh

WORKDIR /app

CMD ["/scripts/run.sh"]

EXPOSE 80
