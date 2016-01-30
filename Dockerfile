FROM ruby:2.3

RUN apt-get update && \
  apt-get install -y \
    nodejs \
    postgresql-client \
    libtag1-dev \
    --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

ENV RAILS_VERSION 4.2.5.1

RUN gem install rails --version "$RAILS_VERSION"

ENV APP_DIR /app

RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

COPY Gemfile $APP_DIR/
COPY Gemfile.lock $APP_DIR/

RUN bundle install --jobs 4

ADD . $APP_DIR
