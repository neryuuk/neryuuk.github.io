ruby -v;
gem -v;
bundle -v;

bundle install;
JEKYLL_ENV=production bundle exec jekyll serve --disable-disk-cache --future --livereload --safe --trace;
