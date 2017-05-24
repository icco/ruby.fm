FROM ruby:2.4.1-alpine

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk --update --upgrade add --no-cache \
        libstdc++ \
        tzdata \
        bash \
        git \
        nodejs \
        build-base \
        linux-headers \
        ruby-dev \
        libc-dev \
        openssl-dev \
        postgresql-dev \
        postgresql-client \
        libxml2-dev \
        libxslt-dev \
        taglib-dev \
        ca-certificates && \
        rm /var/cache/apk/*

RUN echo 'gem: --no-document' > /etc/gemrc

COPY Gemfile* /tmp/

WORKDIR /tmp

RUN bundle install

RUN mkdir -p /app

WORKDIR /app

ADD . /app

CMD ["rails", "server", "--binding", "0.0.0.0"]
