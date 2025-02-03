rm -rf _site .jekyll-cache Gemfile.lock;

bundle install;
JEKYLL_ENV=production bundle exec jekyll build --future --safe --trace;
