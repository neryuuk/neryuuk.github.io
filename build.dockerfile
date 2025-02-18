FROM ruby:V_RUBY-alpine

COPY --chown=0:0 Gemfile /usr/src/Gemfile

WORKDIR /usr/src

RUN ["apk", "add", "--update", "build-base"]

RUN ["gem", "update", "--system", "V_GEMS"]

RUN ["gem", "install", "bundler", "--version", "V_BUNDLER"]

RUN ["bundle", "install"]

VOLUME ["/usr/src"]

ENTRYPOINT ["bundle", "exec", "jekyll", "build", "--future", "--safe", "--trace", "--future"]
