#!/bin/bash

cd /locomotiveapp

bundle config local.locomotive-subscriptions /locomotive-subscriptions
bundle exec rails generate locomotive_subscriptions:install

# bundle exec rails server -b 0.0.0.0

cd /locomotive-subscriptions

BUNDLE_GEMFILE=/locomotiveapp/Gemfile \
  bundle exec guard -G /locomotiveapp/Guardfile --no-interactions

#rspec spec
