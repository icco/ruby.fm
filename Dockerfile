FROM simplecasual/ruby:2.4.1

RUN addgroup -g 1000 rails \
    && adduser -u 1000 -G rails -s /bin/sh -D rails

RUN apk --update --upgrade add --no-cache \
        nodejs \
        postgresql \
        postgresql-client \
        postgresql-dev \
        taglib-dev && \
        rm /var/cache/apk/*

RUN mkdir -p /app

WORKDIR /app

COPY Gemfile* /app/

RUN bundle install

RUN chown -R rails:rails /app

USER rails

ADD . /app

CMD ["rails", "server", "--binding", "0.0.0.0"]

