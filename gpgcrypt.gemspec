# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gpgcrypt/version'

Gem::Specification.new do |gem|
  gem.name          = "gpgcrypt"
  gem.version       = Gpgcrypt::VERSION
  gem.authors       = ["TheNotary"]
  gem.email         = ["no@mail.plz"]
  gem.description   = %q{This gem is designed to allow you to manually encrypt/ decrypt RSA encoded messages using GnuPG.}
  gem.summary       = %q{This gem is designed to allow you to manually encrypt/ decrypt RSA encoded messages using GnuPG.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "gibberish"
  gem.add_dependency "thor"
	gem.add_development_dependency "rake"
	gem.add_development_dependency "rspec"
	gem.add_development_dependency "pry"
end
