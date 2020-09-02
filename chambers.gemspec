$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chambers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chambers"
  s.version     = Chambers::VERSION
  s.authors     = ["Jake Helbig"]
  s.email       = ["jake@jakehelbig.com"]
  s.homepage    = "https://github.com/jhelbig/chambers"
  s.summary     = "Chambers is a p2p room automation service."
  s.description = "Chambers is a p2p room automation service that will manage an entire room and all of the assets connected to it."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 6.0.3"

  s.add_development_dependency "sqlite3"
end
