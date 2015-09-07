Gem::Specification.new do |gem|
  gem.name = "cookie_session"
  gem.version = "0.0.0"
  gem.authors = ""
  gem.summary = ""

  gem.files = Dir[File.join(__dir__, "lib", "**", "*.rb")]

  gem.add_development_dependency "rspec"
  gem.add_dependency "authenticated_board"
end
