$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'fragmont/version'

Gem::Specification.new do |s|
  s.name     = "fragmont"
  s.version  = ::Fragmont::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["camertron@gmail.com"]
  s.homepage = "https://github.com/camertron/fragmont"
  s.license  = 'MIT'
  s.description = s.summary = "Font subsetting for the Rails asset pipeline."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'ttfunk', '~> 1.5'
  s.add_dependency 'railties', '>= 3.2'

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", "Gemfile", "CHANGELOG.md", "README.md", "Rakefile", "fragmont.gemspec"]
end
