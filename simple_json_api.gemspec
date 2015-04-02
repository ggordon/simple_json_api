# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_json_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_json_api'
  spec.version       = SimpleJsonApi::VERSION
  spec.authors       = ['Gary Gordon']
  spec.email         = ['gfgordon@gmail.com']
  spec.summary       = 'A Simple JSON API Serializer.'
  spec.description   = 'A basic serializer implementing the JSON API spec.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^test\//)
  spec.require_paths = ['lib']
  spec.required_ruby_version = '~> 2.1'

  spec.add_dependency 'activerecord', '>= 4.0'
  spec.add_dependency 'json-schema'

  # spec.add_dependency 'activesupport', '>= 4.0'
  # spec.add_dependency 'railties', '>= 4.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
