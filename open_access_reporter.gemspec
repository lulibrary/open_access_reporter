
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "open_access_reporter/version"

Gem::Specification.new do |spec|
  spec.name          = "open_access_reporter"
  spec.version       = OpenAccessReporter::VERSION
  spec.authors       = ["Adrian Albin-Clark"]
  spec.email         = ["a.albin-clark@lancaster.ac.uk"]
  spec.summary       = %q{Open Access Reporter.}
  spec.metadata = {
      'source_code_uri' => 'https://github.com/lulibrary/open_access_reporter'
  }
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]
  spec.add_development_dependency 'minitest-reporters', '~> 1.1'
  spec.add_dependency 'http', '~> 2.0'
  spec.add_dependency 'libdoi', '~> 1.0'
end
