source vars.sh

rm -rf _site .jekyll-cache Dockerfile Gemfile.lock;

sed "s/V_RUBY/$V_RUBY/;s/V_GEMS/$V_GEMS/;s/V_BUNDLER/$V_BUNDLER/" serve.dockerfile > Dockerfile;

docker build . --no-cache --tag $TAG;

docker run --detach \
  --env JEKYLL_ENV=production \
  --publish 4000:4000 \
  --publish 35729:35729 \
  --volume $VOLUME:/usr/src \
  $TAG;
