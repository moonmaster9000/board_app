Gem::Specification.new do |gem|
  gem.name = "email_client"
  gem.version = "0.0.0"
  gem.authors = ""
  gem.summary = ""

  gem.files = Dir[File.join(__dir__, "lib", "**", "*.rb")]

  gem.add_dependency "mail", "~> 2.6"
end
