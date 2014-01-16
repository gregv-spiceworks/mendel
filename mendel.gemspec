# -*- encoding: utf-8 -*-

require File.expand_path('../lib/mendel/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "mendel"
  gem.version       = Mendel::VERSION
  gem.summary       = %q{TODO: Summary}
  gem.description   = %q{TODO: Description}
  gem.license       = "MIT"
  gem.authors       = [""]
  gem.email         = ""
  gem.homepage      = "https://rubygems.org/gems/mendel"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rdoc', '~> 3.0'
  gem.add_development_dependency 'rspec', '~> 2.4'
end
