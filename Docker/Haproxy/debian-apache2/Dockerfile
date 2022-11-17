FROM ubuntu:20.04

RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y install apache2 libapache2-mod-wsgi &&\
    mkdir -p /opt/apache2/www.test.com /opt/apache2/logs /opt/cert

ADD ./apache2.conf /etc/apache2

ADD ./www.test.com.conf /etc/apache2/sites-available

COPY ./cert /opt/cert

RUN chown -R www-data:www-data /opt/cert && \
    a2enmod wsgi && a2enmod ssl && \
    a2ensite www.test.com && a2dissite 000-default.conf

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]
