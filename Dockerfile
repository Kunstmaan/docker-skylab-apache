FROM alpine:latest

RUN apk --update add apache2 apache2-proxy-html apache2-proxy apache2-utils libxml2-dev sed && \
    rm -rf /var/cache/apk/*  && \
    mkdir /app && \
    mkdir -p /run/apache2/ && \
    chown -R apache:apache /app && \
    mkdir -p /scripts/pre-exec.d && \
    mkdir -p /scripts/pre-init.d && \
    sed -i '/#LoadModule slotmem_shm_module modules\/mod_slotmem_shm.so/s/#//' /etc/apache2/httpd.conf

ADD run.sh /scripts/run.sh

RUN chmod -R 755 /scripts

WORKDIR /app

CMD ["/scripts/run.sh"]

EXPOSE 80
