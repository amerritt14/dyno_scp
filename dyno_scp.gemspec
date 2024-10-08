lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "./lib/dyno_scp/version"

Gem::Specification.new do |spec|
  spec.name        = "dyno_scp"
  spec.version     = DynoScp::VERSION
  spec.authors     = ["Andrew Merritt"]
  spec.email       = ["andrew.w.merritt@gmail.com"]

  spec.summary     = "Dyno SCP"
  spec.description = "Allows devs to scp files to server for Heroku apps"
  spec.homepage    = "https://github.com/amerritt14/dyno_scp"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files        = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|features)/}) }
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "rails"

  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "minitest", ">= 5.11"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rubocop"
end
