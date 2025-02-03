rm -rf _site .jekyll-cache Gemfile.lock;

echo "ruby $(ruby -v | egrep -o "[0-9]+\.[0-9]+\.[0-9]+")";
echo "gem $(gem -v | egrep -o "[0-9]+\.[0-9]+\.[0-9]+")";
echo "bundle $(bundle -v | egrep -o "[0-9]+\.[0-9]+\.[0-9]+")";
echo "jekyll $(jekyll -v | egrep -o "[0-9]+\.[0-9]+\.[0-9]+")";

bundle install;
JEKYLL_ENV=production bundle exec jekyll serve --disable-disk-cache --future --livereload --safe --trace;
