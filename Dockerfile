FROM rails:4.2.1

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    libtag1-dev && \
  rm -rf /var/lib/apt/lists/*

ENV APP_DIR /app

RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

COPY Gemfile $APP_DIR/
COPY Gemfile.lock $APP_DIR/

RUN bundle install --jobs 4

ADD . $APP_DIR
