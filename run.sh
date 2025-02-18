#!/bin/bash

cleanup ()
{
  rm -rf _site .jekyll-cache Dockerfile Gemfile.lock;
}

setup ()
{
  cleanup;

  export TAG="neryuuk.github.io"
  export V_RUBY=`grep -E '^ruby' Gemfile | grep -Eo '[0-9.]+'`;
  export V_GEMS="3.6.4";
  export V_BUNDLER="2.6.4";

  if [[ -z ${VOLUME+x} ]]; then export VOLUME=.; fi;
}

dockerbuild ()
{
  echo "Selecting '$1.dockerfile' as Dockerfile";
  sed "s/V_RUBY/$V_RUBY/;s/V_GEMS/$V_GEMS/;s/V_BUNDLER/$V_BUNDLER/" $1.dockerfile > Dockerfile;

  echo "Docker build $TAG";
  docker build . \
    --no-cache \
    --tag $TAG;
}

serve () {
  dockerbuild serve;

  echo "Serving...";
  docker run --detach \
    --env JEKYLL_ENV=production \
    --publish 4000:4000 \
    --publish 35729:35729 \
    --volume $VOLUME:/usr/src \
    $TAG;
}

build ()
{
  dockerbuild build;

  echo "Building...";
  docker run \
    --env JEKYLL_ENV=production \
    --volume $VOLUME:/usr/src \
    $TAG;

  rm -rf Dockerfile;
}

run ()
{
  if [[ "$1" == "serve" ]]; then serve; else build; fi
}

setup;
run $1;
