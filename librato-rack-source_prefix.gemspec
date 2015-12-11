# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'librato/rack/source_prefix/version'

Gem::Specification.new do |spec|
  spec.name          = 'librato-rack-source_prefix'
  spec.version       = Librato::Rack::SourcePrefix::VERSION
  spec.authors       = ['Brian DeHamer']
  spec.email         = ['brian@librato.com']
  spec.homepage      = 'https://github.com/librato/librato-rack-source_prefix'
  spec.license       = 'BSD 3-clause'

  spec.summary       = 'Automatic source prefixing for librato-rack'
  spec.description   = 'Applies a source prefix to any custom source names supplied when submitting metrics'

  spec.files = Dir["{lib}/**/*"]
  spec.files += ["LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  spec.require_paths = ['lib']

  spec.add_dependency 'librato-rack'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'

  spec.cert_chain = ["certs/librato-public.pem"]
  if ENV['GEM_SIGNING_KEY']
    spec.signing_key = ENV['GEM_SIGNING_KEY']
  end
end
