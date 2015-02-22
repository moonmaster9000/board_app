pushd board; bundle exec cucumber; bundle exec rspec --color --format=doc; popd
pushd persistence; bundle exec rspec --color --format=doc; popd
