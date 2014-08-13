# coding: utf-8
#lib = File.expand_path("../lib", __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "./lib/poole/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-poole"
  spec.version       = Jekyll::PoolePlugin::VERSION
  spec.homepage      = "http://www.github.com/iamcarrico/jekyll-poole-tags"
  spec.authors       = ["Ian Carrico"]
  spec.email         = %w[github@iancarrico.com]
  spec.license       = "MIT"
  spec.summary       = "jekyll-poole-tags-#{Jekyll::PoolePlugin::VERSION}"
  spec.description   = <<-DESC
  A Jekyll plugin that allows the use of tags from Mr. Poole.
  DESC

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(/^bin\//).map { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll",    ">= 1.0.0", "< 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.6"
end
