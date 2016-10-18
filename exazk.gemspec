Gem::Specification.new do |s|
  s.name        = 'exazk'
  s.version     = '0.0.1'
  s.date        = '2016-10-18'
  s.summary     = 'ExaZK'
  s.description = 'ExaZK is simple L3 high availability plugin for ExaBGP'
  s.authors     = ['Donatas Abraitis']
  s.email       = 'donatas.abraitis@gmail.com'
  s.files       = ['README.md', 'exazk.gemspec', 'lib/exazk.rb']
  s.homepage    = 'http://rubygems.org/gems/exazk'
  s.license     = 'MIT'
  s.add_runtime_dependency 'zk'
  s.add_runtime_dependency 'json'
end
