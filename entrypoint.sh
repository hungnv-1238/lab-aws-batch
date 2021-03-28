#!/usr/bin/env bash

sleep 15 # TODO: use nc or wait-for-it later

rm -f /app/tmp/pids/server.pid
bundle exec rake db:create db:migrate && bundle exec rails server -b 0.0.0.0 -p 3000
