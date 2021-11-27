FROM php:7.3-apache

RUN apt-get update

COPY ./src /var/www/html

EXPOSE 80
