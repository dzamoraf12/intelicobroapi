#!/bin/sh
# https://stackoverflow.com/a/38732187/1935918
set -e

if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi

bundle install
bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake db:seed

exec bundle exec "$@"