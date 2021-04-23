FROM ruby:3.0

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

RUN mkdir /var/www && \
   chown -R $APP_USER:$APP_USER /var/www && \
   chown -R $APP_USER /home/$APP_USER

WORKDIR /app

USER $APP_USER

ADD Gemfile Gemfile.lock /app/

RUN bundle install

######################################################

ADD . $APP_HOME/

USER root

RUN chown -R $APP_USER:$APP_USER "$APP_HOME/."

USER $APP_USER

ENV RAILS_ENV production
RUN bin/rails assets:precompile
