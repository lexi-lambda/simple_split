# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_split/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_split'
  spec.version       = SimpleSplit::VERSION
  spec.authors       = ['Alexis King']
  spec.email         = ['alexis@gophilosophie.com']

  spec.summary       = 'Dead simple, database-free AB testing in Rails'
  spec.homepage      = 'https://github.com/lexi-lambda/simple_split'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.7.0'
  spec.add_development_dependency 'codeclimate-test-reporter'

  spec.add_runtime_dependency 'activesupport', '>= 3.0'
  spec.add_runtime_dependency 'weighted_randomizer', '>= 0.1.2'
end
