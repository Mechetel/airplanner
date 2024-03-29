# https://hub.docker.com/layers/ruby/library/ruby/3.0.1-buster/images/sha256-d5c828809239010c8549eeaf1f6da84f67bee7f61353e6a4a52159bf3f397aa6
FROM ruby@sha256:d5c828809239010c8549eeaf1f6da84f67bee7f61353e6a4a52159bf3f397aa6

USER root

RUN apt-get update -qq && apt-get install -y \
    build-essential libpq-dev libxml2-dev libxslt1-dev imagemagick apt-transport-https nano vim

RUN apt-get update &&\
    apt-get -y install curl &&\
    curl -sL https://deb.nodesource.com/setup_10.x | bash - &&\
    apt-get -y install nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

ENV APP_USER app

RUN useradd -m -d /home/$APP_USER $APP_USER
RUN mkdir /app && chown -R $APP_USER:$APP_USER /app

WORKDIR /app

USER $APP_USER
