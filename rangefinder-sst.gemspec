# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rangefinder/sst/version'

Gem::Specification.new do |spec|
  spec.name          = "rangefinder-sst"
  spec.version       = Rangefinder::SST::VERSION
  spec.authors       = ["Dirk Gadsden"]
  spec.email         = ["dirk@esherido.com"]
  spec.summary       = "Single-site tracking for Rangefinder"
  spec.description   = "Single-site tracking library for the Rangefinder web analytics app"
  spec.homepage      = "http://rangefinderapp.com"
  spec.license       = "New BSD"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", '~> 0'
  
  spec.add_dependency "addressable", '~> 0'
end
