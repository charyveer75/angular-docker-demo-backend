FROM jfahrer/angular-demo-backend-gems:latest AS gems

FROM ruby:2.5.1
COPY --from=gems /usr/local/bundle /usr/local/bundle

ENV LANG C.UTF-8
ENV PATH ./bin:$PATH
ENV RAILS_LOG_TO_STDOUT true

RUN apt-get update -qq && apt-get install -y build-essential nodejs postgresql-client

WORKDIR /tmp
COPY Gemfile* /tmp/
RUN bundle install

WORKDIR /app
COPY . /app

EXPOSE 3000

ENTRYPOINT ["/app/scripts/docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
