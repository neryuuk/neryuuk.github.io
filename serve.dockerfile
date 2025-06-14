FROM ruby:V_RUBY-alpineV_ALPINE

COPY --chown=0:0 Gemfile /usr/src/Gemfile

WORKDIR /usr/src

RUN ["apk", "add", "--update", "build-base"]

RUN ["gem", "update", "--system", "V_GEMS"]

RUN ["gem", "install", "bundler", "--version", "V_BUNDLER"]

RUN ["bundle", "install"]

EXPOSE 4000

EXPOSE 35729

VOLUME ["/usr/src"]

ENTRYPOINT ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--disable-disk-cache", "--future", "--livereload", "--safe", "--trace"]
