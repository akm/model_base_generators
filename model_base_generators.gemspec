# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'model_base/version'

Gem::Specification.new do |spec|
  spec.name          = "model_base_generators"
  spec.version       = ModelBase::VERSION
  spec.authors       = ["akm"]
  spec.email         = ["akm2000@gmail.com"]

  spec.summary       = %q{Provide generators for models with assocations.}
  spec.description   = %q{Provide generators for models with assocations.}
  spec.homepage      = "https://github.com/akm/model_base_generators"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # When you add dependency, add them to Gemfiles/*
  spec.add_runtime_dependency "rails"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'generator_spec'
end
