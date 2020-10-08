require 'httparty'
require 'prettyprint'
require 'dotenv'

require_relative 'recipient'

Dotenv.load

class Channel < Recipient

  attr_reader :topic,:member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end
  def self.list_all
    channel_url = 'https://slack.com/api/conversations.list'
    response = self.get(channel_url, query: { token: ENV['SLACK_API_TOKEN']})

    channels = response["channels"]

    list = []
    channels.each do |channel|
      list << Channel.new(channel["id"], channel["name"], channel["purpose"]["value"], channel["num_members"])
    end
    return list
  end

  def information
    return "\n channel name: #{self.name} \n topic: #{self.topic} \n user count: #{self.member_count} \n slack_id: #{self.slack_id}"
  end

end

