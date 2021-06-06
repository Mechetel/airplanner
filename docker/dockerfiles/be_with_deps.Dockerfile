# https://hub.docker.com/layers/ruby/library/ruby/3.0.1-buster/images/sha256-d5c828809239010c8549eeaf1f6da84f67bee7f61353e6a4a52159bf3f397aa6
FROM ruby@sha256:d5c828809239010c8549eeaf1f6da84f67bee7f61353e6a4a52159bf3f397aa6

USER root

RUN apt-get update -qq && apt-get install -y \
    build-essential libpq-dev libxml2-dev libxslt1-dev imagemagick apt-transport-https nano vim wget

RUN apt-get update &&\
    apt-get -y install curl &&\
    curl -sL https://deb.nodesource.com/setup_10.x | bash - &&\
    apt-get -y install nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

WORKDIR /app

RUN wget --show-progress -q -O /usr/bin/waitforit https://github.com/maxcnunes/waitforit/releases/download/v1.3.1/waitforit-linux_amd64 && chmod +x /usr/bin/waitforit

######################################################

COPY package.json /app/
RUN yarn install

######################################################

COPY Gemfile Gemfile.lock /app/

RUN bundle install

COPY . /app

RUN SECRET_KEY_BASE=dummysecretkeybase \
  RACK_ENV=production \
  RAILS_ENV=production \
  RAILS_SERVE_STATIC_FILES=true \
  REDIS_URL=redis://dummyredis:1234 \
  APP_SESSION_KEY=dummy_app_session_key \
  DATABASE_URL=postgres://dummy_user:dummy_password@postgres:5432/dummy_db \
  bin/rails assets:precompile
