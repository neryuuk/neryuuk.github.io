FROM ruby:3.3.7-alpine

COPY --chown=0:0 . /usr/src/

RUN ["apk", "add", "--update", "build-base"]

WORKDIR /usr/src

RUN ["bundle", "install"]

EXPOSE 4000

EXPOSE 35729

ENTRYPOINT ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
