Gem::Specification.new do |gem|
  gem.name = "markdown_standup_email_formatter"
  gem.author = ""
  gem.version = "0.0.0"
  gem.summary = ""

  gem.files = Dir[File.join(__dir__, "lib", "**", "*.rb")]

  gem.add_development_dependency("rspec")
  gem.add_dependency("github-markdown")
end
