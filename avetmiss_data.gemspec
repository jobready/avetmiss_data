# -*- encoding: utf-8 -*-
require File.expand_path('../lib/avetmiss_data/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'avetmiss_data'
  s.version     = AvetmissData::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Brenton Fletcher', 'Jehanzeb Khan']
  s.email       = ['brentonf@jobready.com.au', 'jehanzebk@jobready.com.au']
  s.homepage    = 'http://github.com/jobready/avetmiss_data'
  s.summary     = 'Gem for parsing and building AVETMISS (NAT) Files'
  s.description = 'Parsing and building AVETMISS files'
  s.license       = 'MIT'

  s.required_rubygems_version = '>= 1.3.6'

  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'cane', '~> 2.6'
  s.add_development_dependency 'simplecov', '~> 0.7'
  s.add_development_dependency 'byebug', '~> 2.7'
  s.add_development_dependency 'rake', '~> 10.1'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.3'
  s.add_dependency 'activesupport', '3.2.17'

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
