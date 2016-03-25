FROM alpine:latest

RUN apk --update add apache2 apache2-proxy-html apache2-proxy apache2-utils libxml2-dev && \
    rm -rf /var/cache/apk/*  && \
    mkdir /app && \
    chown -R apache:apache /app && \
    mkdir -p /scripts/pre-exec.d && \
    mkdir -p /scripts/pre-init.d

ADD run.sh /scripts/run.sh

RUN chmod -R 755 /scripts

WORKDIR /app

CMD ["/scripts/run.sh"]

EXPOSE 80
