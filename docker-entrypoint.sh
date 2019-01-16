#!/bin/bash

sed -i "s/CHANGEME/$ADDRESS/" /app/application.rb

RAILS_ENV=production bundle exec crono start

exec bundle exec puma -C config/puma.rb
