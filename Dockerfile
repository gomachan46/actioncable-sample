FROM ruby:2.3.3
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev nodejs mysql-client

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

# config bundle
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile BUNDLE_JOBS=2 BUNDLE_PATH=/datastore

ADD . $APP_HOME
