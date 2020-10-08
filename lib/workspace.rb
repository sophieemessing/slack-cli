require 'httparty'
require 'dotenv'


require_relative 'user'
require_relative 'channel'

Dotenv.load

class Workspace

  attr_reader :users,:channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  def list_users
    user_data = []
    @users.each do |user|
      user_data << user.information
    end
    return user_data
  end

  def list_channels
    channel_data = []
    @channels.each do |channel|
      channel_data << channel.information
    end
    return channel_data
  end

  def select_channel
    @channels.find { |channel| channel["name"] = name }
    end
  end

  def select_user

  end

  def show_details

  end

  def send_message

  end

  def list_formatted

  end

end
