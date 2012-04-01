# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gembird-backend/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jens Bissinger"]
  gem.email         = ["mail@jens-bissinger.de"]
  gem.description   = %q{Wrapper around sispmctl script}
  gem.summary       = %q{Provides an API to control Gembird USB power strips}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gembird-backend"
  gem.require_paths = ["lib"]
  gem.version       = GembirdBackend::VERSION
  
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "yard"
  gem.add_development_dependency "rake"
  
end
