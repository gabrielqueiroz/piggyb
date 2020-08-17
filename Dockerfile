FROM ruby:2.7.1

EXPOSE 3000
CMD ["rails", "s", "-b", "0.0.0.0"]

ARG APP_HOME=/app
WORKDIR ${APP_HOME}

COPY . $APP_HOME

RUN apt-get update && \
    apt-get install -y net-tools && \
    apt-get install nodejs -y && \
    gem install bundler

COPY Gemfile ${APP_HOME}/Gemfile
COPY Gemfile.lock ${APP_HOME}/Gemfile.lock

RUN bundle install && \
    bundle exec rake assets:precompile

COPY . ${APP_HOME}