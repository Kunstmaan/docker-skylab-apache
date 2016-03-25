FROM ubuntu:wily

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN echo 'deb http://ppa.launchpad.net/ondrej/apache2/ubuntu wily main' >> /etc/apt/sources.list && \
    apt-get -y -q update && \
    apt-get -y -q install apache2 && \
    a2enmod autoindex deflate expires filter headers include mime rewrite setenvif proxy_fcgi && \
    apt-get -y -q autoremove && \
    apt-get -y -q clean && \
    rm -rf /var/lib/apt/lists/*

ADD run.sh /scripts/run.sh
ADD default.conf /etc/apache2/sites-available/000-default.conf

RUN chmod -R 755 /scripts

CMD ["/scripts/run.sh"]

WORKDIR /app

EXPOSE 80
