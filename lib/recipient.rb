require 'httparty'
require 'prettyprint'
require 'dotenv'

Dotenv.load

class SlackApiError < StandardError; end

class Recipient

  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url, params)
    return HTTParty.get(url, params)
  end

  def send_message(message)
    response = HTTParty.post(
        "https://slack.com/api/chat.postMessage",
        body:  {
            token: ENV['SLACK_API_TOKEN'],
            text: message,
            channel: @slack_id
        })
    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackApiError, "Error when posting #{message} to #{@name}, error: #{response.parsed_response["error"]}"
    end
  end
end