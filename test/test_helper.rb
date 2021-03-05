$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require 'salesforce_bulk'
require 'minitest/autorun'
require 'minitest/reporters'
require 'mocha/minitest'
require 'webmock/minitest'

Minitest::Reporters.use!([Minitest::Reporters::SpecReporter.new])

class Minitest::Test
  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/, '_')}".to_sym
    defined = method_defined? test_name
    raise "#{test_name} is already defined in #{self}" if defined
    if block_given?
      define_method(test_name, &block)
    else
      define_method(test_name) do
        flunk "No implementation provided for #{name}"
      end
    end
  end
end

def api_url(client)
  "https://#{client.login_host}/services/async/#{client.version}/"
end

def bypass_authentication(client)
  client.instance_variable_set('@session_id', '123456789')
  client.instance_variable_set('@login_host', 'na9.salesforce.com')
  client.instance_variable_set('@instance_host', 'na9.salesforce.com')
end

def fixture_path(file)
  File.expand_path("../fixtures/#{file}", __FILE__)
end

def fixture(file)
  File.new(fixture_path(file)).read
end
