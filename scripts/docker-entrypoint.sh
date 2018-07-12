#!/bin/bash

if [ ! -z "$RUN_MIGRATIONS" ] && [ "$RUN_MIGRATIONS" != "false" ]
then
  echo -n "Waiting for the database to come up";
  until pg_isready -h "$PG_HOST" -U "$PG_USERNAME" > /dev/null; do
    sleep 1
    echo -n "."
  done
  echo ''
  bundle exec rake db:create db:migrate
fi

echo Running "$@"
exec "$@"
