#!/bin/sh

#set environment variable
if test -z "$API_HOST"
then
      echo "API_HOST is not set, defaulting to http://localhost"
      echo VUE_APP_HOST=http://localhost > .env
else
      echo VUE_APP_HOST=$API_HOST > .env
fi

#launch Vue App with http-server
http-server dist -p 8081


