FROM ruby:2.3.7-jessie

WORKDIR /tmp

ENV ADDRESS "https://google.com"

ENV SECRET_KEY_BASE "dd78deaf310bd9659853e5735e458a366136e1caa91a9075059cbf25fa2d230bc4d25866ed994568e85118ab2a181271246de963dd9a50508f1e9ffbf26f17c7"

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
