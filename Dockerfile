FROM ruby:3.0.3-alpine3.15

WORKDIR /app

COPY . .

ENV GITHUB_TOKEN=

RUN apk update && apk upgrade && apk --update add \
    build-base tzdata && \
    echo 'gem: --no-document' > /etc/gemrc && \
    bundle config set no-cache 'true' && \
    bundle config set no-binstubs 'true' && \
    bundle config set deployment 'true' && \
    bundle install --jobs=2 && \
    echo "Europe/London" > /etc/timezone && \
    cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
    apk del build-base

CMD bundle exec rackup --host 0.0.0.0 -p 3000