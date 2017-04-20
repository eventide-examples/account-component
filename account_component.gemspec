# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'account_component'
  s.version = '0.0.0'
  s.summary = 'Account Component'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-examples/account-component'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4.0'

  s.add_runtime_dependency 'eventide-postgres'
  s.add_runtime_dependency 'evt-try'

  s.add_development_dependency 'test_bench'
end
