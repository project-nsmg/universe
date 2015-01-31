FROM ruby:2
MAINTAINER sorpa'as plat (me@sorpaas.com)

RUN mkdir -p /app
ADD . /app
WORKDIR /app
CMD ruby -run -e httpd . -p 9090
