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

RUN yarn add bootstrap\
             sass\
             sass-loader\
             dotenv\
             jquery\
             popper.js\
             @popperjs/core\
             @babel/core\
             @babel/preset-react\
             @babel/plugin-proposal-decorators\
             @babel/plugin-proposal-class-properties\
             moment\
             normalizr-immutable\
             immutable\
             reselect\
             react-sortable-hoc\
             isomorphic-fetch\
             react\
             react-immutable-proptypes\
             react-fileupload\
             react-dom\
             react-redux\
             redux\
             redux-thunk\
             redux-logger\
             redux-immutable\
             redux-actions\
             react-datepicker\
             react-redux-toastr --save

ENV APP_USER app

RUN useradd -m -d /home/$APP_USER $APP_USER

RUN mkdir /app && chown -R $APP_USER:$APP_USER /app

WORKDIR /app

USER $APP_USER

######################################################

ADD Gemfile Gemfile.lock /app/

RUN bundle install

ADD . $APP_HOME/

USER root

RUN chown -R $APP_USER:$APP_USER "$APP_HOME/."

USER $APP_USER

ENV RAILS_ENV production
RUN bin/rails assets:precompile
