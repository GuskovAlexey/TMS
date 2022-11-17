FROM ubuntu:xenial 

RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y install apache2

ADD ./apache2.conf /etc/apache2

ADD ./www.test.com.conf /etc/apache2/sites-available

RUN a2ensite www.test.com && a2dissite 000-default.conf

CMD ["apachectl", "-D", "FOREGROUND"]
