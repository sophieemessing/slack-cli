#!/usr/bin/env ruby

# Use the dotenv gem to load environment variables
# Use HTTParty to send a GET request to the channels.list endpoint
# Check that the request completed successfully, and print relevant information to the console if it didn't
# Loop through the results and print out the name of each channel

require 'prettyprint'
require 'awesome_print'
require 'httparty'
require 'dotenv'
Dotenv.load

require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  # TODO project

  workspace = Workspace.new

  puts ENV['SLACK_API_TOKEN']

  response = HTTParty.get('https://slack.com/api/users.list', query: {
    token: ENV['SLACK_API_TOKEN']
    })

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME