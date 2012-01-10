$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "github_issues/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "github_issues"
  s.version     = GithubIssues::VERSION
  s.authors     = ["Elliot Larson, Steven Chanin"]
  s.email       = ["elliot@onehouse.net, schanin@devleverage.com"]
  s.homepage    = ""
  s.summary     = "Github Issues integration for Rails"
  s.description = "This gem adds a light weight jQuery UI interface to a Rails site which allows the submission of issues to the Github issue tracker via the Github API."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.1.3"
  s.add_dependency "github-v3-api"
  s.add_dependency 'sass-rails', "~> 3.1.4"
  s.add_dependency 'coffee-rails', "~> 3.1.1"
  s.add_development_dependency "sqlite3"
end
