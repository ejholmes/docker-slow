FROM ruby:2.2.2
MAINTAINER Eric Holmes

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /home/app
WORKDIR /home/app

COPY Gemfile /home/app/
COPY Gemfile.lock /home/app/
RUN bundle install --jobs 4 --retry 3  --without development test unit features

COPY . /home/app

CMD ["bundle", "exec", "rails", "console"]
