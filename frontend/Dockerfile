FROM node:14.4.0

WORKDIR /opt

RUN apt-get update \
    && apt-get install vim -y

RUN npm install -g @angular/cli

CMD tail -f /dev/null