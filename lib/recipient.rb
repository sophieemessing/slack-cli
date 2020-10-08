require 'httparty'
require 'prettyprint'
require 'dotenv'

Dotenv.load

class Recipient

  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url, params)
    return HTTParty.get(url, params)
  end
end