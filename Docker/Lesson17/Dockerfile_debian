FROM debian:sid-slim

RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y install apache2

ADD index.html /var/www/html

CMD ["apachectl", "-D", "FOREGROUND"]
