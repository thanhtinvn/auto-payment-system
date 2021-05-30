FROM ruby:2.7.1

WORKDIR /opt

RUN apt-get update\
    && apt-get install vim -y

# TODO update install nodejs and yarn

RUN gem install rails

CMD tail -f /dev/null