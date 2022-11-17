FROM debian:sid-slim

RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y install apache2

CMD ["apachectl", "-D", "FOREGROUND"]
