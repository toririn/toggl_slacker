FROM ruby:2.2
ENV LANG C.UTF-8
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN bundle install

CMD ["bundle", "exec", "clockwork", "clockwork.rb"]
