# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lazy/attribute/version'

Gem::Specification.new do |spec|
  spec.name          = 'lazy-attribute'
  spec.version       = Lazy::Attribute::VERSION
  spec.authors       = ['Selva Chezhian', 'Saravanan Hari']
  spec.email         = %w(selvachezhian.labam@gmail.com sarhari@gmail.com)
  spec.summary       = %q{Minimizing find_by query for a single repeated attribute}
  spec.description   = %q{This gem provides a simple and extremely flexible way to use most frequent find_by query in a model.  You can minimize find_by query of a particular attribute in a model using lazy attribute gem.}
  spec.homepage      = 'https://github.com/selvachezhian/lazy-attribute'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'yard'

  spec.add_dependency 'activerecord', '~> 4.1'

  spec.has_rdoc = 'yard'
end
