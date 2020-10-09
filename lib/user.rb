require 'httparty'
require 'prettyprint'
require 'dotenv'

require_relative 'recipient'

Dotenv.load

class User < Recipient

  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def self.list_all
    user_url = 'https://slack.com/api/users.list'
    response = self.get(user_url, query: { token: ENV['SLACK_API_TOKEN']})

    raise ArgumentError.new("invalid request") if response["ok"] == false

    users = response["members"]

    list = []
    users.each do |user|
      list << User.new(user["id"], user["name"], user["profile"]["real_name"], user["profile"]["status_text"], user["profile"]["status_emoji"])
    end
    return list
  end

  # def information
  #   return "#{self.name}, #{self.real_name}, #{self.slack_id}"
  # end

  def details
    return "\n username: #{self.name} \n real name: #{self.real_name} \n slack ID: #{self.slack_id} \n status: #{self.status_text} \n emoji: #{self.status_emoji}"
  end

end