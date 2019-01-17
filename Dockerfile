FROM ruby:2.3.7-jessie

WORKDIR /tmp

ENV ADDRESS "https://google.com"

COPY Gemfile* ./

RUN echo 'gem: --no-document' >> /.gemrc

RUN bundle

ENV APP_HOME /app

COPY . $APP_HOME

RUN rm -rf $APP_HOME/.git

WORKDIR $APP_HOME

RUN chmod +777 /app/docker-entrypoint.sh

RUN chmod -R +777 /app/bin/

RUN rm -rf /app/tmp/cache

RUN rm -f /app/tmp/pids/*.pid

RUN rm -rf /app/public/assets

RUN RAILS_ENV=production bundle exec rake assets:clean

RUN RAILS_ENV=production bundle exec rake assets:precompile

ENTRYPOINT ["/app/docker-entrypoint.sh"]

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
