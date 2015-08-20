Gem::Specification.new do |gem|
  gem.name = "authenticated_board"
  gem.authors = ""
  gem.version = "0.0.0"
  gem.summary = ""

  gem.files = Dir[File.join(__dir__, "lib", "**", "*.rb")]

  gem.add_development_dependency "rspec"
  gem.add_dependency "board"
end
