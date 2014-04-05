$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "so_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "so_auth"
  s.version     = SoAuth::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SoAuth."
  s.description = "TODO: Description of SoAuth."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.4"

  s.add_development_dependency "sqlite3"
end
