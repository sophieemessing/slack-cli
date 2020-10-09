# require 'simplecov'
# SimpleCov.start do
#   add_filter 'test/'
# end

require 'dotenv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'vcr'

require_relative "../lib/channel"
require_relative "../lib/user"
require_relative "../lib/workspace"


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes" # folder where casettes will be located
  config.hook_into :webmock # tie into this other tool called webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body], # The http method, URI and body of a request all need to match
  }

  # Don't leave our token lying around in a cassette file.
  config.filter_sensitive_data("<SLACK_API_TOKEN>") do
    ENV["SLACK_API_TOKEN"]
  end
end
