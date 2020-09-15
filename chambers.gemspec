$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "chambers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "chambers"
  spec.version     = Chambers::VERSION
  spec.authors     = ["Jake Helbig"]
  spec.email       = ["jake@jakehelbig.com"]
  spec.homepage    = "https://github.com/jhelbig/chambers"
  spec.summary     = "Chambers is a p2p room automation service."
  spec.description = "Chambers is a p2p room automation service that will manage an entire room and all of the assets connected to it."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "sqlite3"
  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"
  spec.add_dependency "uuid", ">=2.3.9"
  spec.add_dependency "uuid_validator", "~> 0.0.5"
  spec.add_dependency "jbuilder", "~> 2.10.0"
  spec.add_dependency "openssl", "~> 2.2"
  
end
