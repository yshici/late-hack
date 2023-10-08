FROM ruby:2.7.1
WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -yq nodejs yarn

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
RUN yarn install
COPY . /app
