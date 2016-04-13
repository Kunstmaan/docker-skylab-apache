FROM ubuntu:wily

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/selfsigned.key -out /etc/ssl/certs/selfsigned.crt -subj "/C=BE/ST=Vlaams-Brabant/L=Leuven/O=Kunstmaan/OU=Smarties/CN=$VIRTUAL_HOST"

RUN echo 'deb http://ppa.launchpad.net/ondrej/apache2/ubuntu wily main' >> /etc/apt/sources.list && \
    apt-get -y -q update && \
    apt-get -y -q install apache2 && \
    a2enmod autoindex deflate expires filter headers include mime rewrite setenvif proxy_fcgi proxy_http && \
    apt-get -y -q autoremove && \
    apt-get -y -q clean && \
    rm -rf /var/lib/apt/lists/*

ADD run.sh /scripts/run.sh
ADD default.conf /etc/apache2/sites-available/000-default.conf

RUN chmod -R 755 /scripts

CMD ["/scripts/run.sh"]

WORKDIR /app

EXPOSE 80
EXPOSE 443
