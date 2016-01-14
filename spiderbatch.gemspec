$:.push File.expand_path("../lib", __FILE__)
require 'spiderbatch/version'

Gem::Specification.new do |s|
  s.name          = 'spiderbatch'
  s.version       = SpiderBatch::VERSION
  s.authors       = [ 'Patrick Viet' ]
  s.email         = [ 'patrick.viet@gmail.com' ]
  s.description   = %q{Run commands on multiple servers with various reliability options}
  s.summary       = %q{no summary}
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'redis'
end
