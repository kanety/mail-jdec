# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mail/jdec/version'

Gem::Specification.new do |spec|
  spec.name          = "mail-jdec"
  spec.version       = Mail::Jdec::VERSION
  spec.authors       = ["Yoshikazu Kaneta"]
  spec.email         = ["kaneta@sitebridge.co.jp"]
  spec.summary       = %q{A mail patch for decoding some improper mails}
  spec.description   = %q{A mail patch for decoding some improper mails}
  spec.homepage      = "https://github.com/kanety/mail-jdec"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "mail", ">= 2.8.0.rc1"
  spec.add_dependency "charlock_holmes", ">= 0.7.0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
