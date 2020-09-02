$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chambers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chambers"
  s.version     = Chambers::VERSION
  s.authors     = ["Jake Helbig"]
  s.email       = ["jake@jakehelbig.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Chambers."
  s.description = "TODO: Description of Chambers."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.11.3"

  s.add_development_dependency "sqlite3"
end
