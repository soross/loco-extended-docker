################################################################################
# LocomotiveCMS app container
################################################################################
FROM ruby:2.3.1
MAINTAINER Ben Williams

# args
ARG mongohost=locodocker_db_1:27017
ENV RAILS_ENV=development

# nodejs
RUN apt-get update
RUN apt-get install -y nodejs

# gems
RUN gem install --version "4.2.6" rails

# rails app
RUN rails new locomotiveapp --skip-bundle --skip-active-record
WORKDIR /locomotiveapp

# locomotive install
COPY ./Gemfile /locomotiveapp/Gemfile
RUN bundle install
RUN bundle exec rails generate rspec:install
RUN bundle exec rails generate locomotive:install
COPY ./Guardfile /locomotiveapp/Guardfile

# locomotive config
RUN sed -i -- "s/localhost:27017/$mongohost/g" /locomotiveapp/config/mongoid.yml

# start script
COPY start_app.sh /root/
RUN chmod +x /root/start_app.sh

EXPOSE 3000
ENTRYPOINT /root/start_app.sh
