# $:.push File.expand_path("../lib", __FILE__)
Gem::Specification.new do |gem|
  gem.name = "persistence"
  gem.version = "0.0.0"
  gem.authors = ""
  gem.summary = ""

  gem.files = Dir["{config,db,lib}/**/*"]

  gem.add_dependency "rails", "~> 4.1.9"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "database_cleaner"
end
