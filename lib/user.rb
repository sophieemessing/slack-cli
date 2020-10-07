# user.rb
require 'httparty'
require 'prettyprint'
require 'dotenv'

Dotenv.load

class User < Recipient

  def initialize(real_name,status_text, status_emoji)
    super(slack_id,name)
  end


  def self.list_all
    response = HTTParty.get('https://slack.com/api/users.list', query: {
          token: ENV['SLACK_API_TOKEN']
      })

    users = response["members"]

    users.each do |user|
      p user["name"]
    end
  end
end