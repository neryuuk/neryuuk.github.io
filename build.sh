#!/bin/bash

source vars.sh

rm -rf _site .jekyll-cache Dockerfile Gemfile.lock;

sed "s/V_RUBY/$V_RUBY/;s/V_GEMS/$V_GEMS/;s/V_BUNDLER/$V_BUNDLER/" build.dockerfile > Dockerfile;

docker build . \
  --no-cache \
  --tag $TAG;

docker run \
  --env JEKYLL_ENV=production \
  --volume $VOLUME:/usr/src \
  $TAG;

rm -rf Dockerfile;
