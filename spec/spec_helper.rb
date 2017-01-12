$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'vcr'
require 'ldapr'
require_relative 'support/helpers'

require 'dotenv'

Dotenv.load('.env.test')

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.default_cassette_options = {
    record: :new_episodes,
  }
  c.hook_into :typhoeus
  c.configure_rspec_metadata!
  c.filter_sensitive_data('username') { ENV['LDAP_SERVER_USERNAME'] }
  c.filter_sensitive_data('username') { CGI.escape(ENV['LDAP_SERVER_USERNAME']) }
  c.filter_sensitive_data('password') { ENV['LDAP_SERVER_PASSWORD'] }
end

RSpec.configure do |c|
  c.include LDAPR::Helpers
end
