FROM jekyll/builder:stable

COPY --chown=jekyll:jekyll . /srv/jekyll/

WORKDIR /srv/jekyll

RUN ["bundle", "update"]

EXPOSE 4000

EXPOSE 35729

ENTRYPOINT ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
