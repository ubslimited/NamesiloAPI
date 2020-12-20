lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'namesilo_client/version'

Gem::Specification.new do |s|
  s.name        = 'namesilo_client'
  s.version     = NamesiloClient::VERSION
  s.date        = '2018-06-08'
  s.summary     = "Namesilo API client"
  s.description = "Namesilo API client is a wrapper of Namesilo REST APIs."
  s.authors     = ["Yuxi"]
  s.files       = ["lib/namesilo_client.rb"]
  s.homepage    = 'http://rubygems.org/gems/namesilo_client'
  s.license     = 'MIT'
  s.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.bindir        = "bin"
  s.executables << 'namesilo'

  s.add_runtime_dependency 'faraday', '~> 0.13'
  s.add_runtime_dependency 'addressable', '~> 2.5'
  s.add_runtime_dependency 'nokogiri', '~> 1.10'
  s.add_runtime_dependency "nori", "~> 2.6"
  s.add_runtime_dependency "thor", "1.0.1"
  s.add_development_dependency 'rspec', '~> 3.7'
end
