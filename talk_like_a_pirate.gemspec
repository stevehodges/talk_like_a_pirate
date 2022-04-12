# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name         = 'talk_like_a_pirate'
  spec.version      = '0.2.3'
  spec.authors      = ['Steve Hodges']
  spec.email        = ['shodges317@gmail.com']
  spec.homepage     = 'https://github.com/stevehodges/talk_like_a_pirate'
  spec.summary      = 'Talk Like A Pirate'
  spec.description  = 'Add a pirate translation layer to your Rails app! Talk, like a Pirate!'

  spec.files        = `git ls-files`.split("\n")
  spec.test_files   = `git ls-files -- {spec}/*`.split("\n")

  spec.add_dependency 'activesupport', '>= 3.0.0', '< 8.0'
  spec.add_dependency 'i18n'

  spec.add_development_dependency 'appraisal', '~> 2.2'
  spec.add_development_dependency 'bundler',   '~> 1.9'
  spec.add_development_dependency 'rake',      '~> 12.3'
  spec.add_development_dependency 'rspec',     '~> 3'
  spec.require_paths = ['lib']
end
