pushd board; bundle install; popd
pushd persistence; bundle install; rake db:setup; popd
pushd web; bundle install; rake db:setup; popd
