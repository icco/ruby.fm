FROM ruby:2.3.1

RUN wget --quiet -O - "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt jessie-pgdg main" >> /etc/apt/sources.list

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y nodejs nodejs-legacy libtag1-dev postgresql-client-9.5 && \
  rm -rf /var/lib/apt/lists/*

RUN gem install rails --version "4.2.7.1"

RUN mkdir -p /app

WORKDIR /app

COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN bundle install --jobs 4

ADD . /app

EXPOSE 3000

CMD ["rails", "server", "--port", "3000", "--binding", "0.0.0.0"]
