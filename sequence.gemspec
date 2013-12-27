# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sequence/version'

Gem::Specification.new do |spec|
  spec.name          = "sequence"
  spec.version       = Sequence::VERSION
  spec.authors       = ["dimas"]
  spec.email         = ["cartobus@gmail.com"]
  spec.description   = %q{generates a bunch of methods for 
                          class to make it act like sequence}
  spec.summary       = %q{sequence behavior generator}
  spec.homepage      = "https://github.com/emiltrotuar/sequence"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
