# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dtracer/version'

Gem::Specification.new do |spec|
  spec.name          = "dtracer"
  spec.version       = DTracer::VERSION
  spec.authors       = ["Omar Abdelhafith"]
  spec.email         = ["o.arrabi@me.com"]
  spec.summary       = %q{DTracer is part ruby gem, part iOS pod, that helps the sending and receiving of DTrace commands..}
  spec.description   = %q{DTracer is part ruby gem, part iOS pod, that helps the sending and receiving of DTrace commands.
The `dtracer` gem will listen to the DTrace commands that are sent from the [OADTraceSender]() pod.}
  spec.homepage      = "http://nsomar.com/dtracer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_dependency "thor"
end
