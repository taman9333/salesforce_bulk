require "./lib/salesforce_bulk/version"

Gem::Specification.new do |s|
  s.name        = 'salesforcebulk'
  s.version     = SalesforceBulk::VERSION
  s.summary     = "Full capability support for the Salesforce Bulk API."
  s.description = "This gem is a simple interface to the Salesforce Bulk API providing full support for insert, update, upsert, delete, and query actions while allowing you to specify multiple batches per job to process data fast. Gem includes unit tests."

  s.author   = 'Javier Julio'
  s.email    = 'jjfutbol@gmail.com'
  s.homepage = 'https://github.com/javierjulio/salesforce_bulk'

  s.files         = `git ls-files lib README.md`.split("\n")

  s.required_ruby_version = '>= 2.3'

  s.add_dependency "xml-simple"

  s.add_development_dependency "rake"
  s.add_development_dependency "mocha"
  s.add_development_dependency "webmock"
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-reporters'
end
