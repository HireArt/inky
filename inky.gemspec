lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inky/version'

Gem::Specification.new do |spec|
  spec.name          = 'inky'
  spec.version       = Inky::VERSION
  spec.authors       = ['Smudge']
  spec.email         = ['nathan@ngriffith.com']
  spec.summary       = "A ruby client for filepicker.io's REST API"
  spec.description   = "A ruby client for filepicker.io's REST API"
  spec.homepage      = 'http://github.com/smudge/inky'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'dotenv', '>= 1.0.0'
  spec.add_development_dependency 'rspec', '>= 3.2.0'
  spec.add_development_dependency 'webmock', '>= 1.20.0'
  spec.add_development_dependency 'vcr', '>= 2.9.0'
  spec.add_development_dependency 'codeclimate-test-reporter'

  spec.add_dependency 'addressable', '>= 2.2.0'
  spec.add_dependency 'rest-client', '>= 1.7.0'
  spec.add_dependency 'activesupport', '>= 3.0.0'
end
