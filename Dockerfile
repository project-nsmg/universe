FROM ruby:2

RUN mkdir /app
WORKDIR /app

RUN gem install bundler
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

CMD rackup --host 0.0.0.0 --port 4567
EXPOSE 4567

ADD . /app
