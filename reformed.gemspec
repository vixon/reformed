# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reformed/version'

Gem::Specification.new do |spec|
  spec.name          = "reformed"
  spec.version       = Reformed::VERSION
  spec.authors       = ["Jason Torres"]
  spec.email         = ["jason.e.torres@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"


  spec.add_dependency('railties', '>= 4.0.0', '< 4.1')
  spec.add_dependency('activemodel', '>= 4.0.0', '< 4.1')
  spec.add_dependency('actionpack', '>= 4.0.0', '< 4.1')
  spec.add_dependency('activesupport', '>= 4.0.0', '< 4.1')
end
