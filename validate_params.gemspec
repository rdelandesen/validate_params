$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "validate_params/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "validate_params"
  s.version     = ValidateParams::VERSION
  s.authors     = ["Romain de Landesen"]
  s.email       = ["rdelandesen@gmail.com"]
  s.homepage    = "https://github.com/rdelandesen/validate_params"
  s.summary     = "Params validations for Ruby on Rails"
  s.description = "Params validations for Ruby on Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency "sqlite3"
end
