# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'librato/rails/source_prefix/version'

Gem::Specification.new do |spec|
  spec.name          = 'librato-rails-source_prefix'
  spec.version       = Librato::Rails::SourcePrefix::VERSION
  spec.authors       = ['Brian DeHamer']
  spec.email         = ['brian@librato.com']

  spec.summary       = 'Automatic source prefixing for librato-rails'
  spec.description   = 'Applies a source prefix to any custom source names supplied when submitting metrics'
  spec.homepage      = 'https://github.com/librato/librato-rails-source_prefix'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'librato-rails', '~> 0.12.0.beta'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
end
