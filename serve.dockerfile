FROM ruby:3.4.2-alpine

COPY --chown=0:0 Gemfile /usr/src/Gemfile

WORKDIR /usr/src

RUN ["apk", "add", "--update", "build-base"]

RUN ["gem", "update", "--system", "3.6.4"]

RUN ["gem", "install", "bundler", "--version", "2.6.4"]

RUN ["bundle", "install"]

EXPOSE 4000

EXPOSE 35729

VOLUME ["/usr/src"]

ENTRYPOINT ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--disable-disk-cache", "--future", "--livereload", "--safe", "--trace"]
